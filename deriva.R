#' @title Derivatives of splines objects with Special Handling for Z-Splines
#' @description The function generates a \code{Splinets}-object which contains the first order
#' derivatives of all the splines from the input \code{Splinets}-object.
#' 
#' For Z-splines, it modifies the spline by removing the last column, computes the derivative, 
#' and then adds a column of zeros to the derivative matrices. For other splines, it defaults 
#' to standard derivative computation.
#'
#' @param object \code{Splinets} object of the smoothness order \code{k};
#' @param epsilon positive number, controls removal of knots from the support; If the derivative is smaller than this number, it is considered 
#' to be zero and the corresponding knots are removed from the support.The default value is \code{1e-7}.  
#' @return A \code{Splinets}-object of the order \code{k-1} that also contains the updated information about the support set.
#' @export
#' @inheritSection Z-Splinet reference
#' 
#' @example R/Examples/ExDeriva.R
#' 
#' 
#' 
deriva <- function(object, epsilon = 1e-7) {
  if (!is.null(attr(object, "is_z_spline")) && attr(object, "is_z_spline") == TRUE) {
    # Special handling for Z-splines
    object <- remove_last_column(object)  # Assume this function removes the last column
    object <- Splinets::deriva(object, epsilon = epsilon)
    # Add a zero column to each derivative matrix
    object= addZeros(object)
    #for(i in 1:length(spline@der)){
     # spline@der[[i]] <- cbind(spline@der[[i]], rep(0, dim(spline@der[[i]])[1]))
   # }
  } else {
    # Standard handling for non-Z-splines
    object <- Splinets::deriva(object, epsilon = epsilon)
  }
  return(object)
}

