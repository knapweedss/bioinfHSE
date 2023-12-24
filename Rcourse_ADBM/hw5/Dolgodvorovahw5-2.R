# ДЗ 5, Долгодворова Мария

# функция, находящая n-ый по величине элемент вектора

findNLargestVec = function(vec, n) {
  if (n > length(vec)) {
    stop("Vector len should be >= n")
  } else if (n < 0) {
    stop("n should be > 0")
  } else {
    return(sort(unique(vec), decreasing = TRUE)[n])
  }
}

# тестировала
findNLargestVec(c(1, 10, 0, 2, 2), 2) # 2
#findNLargestVec(c(100), 2) # Error in findNLargestVec(c(100), 2) : Vector len should be >= n
#findNLargestVec(c(0, 0, 0), -2) # Error in findNLargestVec(c(0, 0, 0), -2) : n should be > 0

# функция, рисующая множество Мандельброта, параметрами которой являются 
# диапазон значений в матрицах x и y, размер матриц и число итераций в пункте 3

plotMandelbrotSet = function(N, iter, x2, x3, y2, y3) {
  x0 = matrix(rep(seq(x2,x3,length.out = N), each =N ), ncol = N)
  x0[1:4, 1:4]
  y0 = matrix(rep(seq(y2,y3,length.out = N), times = N), ncol = N)
  y0[1:4, 1:4]
  
  x = x0
  y = y0
  
  for(i in 1:iter) {
    x_old = x
    x = x^2 - y^2 + x0
    y = 2*x_old * y + y0
  }
  
  z = t(abs(x^2 + y^2))
  z[!is.na(z)] = rank(z[!is.na(z)])
  return(image(z^3,col=rev(terrain.colors(1000))))
  
}

plotMandelbrotSet(1000, 20, -2, 1, -1, 1)


