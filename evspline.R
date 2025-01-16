#' @title Evaluating Z-Splines and Standard Splines at Given Arguments
#' @description For a \code{Splinet} object \code{spline}, which may contain either Z-splines or standard splines, and a vector of arguments \code{x}, 
#' this function evaluates the splines at the specified arguments. It automatically adjusts for Z-splines by modifying their order before evaluation.
#' Evaluations are conducted through Taylor expansions. 
#' @param object can be a \code{Z-Splinet} object or a \code{Splinet} object; 
#' @param sID vector of integers, specifying the indices of splines within the \code{Z-Splinet} object to be evaluated; if \code{sID=NULL}, all splines in the object are evaluated. The default is \code{NULL}.
#' @param x vector, the arguments at which the splines are to be evaluated; if \code{x=NULL}, the function evaluates the splines over regular grids defined for each interval of the support. Default is \code{NULL}.
#' @param N integer, specifying the number of evaluation points per interval between two consecutive knots. Default is \code{N=250}.
#'
#' @return A matrix of size \code{length(x) x (length(sID)+1)} containing the argument values in the first column and, column-wise, the values of the subsequent splines.
#' @export
#'
#' @inheritSection Z-Splinet reference
#' @example R/Examples/ExEvZSpline.R
#'

evspline <- function(spline, sID = NULL, x = NULL, N = 250) {
  if (!is.null(attr(spline, "is_z_spline")) && attr(spline, "is_z_spline") == TRUE) {
    # Handling for Z-splines
    spline@smorder <- spline@smorder + 1 # Edit the order of the Z-spline
    Y <- Splinets::evspline(spline, sID = sID, x = x, N = N)  # Assume addZeros function adds zeros appropriately
  } else {
    # Standard handling for non-Z-splines
    Y <- Splinets::evspline(spline, sID = sID, x = x, N = N)
  }
  return(Y)
}
