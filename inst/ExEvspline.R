#-------------------------------------------------------#
#--- Evaluate Z splines ---#
#-------------------------------------------------------#
k = 3 # order
N = 3 # support level
n_so =  (2^N - 1)*(k + 1) - k # number of splines in a dyadic structure with N and k
#n_knots = n_so - k + 1 # number of knots
xi = seq(0, 1, length.out = n_so)

ZB= Zsplinet(knots, k, norm = T) # generating the Z-spline basis
y = evspline(ZB$bs) # generating the derivative of the Z-spline basis

plot(y[,1:2],type = 'l',col='red')
points(y[,c(1,7)],type = 'l',col='blue')
points(y[,c(1,15)],type = 'l',col='green')
