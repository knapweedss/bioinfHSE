# переменные в R - это вектор
# --> у всего можно узнать длину

a = 'hello'
length(a) # длина 1 

a = c(1, 2, -5) # c - создает вектор
length(a)

typeof(a)


numInt = c(1L, 2L, -5)
typeof(numInt)

i = 1:10
typeof(i)

log.var = c(TRUE, TRUE, FALSE)
typeof(log.var)

# boolean -> int -> double -> char

log.var = c(TRUE, 'TRUE')
log.var

#######
TRUE
FALSE
T
F

T = 'hehe' 

1/0
c(Inf, 3)
log(-1)

length(NA)
length(NULL)

x = integer(10)
x


x = character(10)
x

x[2:8] = 8
x

x = 8
x


x = character(10)
x

as.numeric(x)
as.character(1:4) # может быть полезно если файлы заиндексированы строками

as.integer(1.7)
typeof(round(1.3))
round(1.3)


1 + TRUE

10 * TRUE
10 * FALSE

########### +, -, *, /, ^

2**3
2^3
n = 10
n++
n
3 == '3'

x = 10
x > (x + 1)


T | F
T & F

(x + 1) & (x - 1)

x = 1:2
y = c(10, 10, 10, 13, 12)

x + y # поэлементное сравнение, зациклил то что было меньшей длины

########
x[10] = 100
x
x[c(-1, -6)]

mask = c(T, T, F, F, T )
x[mask]

#### атрибуты

x = c(a=5, b=3, b=98)
x
x['a']
x['b']
names(x)
names(x) = NULL
x

m = 1:10
attr(m, 'new') = 'аоаоаоа'
attr(m, 'new') = c('a', 'a', 'b')


letters
LETTERS

###########
x = 1:100

x[c(1, 2, 2, 2, 2)]
x[-5]
x[c(-3, -8)]

tan(x)
sinx = sin(x)
x[sinx>0]

sinx[sinx > 0][1] # можно так же фигачить индексацией

x[which(x > 5)]

############
x = c(a=5, b=3, b=98)
t = table(x) # сколько  раз встретилось значение
t[t >0] # выведи ток те значения что больше единицы

#### 
a = runif(100, 0, 5)  # 1 arg - quantity, 2 - min, 3 - max --> 100 чисел от нуля до пяти
sort(a)
set.seed(123) # ядро генерации рандомных значений 

sort(a, decreasing = TRUE)


y= sin(a)
plot(a, y)
plot(a, y, type='l')


o = order(a) # сорт но выдача индексов
plot(a[o], y[o], type='l')

#################




