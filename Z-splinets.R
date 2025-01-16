#' @title Z-Splines, and Their Orthogonalization
#'
#' @description This function is designed to either take Z-splines as input or generate them internally. 
#' Subsequently, based on the argument \code{type}, it constructs a \code{Splinet}-object (Z-splines) that represents 
#' an orthonormal spline basis. This basis is derived through orthogonalization processes specifically suited 
#' for Z-splines. The available methods for orthogonalization include the Gram-Schmidt method, the two-sided method, 
#' and the default, splinet algorithm. The resulting orthogonal Z-spline bases.
#' @param knots \code{n+2} vector, specifying the increasing order of knots; This parameter is unnecessary if 
#' the \code{ZSplines} argument is not \code{NULL}, as the knots will then be inherited from \code{ZSplines}.
#' @param smorder integer, specifying the order of Z-splines, with a default of \code{smorder=3}. This is also 
#' inherited from the \code{ZSplines} argument if it is not \code{NULL}.
#' @param type string, identifying the type of basis to be generated. The options are:
#' \itemize{
#'   \item \code{'bs'} for the unorthogonalized Z-splines,
#'   \item \code{'spnt'} for the orthogonal Z-splinet (the default),
#'   \item \code{'gsob'} for the Gram-Schmidt orthogonalized Z-splines,
#'   \item \code{'twob'} for the two-sided orthogonal Z-splines.
#' } 
#' @param ZSplines \code{Z-Splinet}-object, representing a basis of Z-splines; when this is not \code{NULL},
#' the knots and smorder arguments are derived from it.
#' @param norm logical, indicating whether the output Z-splines should be normalized.
#' @param periodic logical, indicating whether the Z-splines are of the periodic type.
#' @return Depending on the \code{type} argument, this function returns either a single \code{Z-Splinet}-object
#' within a list \code{list("zs"=ZSplines)} for unorthogonalized Z-splines (normalized as specified by \code{norm}),
#' or a list comprising two \code{Z-Splinet}-objects: \code{list("zs"=ZSplines, "os"=ZSplinet)}. Here, \code{ZSplines}
#' may be computed internally or provided as input, and \code{ZSplinet} represents the orthogonally transformed Z-splines
#' as determined by the \code{type} argument, with normalization dictated by the \code{norm} flag.
#' @example R/Examples/ExZSplinet.R
#' @return A Z-spline basis object

#'@section References:
  #' Jana Burkotov\eqn{\mbox\'{a}}{a}, Ivana \v{S}u, Hiba Nassar, Jitka Machalov\eqn{\mbox\'{a}}{a}, Karel Hron, (2024) "Efficient spline orthogonal basis for representation of density functions" <arXiv:>
  #'
  #' Liu, X., Nassar, H., Podg\eqn{\mbox{\'o}}{o}rski, K. "Dyadic diagonalization of positive definite band matrices and efficient B-spline orthogonalization." Journal of Computational and Applied Mathematics (2022) <https://doi.org/10.1016/j.cam.2022.114444>.
  #' 
  #' Podg\eqn{\mbox{\'o}}{o}rski, K. (2021) 
  #' "\code{Splinets} -- splines through the Taylor expansion, their support sets and orthogonal bases." <arXiv:2102.00733>.#' 
  #' @export
Zsplinet <- function(knots = NULL, smorder = 3, type = 'spnt', Zsplines = NULL, norm = FALSE) {
  # Your existing code here...
  
  # Combine all the steps into a single function
  
  #------------------------------#
  # S1: generating bspline basis #
  #------------------------------#
  if(!is.null(Bsplines)){ #inheriting the arguments if B-splines are in the input
    knots=Zsplines@knots
    smorder=k=Zsplines@smorder
    n = length(knots) - 2
    Zsplines@smorder= Zsplines@smorder+1
    Z= Zsplines
  }else{
    k = smorder + 1
    n = length(knots) - 2
    
    #In the case knots are not in the increasing order they are sorted
    if(min(diff(knots))<0){
      knots=sort(unique(knots))
      cat("Knots were not given in the strictly increasing order, which is required.\n
          Ordered  knots with removed ties are replacing the input values.\n")
    }
    #
    newknots= extraknots(knots,k)
    so = splinet(newknots, k,type = 'bs')
    Z= Splinets::deriva(so$bs)
    
    Z= addZeros(Z)
   # for(i in 1:length(Z@der)){
   #   Z@der[[i]] = sym2one(Z@der[[i]], Z@supp[[i]])# switch to onesided representation
    #  Z@der[[i]]= cbind(Z@der[[i]], rep(0, dim(Z@der[[i]])[1])) # adding extra zero colomn
    #  Z@der[[i]] = sym2one(Z@der[[i]], Z@supp[[i]], inv = TRUE)  # switch back to symmetric representation
   #  }
    Z@der= Z@der[-1]
    Z@der= Z@der[-length(Z@der)]
    Z@supp= Z@supp[-1]
    Z@supp= Z@supp[-length(Z@supp)]
    
    for (i in 1:length(Z@supp)) {
      Z@supp[[i]]=  Z@supp[[i]]-1 
    }
    
    
    Z@smorder= Z@smorder+1
    new_knots= newknots[-1]
    new_knots= new_knots[-length(new_knots)]
    Z@knots=new_knots
    Z@taylor= Z@taylor[-1,,drop=FALSE]
    Z@taylor= Z@taylor[-dim(Z@taylor)[1], , drop=FALSE]
    
    splnt=splinet(Bsplines=Z,type = 'bs', norm=norm) #normalization of bspline basis #
  } 
  if(type == 'bs'){
    #edit the degree
    splnt$bs@smorder= smorder
    # Set the 'is_z_spline' attribute to TRUE for Z-spline identification
    attr(splnt$bs, "is_z_spline") <- TRUE
    return(list(bs = splnt$bs))

  }else{
  #------------------------------#
  # S3: Orthogonalization of B-splines #
  #------------------------------#  
  {splnt=splinet(Bsplines=Z, type= type , norm=TRUE)}
  
  #edit the degree
  splnt$os@smorder= smorder
  splnt$bs@smorder= smorder
  
  # Set the 'is_z_spline' attribute to TRUE for Z-spline identification
  attr(splnt$bs, "is_z_spline") <- TRUE
  attr(splnt$os, "is_z_spline") <- TRUE
  
  # Return the Z-spline basis object
  return(list(bs = splnt$bs, os = splnt$os))
}
}

