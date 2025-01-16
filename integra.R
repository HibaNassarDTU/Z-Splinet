#' @title Indefinite integrals of splines objects with Special Handling for Z-Splines
#' 
#' @description The function generates the indefinite integrals for given input splines. 
#' The integral is a function 
#' 
#' For Z-splines, it modifies the spline by removing the last column, computes the integral, 
#' and then adds a column of zeros to the derivative matrices. For other splines, it defaults 
#' to standard derivative computation.
#'
#' @param object a \code{Splinets} object of the smoothness order \code{k};
#' @param epsilon non-negative number indicating accuracy when close to zero value are detected; This accuracy is used in 
#' when the boundary conditions of the integral are checked.  
#' @return A \code{Splinets}-object with order \code{k+1} that contains the indefinite integrals
#' of the input object.
#' @inheritSection Splinets-class References
#' @example R/Examples/ExIntegra.R
#' 

integra <- function(spline, epsilon=1e-07) {
  if (!is.null(attr(spline, "is_z_spline")) && attr(spline, "is_z_spline") == TRUE) {
    # Special handling for Z-splines
    spline <- remove_last_column(spline)  # Assume this removes the last column
    spline <- Splinets::integra(spline, epsilon=epsilon)
    # Add a zero column to the integrated spline matrix (if applicable)
    spline <- addZeros(spline)  # Assume addZeros function adds zeros appropriately
  } else {
    # Standard handling for non-Z-splines
    spline <- Splinets::integra(spline, epsilon=epsilon)
  }
  return(spline)
}
