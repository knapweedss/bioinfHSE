install.packages("ape")
library(ape)

data = ape::read.dna('sequence.fasta', format = 'fasta')
data = paste(as.character(data), collapse = '')

typeof(data)
substr(data, 1, 100)
#data

kmer = substring(data, 1:(nchar(data) - 5), 6:nchar(data))
head(sort(table(kmer)), 2)
head(sort(table(kmer), decreasing = TRUE), 2)
tail(sort(table(kmer)), 2)

#install.packages("plyr")
#install.packages("doMC")
#install.packages("dplyr")
#install.packages("doParallel")
############

f = function(...) print(list(...))
f(a=1, b=2)

plotSin = function(x) plot(x, sin(x))
plotSin(1:100/2)
plotSin = function(x, ...) {
    plot(x, sin(x), ...)
}
plotSin(1:100/2, type='l', col='red', lwd=3)

typeof(plotSin)

myApply = function(x, FUN) {
    FUN(x)
}
myApply(1:10, mean) # mean(1:10)

funcs = list(mean, median, sd)
for (f in funcs) print(f(1:10))

mean(1:10)
median(1:10)
sd(1:10)

powerFactory = function(p) {
    f = function(x) x^p
    return(f)
}
pow10 = powerFactory(10) # function(x) x^10
pow10(2)
typeof(pow10)

#############

1+2
"+"(1,2)
x=10:20
x
"["(x,2:3)
x[2:3]

###########

sapply(mtcars, min)

f = function(x) rownames(mtcars)[which.min(x)]
sapply(mtcars, f)
sapply(mtcars, function(x) rownames(mtcars)[which.min(x)])
rownames(mtcars)[sapply(mtcars, which.min)]

sapply(mtcars, function(x) exp(mean(log(x))))

###############

x = runif(20)
x
ifelse(x>0.5,"yes", "no")
ifelse(x>0.5, 1, 0)
a = 1:20
ifelse(x>0.5, a, -a^2)

############

m = matrix(rnorm(110, 10 + rep(1:10, each=11)), ncol=10)
m
nf = apply(m, 2, mean)
nf

nm = sweep(m, 2, nf, '/')
nm

nm = sweep(m, 2, nf, '-')
nm

sweep(m, 2, apply(m, 2, mean), '-')

?scale

scaleRows = function(m, center=TRUE, scale=TRUE) {
    if (center) { # center == TRUE
        m = sweep(m, 1, apply(m, 1, mean), "-")
    }
    if (scale) {
        m = sweep(m, 1, apply(m, 1, sd), "/")
    }
    return(m)
}
scaleRows(m)
t(scale(t(m)))
plot(t(scale(t(m))), scaleRows(m))

#############

do.call()

l = list(1:10, pch=19, cex=3, col='red')
do.call(plot, l)

m[,1:5]
s = apply(m[,1:5], 1, paste, collapse=",")
s

ss = strsplit(s, ',')
ss

rbind(ss[[1]], ss[[2]], ss[[3]])

do.call(rbind, ss)
do.call(rbind, lapply(ss, as.numeric))

do.call(rbind, lapply(strsplit(s, ','), as.numeric))
m[,1:5]

##################

sex = ifelse(runif(20) > 0.5, 'm', 'f')
sex

sex = sample(c('m', 'f'), size=20, replace=TRUE)
# prob=c(0.3, 0.7) - можно указывать свои вероятности
# для каждого значения
sex

height = ifelse(sex=='m', rnorm(20, 185, 10),
                          rnorm(20, 165, 10))
height
sex

sh = split(height, sex)
sh
str(sh)

boxplot(height ~ sex)
boxplot(sh)
boxplot(sh[c('m', 'f')])

sapply(sh, mean)
wilcox.test(sh$f, sh$m)

data = data.frame(sex=sex, height=height,
                  age=runif(20, 15, 75))
data

sh = split(data, data$sex)
sh

lapply(sh, function(x) x[which.max(x$height),])
sapply(sh, function(x) x[which.max(x$height),])
do.call(rbind, lapply(sh, function(x) x[which.max(x$height),]))

data.max = do.call(rbind, lapply(sh, function(x) {
    r = x[which.max(x$height),]
    r$n = nrow(x)
    return(r)
}))
data.max

data
datam = as.matrix(data)
datam
split(datam, datam[,1])
split.data.frame(datam, datam[,1])

###############

install.packages('plyr')
install.packages('doMC')
install.packages('doParallel')

library(plyr)
?plyr

baseball
llply(baseball, typeof)
laply(baseball, typeof)

m = matrix(rnorm(1e5), ncol=5)
a = aaply(m, 1, mean)
a
a = aaply(m, 1, mean, .progress='text')

par(mfrow=c(3,3))
l_ply(1:9, plot, col='red', pch=19, cex=1)

par(mfrow=c(4,3))
l_ply(mtcars, plot, col='red', pch=19, cex=1)

### 1 ###
library(doMC)

registerDoMC(3)
system.time(l_ply(1:100, function(i) mean(rnorm(1e6))))
system.time(l_ply(1:100, function(i) mean(rnorm(1e6)),
                  .parallel = TRUE))

### 2 ###
library(doParallel)

#nodes = detectCores()
#cl = makeCluster(nodes)
cl = makeCluster(3)
registerDoParallel(cl)
system.time(l_ply(1:100, function(i) mean(rnorm(1e6))))
system.time(l_ply(1:100, function(i) mean(rnorm(1e6)),
                  .parallel = TRUE))

stopCluster(cl)

###########

install.packages("dplyr")
library(dplyr)

sin(pi)
pi %>% sin

sqrt(exp(sin(2)))
2 %>% sin %>% exp %>% sqrt

############
