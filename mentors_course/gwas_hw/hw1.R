library(data.table)
library(dplyr)
library(ggplot2)


head(fam <- fread('data/penncath.fam'))
(clinical <- fread('data/penncath.csv'))
bim <- fread('data/penncath.bim')
head(bim)

install.packages("bigsnpr")
library(bigsnpr)
library(bigstatsr) # a useful dependency of bigsnpr

snp_readBed("data/penncath.bed")

penncath <- snp_attach("data/penncath.rds")

# check out this bigSNP object 
str(penncath)

penncath$map$chromosome |> table()


class(penncath$genotypes)
?bigstatsr::big_counts

big_counts(penncath$genotypes, ind.row = 1:10, ind.col = 1:10)
snp_stats <- big_counts(penncath$genotypes)
dim(snp_stats) # 4th row has NA counts 
# [1]      4 861473
boxplot(snp_stats[4,]) 

sample_stats <- big_counts(penncath$genotypes, byrow = TRUE)

sample_stats[, 1:10]
boxplot(sample_stats[4,])


allele_dat <- sweep(x = sample_stats[1:3,], 
                    MARGIN = 1,
                    STATS = c(0, 1, 0),
                    FUN = "*") |> colSums()

boxplot(allele_dat/ncol(snp_stats))

hist(allele_dat/ncol(snp_stats),
     main = "Zygosity",
     xlab = "Proportion of samples which are heterozygous")

hist(snp_stats[1,])
summary(snp_stats[1,])



system("plink --bfile data/penncath --make-bed --out data/penncath_clean")
path_to_qc_penncath_bed <- snp_plinkQC(
  plink.path = "plink", # again, you may need to change this according to your machine!
  prefix.in = "data/penncath_clean", # input data
  prefix.out = "data/qc_penncath", # creates *new* rds with quality-controlled data
  maf = 0.01, # filter out SNPs with MAF < 0.01
  geno = 0.1, # filter out SNPs missing more than 10% of data
  mind = 0.1, # filter out SNPs missing more than 10% of data,
  hwe = 1e-10, # filter out SNPs that have p-vals below this threshold for HWE test
  autosome.only = TRUE # we want chromosomes 1-22 only
  
)




library(data.table)
library(dplyr)
library(bigsnpr)
library(ggplot2)
snp_readBed("data/qc_penncath.bed")
# create a bigSNP data object using data from PLINK files created in previous module 
# snp_readBed("data/qc_penncath.bed") # again, snp_readBed is a one-time thing
obj <- snp_attach("data/qc_penncath.rds")
# double check dimensions 
dim(obj$fam)
# [1] 1401    6
dim(obj$map) 
# [1] 696644      6
dim(obj$genotypes)
# [1]   1401 696644


snp_stats <- bigstatsr::big_counts(obj$genotypes)
# ^ bigstatsr is loaded with bigsnpr, just being explicit here for didactic purposes
colnames(snp_stats) <- obj$map$marker.ID
snp_stats[,1:5] # shows # of 0, 1, 2, and NA values for 1st 5 SNPs
#      rs12565286 rs3094315 rs2286139 rs2980319 rs2980300
# 0          1247       958      1018      1057       988
# 1           131       362       316       316       370
# 2             6        66        30        28        25
# <NA>         17        15        37         0        18

(any_missing <- sum(snp_stats[4,] != 0)) # shows # of SNPs with NA values 
# [1] 565138
call_rates <- colSums(snp_stats[1:3,])/colSums(snp_stats) 
head(call_rates)



obj$geno_imputed <- snp_fastImputeSimple(Gna = obj$genotypes,
                                         method = "mode",
                                         ncores = nb_cores())

# save imputed values 
obj$geno_imputed$code256 <- bigsnpr::CODE_IMPUTE_PRED

# look to see that imputation was successful:
imp_snp_stats <- big_counts(X.code = obj$geno_imputed)
imp_snp_stats[,1:5] # all 0s in NA row 

obj <- bigsnpr::snp_save(obj)

library(data.table)
library(dplyr)
library(bigsnpr)
library(ggplot2)

obj <- snp_attach("data/qc_penncath.rds")

svd_X <- big_SVD(obj$geno_imputed, # must have imputed data
                 big_scale(), # centers and scales data -- REALLY IMPORTANT! 
                 k = 10 # use 10 PCs for now -- can ask for more if needed
)
# Note: this can take a while to run (several minutes, depending on your
# machine). I'm going to save this SVD as an RDS object, and refer back to that in future use. 

saveRDS(svd_X, "data/svd_X.rds")



svd_X <- readRDS("data/svd_X.rds")

# look at what we have:
str(svd_X)

plot(svd_X)


clinical <- fread('data/penncath.csv') |>
  mutate(across(.cols = c(sex, CAD),
                .fns = as.factor))
dplyr::glimpse(clinical)

plot(svd_X, type = "scores") +
  aes(color = clinical$sex) +
  labs(color = "Sex")


# get K 
K <- big_tcrossprodSelf(X = obj$geno_imputed,
                        fun.scaling = big_scale())

saveRDS(K, 'data/K.rds')

K <- readRDS("data/K.rds")

install.packages("corrplot")
library(corrplot)
corrplot::corrplot(K[1:50, 1:50]*(1/ncol(obj$geno_imputed)),
                   is.corr = FALSE,
                   tl.pos = "n")

library(data.table)
library(dplyr)
library(bigsnpr)
library(ggplot2)


obj <- snp_attach("data/qc_penncath.rds")


clinical <- fread("data/penncath.csv")


obj$fam <- dplyr::full_join(x = obj$fam,
                            y = clinical,
                            by = c('family.ID' = 'FamID'))

# load principal components 
svd_X <- readRDS(file = "data/svd_X.rds")

# calculate the PCs                          
pc <- sweep(svd_X$u, 2, svd_X$d, "*")
dim(pc) # will have same number of rows as U
# [1] 1401   10
names(pc) <- paste0("PC", 1:ncol(pc))

# Fit a logistic model between the phenotype and each SNP separately
# while adding PCs as covariates to each model
obj.gwas <- big_univLogReg(X = obj$geno_imputed,
                           y01.train = obj$fam$CAD,
                           covar.train = pc[,1:5],
                           ncores = nb_cores())

# this takes a min or two, so I will save these results 
saveRDS(object = obj.gwas, file = "data/gwas.rds")

obj.gwas <- readRDS("data/gwas.rds")

viridis22 <- c(rep(c("#fde725", "#90d743", "#35b779", "#21918c", "#31688e", 
                     "#443983", "#440154"), 3), "#fde725")

manh <- snp_manhattan(gwas = obj.gwas,
                      infos.chr = obj$map$chromosome,
                      infos.pos = obj$map$physical.pos,
                      colors = viridis22)

(manh)



filtered_gwas <- obj.gwas[obj$map$chromosome == 17, ]
filtered_pos <- obj$map$physical.pos[obj$map$chromosome == 17]

manh <- snp_manhattan(
  gwas = filtered_gwas,
  infos.chr = rep(17, length(filtered_pos)), # Поскольку вы рассматриваете только одну хромосому
  infos.pos = filtered_pos,
  colors = viridis22
)
(manh)
