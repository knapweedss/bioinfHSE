# сем 3

sex = c('m', 'm', 'f', 'f')
sex
sex1 = factor(sex)
sex1


as.factor(sex) # то же самое но типа быстрее

sex2 = factor(sex, levels=c('m', 'f', 'u'))
sex2

sex1
sex1[1]

table(sex[1:3])

table(as.character(sex2))
table(sex2)


typeof(sex1)
attributes(sex1)
unclass(sex1)

d = factor(c('10', '5')) # 
d
as.numeric(d) # числа которые в факторе хранятся как индексы

as.numeric(as.character(d)) # чтобы сохранить эти штуки как числа 
is.factor(sex1) 

##############################СПИСКИ###############
# списки полезны в первую очрередь возможностью хранить одновременно числа и строки

x = list(1, 2, 'jopa')
x
# можно делать двухмерный список
x = list(c(1, 2, 3), c('qwe, TRUE'))
x = list(c(1, 2, 3),  'оооаоаа')


x = list(abc=1, l='d', c(1, 2, 3), c(T, F))
x

# str это структура))))
typeof(x)
str(x)

x$num
x$ltr
x[1]
x[2]
x[c(1, 2, 3)]

x = list(abc=1:3, l='d', c(1, 2, 3), c(T, F))

x[1]
# "достал из коробк"
x[[1]]

# элемент по индексу
# x[1][2] -> будет говно
x[[1]][2]

######################## матрицы блять #############
matrix(1, ncol=3, nrow=4)

a = matrix(1:9, ncol=3)
# чтобы умножить как матрица на матрицу херачим так
a%*%a

matrix(1:9, ncol=3) # по колонком
matrix(1:9, ncol=3, byrow=T) # построчно

length(a)
typeof(a)

dim(a)

a = matrix(1:12, ncol=4)
colnames(a) = c('a', 'b', 'c', 'd')
rownames(a) = c('a1', 'b2', 'c3')


x = 1:10
dim(x) = c(2, 5) # указал в какую форму влезт ь бляяя

# НЕ ХОЧЕТ :333333333
#dim(x) = c(2, 3) 
#dim(x) = c(2, 6) 

a
a[1:2,] # извлечь первые две строки
a[,1:2] # извлечь первые два столбца
a[c(1, 3), c(1, 1)]
#a[c('r1','r3'), c('a1','b2')]

r = a[2,] # становится вектором и нахуй размерность пропадает
dim(r)
class(r)
class(a)
# не меняй нихуя
r = a[2,, drop=FALSE]
dim(r)
class(r)
class(a)

a > 5 # ой блин прикол!!
which(a > 5) # индекс
which(a > 5, arr.ind=T) # в какой строке в каком столбце удовлетворяет условию

#################ДАТАФРЕЙЙЙЙМ#########
x = data.frame(a=1:3, b=c(T, T, F), c=c('a', 'b', 'c'))
x
cbind(a=1:3, b=c(T, T, F), c=c('a', 'b', 'c'))

rownames(x) = c('r1', 'r2', 'r3')

x 

# а вот колонки можем записывать с одинаковыми лейблами но зачем и главное нахуя
colnames(x) = c('a', 'b', 'c')
dim(x)
nrow(x)
ncol(x)

x[2:3,]
x[,1] > 1
x[x[,1] >1, c('b', 'a')]

x$b # колонки берем
x[, 'b'] # если колокни то вторым хуярим

x[1, ] # взяли первую строку
x[, 1, drop=FALSE]

as.matrix(x) # в строки

x$d = 0 # аоявится колонка д щаполненная нулями и 
x
x$e = 1:3
x

plot(a[1, ])


dfa = as.data.frame(a)
dfa
plot(dfa[1, ]) ### ептить колотить это че бля
plot(as.numeric(dfa[1, ])) #  норм


#############ЭПЛАИ##############

# к каждому иксу херачим тайп оф
lapply(x, typeof) 

sapply(x, typeof) # по умолчанию вектор

l = list(1:3, F, 'a')
l

sapply(l, typeof)
sapply(l, length)
sapply(l, max)
lapply(l, max)

sapply(1:10, sqrt)

a
apply(a, 1, sum) # сумма по строчкам

apply(a, 2, sum) # сумма по столбцам (1 и 2 это измерения)

###############задания#############

# №1

persData =  data.frame(a=c(10, 30, 20),
                       b=c('Галя', 'Петя', 'Люда'), 
                       e=c('Галкина', 'Печенкин', 'Людкина'), 
                       f=c('f', 'm', 'f'))

colnames(persData) = c('age', 'name', 'surname', 'gend')


persData[persData$gend == 'm',]
persData$name 

# №2
#a = matrix(0:24, ncol=5)
m = matrix(runif(120, 36, 50), nrow=24, ncol=5)
m

colnames(m) = c('a', 'b', 'c', 'd', 'e')
which(m[, 2] > 40)

#paste0 - делает разделитель пустым paste(5, 'h')

# № 3

x = rnorm(100, -1, 3)
#x = runif(100, -1, 3)
x[sin(x) > 0]
m  = matrix(x, ncol=10)
m
m[m[, 6] > 1]
m[, apply(m , 2, min) < -0.5]

# для дз чето прочитать про дисперсию ебана - sd еще прочитать