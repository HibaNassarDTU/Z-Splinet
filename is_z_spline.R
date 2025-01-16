#' Check if an object is a Z-spline
#'
#' This function checks if the provided spline object has been identified as a Z-spline
#' by examining a specific attribute `is_z_spline` set on the object.
#'
#' @param spline An object to check for being a Z-spline.
#' @return `TRUE` if the spline is identified as a Z-spline, `FALSE` otherwise.
#' @examples
#' knots=c(0, 0.1, 0.2, 0.3, 0.5, 1) # knots
#' k=3 # degree
#' ZB=Zsplinet(knots,k) # Z-spline basis
#' is_z_spline(ZB$bs)  # Should return TRUE
#' @export
is_z_spline <- function(spline) {
  # Check if the spline is a Z-spline
  if (!is.null(attr(spline, "is_z_spline")) && attr(spline, "is_z_spline") == TRUE) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}
