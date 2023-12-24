########################ФУНКЦИИ########################

f = function(...) print(list(...))
f(a=1, b=2)

plotSin = function(x) plot(x, sin(x))
plotSin(1:100/2)

plotSin = function(x, ...) {
  plot(x, sin(x), ...)
}
plotSin(1:100/2, type='l', col='red', lwd=3)

typeof(plotSin) # closure


# если функ принимает функ то обычно аргумент второй функ пишут капсом
myApply = function(x, FUN) {
  FUN(x)
}
myApply(1:10, mean)


funcs = list(mean, median, sd)
for (f in funcs) print(f(1:10))


powerFactory = function(p){
  f = function(x) x^p
  return(f)
}

p10 = powerFactory(10)
typeof(p10)

########################хуюнкции########################

1 + 2
'+'(1, 2) # + - тоже функ

x = 10:20
x
'['(x, 2:3)
x[2:3]

########################
sapply(mtcars, min)

f = function(x) rownames(mtcars)[which.min(x)]
sapply(mtcars, f)

sapply(mtcars, function(x) rownames(mtcars)[which.min(x)])

###########
x = runif(20)

ifelse(x>0.5, 'yes', 'no')

a = 1:20
ifelse(x>0.5, a, -a^2)

###########
m = matrix(rnorm(110, 10 + rep(1:10, each=11)))
m
m = matrix(rnorm(110, 10 + rep(1:10, each=11)), ncol=10) 
m

nf = apply(m , 2, mean)
nf

# вычет среднего по колонке
# из m вычитаем apply
nm = sweep(m , 2, nf, '-') 
nm
# то же самое
sweep(m , 2, apply(m , 2, mean), '-') 

?scale
scaleRows = function(m, center = TRUE, scale = TRUE){
  # сравнение с параметром фолсе
  if (center){
    m = sweep(m ,1, apply(m , 1, mean), '-')
  }
  if (scale){
    m = sweep(m ,1, apply(m , 1, sd), '/')
  }
  return(m)
}

scaleRows(m)
t(scale(t(m)))
plot(t(scale(t(m))), scaleRows(m))

########do.call()
l = list(1:10, pch=19, cex=3, col='red')
do.call(plot, l)

s = apply(m[, 1:5], 1, paste, collapse=',')
ss = strsplit(s, ',')
ss

do.call(rbind, ss)
do.call(rbind, lapply(ss, as.numeric))
#######
sex = ifelse(runif(20) > 0.5, 'm', 'f')
sex

sex = sample(c('m', 'f'), size = 20, replace = TRUE)
sex

height = ifelse(sex == 'm', rnorm(20, 185, 10), rnorm(20, 165, 10))
height
sh = split(height, sex)
sh

boxplot(height ~ sex)
boxplot(sh)
boxplot(sh[c('m', 'f')])

sapply(sh, mean)

data = data.frame(sex=sex, height=height, age = runif(20, 15, 75))
head(data)

# разбиение по полу
sh = split(data, data$sex)
sh

lapply(sh, function(x) x[which.max(x$height), ])
sapply(sh, function(x) x[which.max(x$height), ])

do.call(rbind, lapply(sh, function(x) x[which.max(x$height), ]))

data.max = do.call(rbind, lapply(sh, function(x) {
  r = x[which.max(x$height), ]
  r$n = nrow(x)
  return(r)
  }))
  
data.max

datam = as.matrix(data)
datam
split(datam, datam[,1]) # сплит с матрицами по говну идет

split.data.frame(datam, datam[,1])

##########ПАРАЛЛЕЛЬНОСТЬ#######

install.packages('plyr')
install.packages('doMC')
install.packages('doParallel')

library(plyr)
# первые две буквы - тип принимаемых и возвращаемых значений
?plyr
llply(baseball, typeof)

laply(baseball, typeof)


m = matrix(rnorm(1e5), ncol = 5)
a = aaply(m, 1, mean, .progress='text')
par(mar = c(1, 1, 1, 1))
par(mfrow=c(4,3))
l_ply(mtcars, plot, col = 'red', pch=19, cex=1)

library(doMC)
registerDoMC(4)
system.time(l_ply(1:100, function(i) mean(rnorm(1e6))))
system.time(l_ply(1:100, function(i) mean(rnorm(1e6)), .parallel = TRUE))

library(doParallel)
nodes = detectCores()
cl = makeCluster(nodes)
registerDoParallel(cl)
system.time(l_ply(1:100, function(i) mean(rnorm(1e6))))
system.time(l_ply(1:100, function(i) mean(rnorm(1e6)), .parallel = TRUE))


#########
install.packages("dplyr")
library(dplyr)
sin(pi)
pi %>% sin

sqrt(exp(sin(2)))

2 %>% sin %>% exp %>% sqrt

#############
######### 
N = 1000
seq(-2, 1, length.out = N) #генерит значения от 0 до 1 #each=N восторяет N раз
x0 = matrix(rep(seq(-2, 1, length.out = N), each=N), ncol=N)
x0
x0[1:4, 1:4]
# each 1 1 1 2 2 2# time 1 2 3 1 2 3 каждый элемент подрят делает N раз
y0 = matrix(rep(seq(-1, 1, length.out = N), times=N), ncol=N)
y0[1:4,  1:4]
x = x0
y = y0

###3)
for (i in 1:20) {  
  x_old = x
  x = x^2 - y^2 + x0  
  y = 2*x_old*y + y0
}
z = t(abs(x^2 + y^2))
z[!is.na(z)] = rank(z[!is.na(z)])
image(z^3,col=rev(terrain.colors(1000)))