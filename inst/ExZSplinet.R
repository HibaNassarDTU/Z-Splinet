#----------------------------------------#
#----Z-splinet, equally spaced knots-----#
#----------------------------------------#
k=2 # order
n_knots = 8 # number of knots
xi = seq(0, 1, length.out = n_knots)

so = Zsplinet(xi, k)

plot(so$bs) #Plotting Z-splines
plot(so$os) #Plotting Z-splinet

#Verifying the orthogonalization
gm = gramian(so$os) #evaluation of the inner products
diag(gm)
sum(gm - diag(diag(gm)))

plot(so$bs,type="simple",vknots=FALSE,lwd=3) #Plotting Z-splines in a single simple plot
plot(so$os,type="simple",vknots=FALSE,lwd=3) 

plot(so$os,lwd=3,mrgn=2) #Plotting the Z-splinet on the dyadic net of support intervals

so=Zsplinet(xi, Bsplines=so$bs, type='gsob') #Obtaining the Gram-Schmidt orthogonalization
plot(so$os,type="simple",vknots=FALSE)      #Without computing Z-splines again

so=Zsplinet(xi, Bsplines=so$bs, type='twob') #Obtaining the symmetrize orthogonalization
plot(so$os,type="simple",vknots=FALSE)     

#---------------------------------------#
#---Z-splinet, unequally spaced knots---#
#---------------------------------------#
n_knots=13 # number of knots

xi = c(0, sort(runif(n_knots)), 1)

sone = Zsplinet(xi, k)

plot(sone$bs, type='dyadic') #Plotting B-splines
plot(sone$os) #Plotting Splinet

#Verifying the orthogonalization
gm = gramian(sone$os) #evaluation of the inner products
diag(gm)
sum(gm - diag(diag(gm)))




#---------------------------------------------------#
#---Gram-Schmidt Z-osplines, equally spaced knots---#
#---------------------------------------------------#
k=2 # order
n_knots = 8 # number of knots
xi = seq(0, 1, length.out = n_knots)

so = Zsplinet(xi, order,  type = 'gsob')

plot(so$bs)
plot(so$os)

#Using the previously generated B-splines and normalizing them
so1 = Zsplinet(Bsplines=so$bs, type = "gsob",norm=TRUE) 

plot(so1$bs) #normalized B-splines
plot(so1$os) #the one sided osplines

gm = gramian(so1$os) #evaluation of the inner products
diag(gm)
sum(gm - diag(diag(gm))) #verification of the orghonoalization of the matrix

#-----------------------------------------------#
#---Twosided Z-osplines, equally spaced knots---#
#-----------------------------------------------#
so = Zsplinet(xi, order, type = 'twob')
plot(so$os)

gm = gramian(so$os) #verification of the orthogonality
diag(gm)
sum(gm - diag(diag(gm)))



#--------------------------------------------#
#---Dyadic Z-splinet, equally spaced knots---#
#--------------------------------------------#
k = 2 # order
N = 3 # support level
n_knots = (2^N-1)*(k+1)-k# number of knots 
#n_knots = n_so + k + 1 # number of knots
xi = seq(0, 1, length.out = n_knots+2) #(+2 for the endpoints)

sodyeq = Zsplinet(xi, k)

plot(sodyeq$bs) #Plotting B-splines
plot(sodyeq$os) #Plotting Splinet

#Verifying the orthogonalization
gm = gramian(sodyeq$os) #evaluation of the inner products
diag(gm)
sum(gm - diag(diag(gm)))

#----------------------------------------------#
#---Dyadic Z-splinet, unequally spaced knots---#
#----------------------------------------------#
xi = c(0, sort(runif(n_knots)), 1)

sody = Zsplinet(xi, k)


plot(sody$bs) #Plotting B-splines
plot(sody$os) #Plotting Splinet

#Verifying the orthogonalization
gm = gramian(sody$os) #evaluation of the inner products
diag(gm)
sum(gm - diag(diag(gm)))


