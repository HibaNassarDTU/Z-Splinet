
#-----------------------------------------#
#--------- Grammian for Z-splines --------#
#-----------------------------------------#

n=25; xi=seq(0,1,by=1/(n+1)); k=2; 
Sp=splinet(xi) #B-splines and corresponding splinet

gramian(Sp$bs) #band grammian matrix for B-splines
gramian(Sp$os) #diagonal gramian matrix for the splinet
A=gramian(Sp$bs,Sp2=Sp$os) #cross-Gramian matrix, the coefficients of
                              #the decomposition of the B-splines

plot(Sp$bs)
plot(lincomb(Sp$os,A))
