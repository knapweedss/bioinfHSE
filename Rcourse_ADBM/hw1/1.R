print('hi')
?mean

# part 1
d = rnorm(300)
d[100:110]
plot(d)
summary(d)
mean(d)
sd(d)
hist(d)
plot(density(d))

# part 2
x = -40:40 / 10
x
x = seq(-4, 4, by=0.25)
x
lines(x, dnorm(x), col='red')

# part 3
length(d)
y = rnorm(length(d), mean=d + 1, sd=abs(d))
head(y)
head(d)
d = cbind(d, y)
head(d)
plot(d[,1], d[,2], xlab='original data',
            ylab='new data', main='Plot')

m = lm(d[,2] ~ d[,1])
abline(m, col='red', lwd=3)

boxplot(d)
hist(d[,1])
hist(d[,2])

par(mfrow=c(1, 3))
boxplot(d)
plot(density(d[,1]), col='red')
lines(density(d[,2]), col='blue')

plot(density(d[,1]), col='red', ylim=c(0, 0.6))
lines(density(d[,2]), col='blue')

# stat tests
t.test(d[,1], d[,2])
wilcox.test(d[,1], d[,2])

table(d[,1] > 0)
table(d[,2] > 0)
t = table(d[,1] > 0, d[,2] > 0)
t

fisher.test(t)

cor(d[,1], d[,2])
cor.test(d[,1], d[,2])

# files
getwd()
dir.create("/home/arvo/Documents/R/1/tmp")
setwd("/home/arvo/Documents/R/1/tmp")
getwd()

write.table(d, 'data.txt')

ls()
rm(d, m, t, x)
ls()
gc()
d

d = read.table('data.txt')
d[1:3,]

pdf('test.pdf', width=6, height=4)
plot(d)
dev.off()

save(d, y, file="all.Rdata")
rm(d, y)
load("all.Rdata")
head(d)

saveRDS(d, 'd.rds')
rm(d)
data = readRDS('d.rds')
head(data)
