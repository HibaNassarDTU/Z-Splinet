#-------------------------------------------------------#
#--- Generating the deriviative functions of Z splines ---#
#-------------------------------------------------------#
k = 3 # order
N = 3 # support level
n_so =  (2^N - 1)*(k + 1) - k # number of splines in a dyadic structure with N and k
#n_knots = n_so - k + 1 # number of knots
xi = seq(0, 1, length.out = n_so)

ZB= Zsplinet(knots, k, norm = T) # generating the Z-spline basis
der_ZB = deriva(ZB$bs) # generating the derivative of the Z-spline basis

plot(der_ZB) # plotting the derivative of the Z-spline basis
