first = list('a')
second = list('b', 'c')
third = list('d')
fourth = list('e')

left = list(first, second)
right = list(third, fourth)
root = list(one, two)

#####

mtcars
class(mtcars[,2])
typeof(mtcars[,2])

#########

vec = rnorm(100, 40, 10)
vec
vec_int = sapply(vec, as.integer)
vec_int
vec_even = vec_int[vec_int %% 2 == 0]
vec_even

vec

vec[trunc(vec) %% 2 == 0]

vec[floor(vec) %% 2 == 0]

### if ####
x = runif(1)
x

if (x > 0.5) {
    print(paste(x, '> 0.5'))
} else {
    print(paste(x, '<= 0.5'))
}

if (x > 0.5) print(1) else print(2)

x = runif(1)
if (x < 0.2) {
    print(1)
} else if (x < 0.7) {
    print(2)
} else if (x < 0.9) {
    print(3)
} else {
    print(4)
}

if (x < 0.2) {
    print(1)
}
if (x < 0.7) {
    print(2)
}
if (x < 0.9) {
    print(3)
}
print(4)

######

for (i in 1:5) {
    print(i)
}

mtcars
for (c in mtcars) {
    print(c)
    print(summary(c))
}

######

Sys.time()

if (Sys.time() > 123456) {
    print('too late')
}

a = Sys.time()
Sys.sleep(2) # 2 секунды бездействия
Sys.time() - a

#######

d = rnorm(10000000)
d = rnorm(1e7)
v = numeric(length(d))

system.time({
    for (i in 1:length(d)) {
        v[i] = d[i] + d[i]
    }
})

v = numeric(length(d))
system.time({
    v = d + d
})

#### функции ######

my.rbinom = function(n, p=0.5) {
    x = sum(runif(n, min=0, max=1) < p)
    return(x)
}

my.rbinom = function(n, p=0.5) {
    sum(runif(n, min=0, max=1) < p)
}

abc = my.rbinom(100)
abc

my.rbinom(100, 0.3)
my.rbinom(0.3, 100)

my.rbinom(n=100, 0.7)
my.rbinom(100, p=0.7)
my.rbinom(p=0.7, 100)

x = 10
a = 5

myFun = function(x) {
    print(a)
    a = 100
    x = paste(a, x)
    return(x)
}

myFun(x)
paste(a, x)

x = myFun(x)
x
paste(a, x)

##########

a = 4
b = 5
c = 6

x = print(c(a, b, c))
x

x = paste(a, b, c, sep='@')
x

x = cat(a, b, c, sep='qwe')
x

#######

f = function(abc, abd, ttt) cat(abc, abd, ttt)

f(1, 2, 3)

f(ttt=123, abc=12, 0)
f(t=5, 1, 2)
f(abc=123, ab=3, 56)
f(2, ab=2, 2)

plot(1:10, 2:11, pch=3, t='o')

##### классы ###########
x = 1:10
length(x)
class(x)

class(x) = 'my'
class(x)

# length.my = function(x) {
#     runif(1)
# }
length.my = function(n) runif(1)
length(x)

y = 5:15
class(y) = 'my'
length(y)

class(x) = "integer"
class(x)
length(x)
length(y)
typeof(y)

t = table(floor(runif(100, 0, 10)))
t
floor(-2.8) # округл вниз
trunc(-2.8) # отбрасываем дробную часть
ceiling(2.1) # округл вверх
round(2.6) # мат округление

plot(t)

t = table(floor(runif(100, 0, 10)),
          floor(runif(100, 0, 10)))
t
plot(t)
?plot
class(t)
?plot.table

x = 1:10
y = x^2
m = lm(y ~ x)
plot(m)
class(m)
?plot.lm

#### строки ####

text = c('hello', 'world')
substr(text, 2, 4)
strsplit(text, 'l')
strsplit(text, 'o')
strsplit(text, 'e|o')
strsplit(text, '')

paste('a', 'b')
paste('a', 'b', sep='')
paste0('a', 'b')

paste(text, collapse = '|')

paste(text, 1:2)
cat(text, 1:2)

text
grep('o', text)
grep('w', text)
grepl('w', text)

nchar(text)
text[grepl('w', text) & nchar(text) > 4]

nchar('wertyu')
nchar('qwe')

gsub('hel', 'by', text)

# за регулярными выражениями в гугл

###########
install.packages('ape')
library(ape)

# ape::nj
# nj

t = nj(matrix(rnorm(100, 1:10), ncol=10))
t
plot(t)
class(t)
?plot.phylo

plot.phylo(t, type='fan')

# https://www.bioconductor.org/
BiocManager::install("edgeR")

install.packages('devtools')
devtools::install_github("plotly/plotly")

######

my.factorial = function(n) {
    if (n < 0) {
        return(NA)
    }
    
    r = 1
    for (i in 1:n) {
        r = r*i
    }
    
    return(r)
}

factorial(10)
my.factorial(10)

my.f = function(n) {
    if (n == 1) {
        return(1)
    }
    
    return(n * my.f(n-1))
}

my.f(10)
