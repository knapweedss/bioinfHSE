# Долгодворова Маша, ДЗ № 4

install.packages('ape')
library(ape)

# скачиваем файл
a = "https://raw.githubusercontent.com/knapweedss/Rcourse_ADBM/main/hw4/"
file = "sequence.fasta"
URL = paste0(a, file)
download.file(URL, file)

# читаем
genome = read.dna("sequence.fasta", format = "fasta")
genome[1:3]


# последовательность в виде строки
g = genome[-1]
gene = paste(g, collapse='')
length(gene)


# делим на части
kmers = substring(gene, seq(1, (nchar(gene) - 5), 1), seq(6, nchar(gene), 1))
length(kmers)

# самые редкие
sort(table(kmers))[1:2]

# самые частотные
sort(table(kmers), decreasing = TRUE)[2:1]