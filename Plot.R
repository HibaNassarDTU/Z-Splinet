#' Plot Z-Splines or B-Splines
#'
#' This function provides custom plotting behavior for spline objects,
#' with specific enhancements for Z-splines. For Z-splines, it adjusts
#' the smoothness order (`smorder`) before plotting and applies custom
#' styling. For B-splines, it defaults to standard
#' plotting behavior.
#'
#' @param spline A splinet object to be plotted. This can be a Z-spline or a B-spline. 
#' @param ... Additional arguments passed to `Splinets::plot`.
#' @importFrom Splinets plot
#' @examples
#' # Assuming `my_z_spline` and `my_b_spline` are previously created spline objects
#' # with appropriate attributes and structure.
#' plot_custom_spline(my_z_spline)
#' plot_custom_spline(my_b_spline)
#' @export
plot<- function(spline, ...) {
  # Check if the spline is a Z-spline
  if (!is.null(attr(spline, "is_z_spline")) && attr(spline, "is_z_spline") == TRUE) {
    # Handle plotting for Z-spline
    # Edit the order of the Z-spline
    spline@smorder <- spline@smorder + 1
    # Proceed to plot with Splinets::plot, applying any additional arguments
    Splinets::plot(spline, ...)
  } else {
    # Handle plotting for B-spline or any other spline not marked as Z-spline
    Splinets::plot(spline, ...)
  }
}

