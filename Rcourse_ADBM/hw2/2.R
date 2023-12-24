data = read.table('hw1.txt')
head(data)

shapiro.test(data[, 3])$p.value

plot(data)

plot(data[, 1], data[, 2])
cor.test(data[,1], data[,2])$p.value

abline(lm(data[, 2] ~ data[, 1]), col='blue') # правильно. y = x
abline(lm(data[, 1] ~ data[, 2]), col='red') # неправильно

q = 10
text(paste('подпись', q), x=100, y=100)

boxplot(data, notch=TRUE)

t.test(data[, 1], data[, 2], paired=TRUE)
t.test(data[,1] - data[,2])

t = predict(lm(data[, 2] ~ data[, 1]), interval='confidence')
t[1:3,]


####
a = 5
length(a)
a = 'hello'
a
length(a)

# ЭТО ИМЯ!!!!!
a.b = 67
a.b

a = c(1, 3, -5)
length(a)

a[2] = 100
a

c = 5
c

num = c(1, 2, 3)
typeof(num)

num.int = c(1L, 2L, 3L)
typeof(num.int)

i = 1:10
typeof(i)
i

log.var = c(TRUE, FALSE, FALSE)
typeof(log.var)

char.var = c("rdyui", 'sxdctfgvbhunj')
typeof(char.var)

a = c(123, "rfgygkjgh", 53L)
typeof(a)
a

a = c(TRUE, "qweqw")
a

a = c(TRUE, 2123)
a

####
TRUE
FALSE
T
F

T = FALSE
T

T = TRUE

1/0
c(Inf, 3)

# NaN
log(-1)

NA

NULL

length(NA)
length(NULL)

x = 1:10
x[4] = NA
x
x[4] = NULL
x

x = integer(10)
x
x = character(10)
x
x[] = 8
x
x = 8
x

#####
n = c('1', '3', '4.5678')
n
as.numeric(n)
as.character(TRUE)
as.character(5:50)
as.integer(1.7)
round(1.7)

####
1 + 1
1 + TRUE
1 + FALSE
10 * TRUE
10 * FALSE

TRUE + TRUE

1 + "10"

####
# +, -, *, /, ^
2**3
2^3

sqrt(9)
7 %% 2
7 %/% 2
7 / 2

2 > 1
2 > 5
2 == 2
'3' == 3
3 != 2
2 != 2

x = 10
x > (x + 1)

T | F
T & F

x = 10
(2 < x) & (x > 5)

####
x = 1:5
y = c(10, 10, 10, 13, 15)
x
y
x + y
x * y
x - y

x^2
x + 10

x
10:12
x + 10:12

###
x
length(x)
x[10]
x
x[10] = 100
x
x[c(-1, -6)]

x = 1:5
x > 3
x[x > 3]

mask = c(T, F)
x[mask]
x[c(T, F)]

###
x = c(a=5, b=19, c=34, b=76)
x
x['a']
x['b']
names(x)
names(x) = NULL
x

x = 1:10
attr(x, 'new') = "qweqwe"
x
attr(x, 'names') = c('a', 'b', 'c', 'd')
x
names(x) = letters[1:10]
x
letters
LETTERS

######
x = 1:10
x
x[2]

x[c(1, 2, 3, 2, 2, 2)]
x[-5]
x[c(-3, -7)]

sin(x)
sinx = sin(x)
x[sinx > 0]
x[sin(x) > 0]

sinx[sinx > 0][1]

x[which(x > 5)]
x[x > 5]

####
x = c(asx=5, b=19, c=76, b=76)
t = table(x)
t
t[t > 1]
x[names(x)=='b']

###
set.seed(123)
a = runif(100, 0, 5)
a

sort(a)
sort(a, decreasing = TRUE)

y = sin(a)
a
y
plot(a, y)
plot(a, y, type='l')

o = order(a)
o
plot(a[o], y[o], type='l')

####
x = 2
x
x <- 2
x

x < -2
x <- 2
x < 2

x <-5
x
#=========

####
1 + NA
TRUE | NA
TRUE & NA

x = c(T, F, NA)
x
all(x)
any(x)
sum(x)

x = 1:5
sum(x)

x = c(1, 2, 3, 3, 3, 4, 5)
y = c(1, 3, 2, 100)
x %in% y
x[x %in% y]

intersect(x, y)

x = 1:10
cumsum(x)

factorial()

runif(1000, 0, 0.1)


#### практика ####
x = runif(1, -5, 5)
sin(x)

k = 0:10
mysin = (-1)^k * (x^(2*k + 1) / factorial(2*k + 1))
mysin
mysin = cumsum(mysin)
mysin

sin(x)

plot(mysin, type='l')
abline(h=sin(x), col='red')

plot(abs(mysin - sin(x)), log='y')
