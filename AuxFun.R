#' Add Extra Knots to a Knot Sequence
#'
#' Extends the range of a given knot sequence by adding extra knots at both ends.
#'
#' @param xi Numeric vector of original knots in increasing order.
#' @param k Integer, number of extra knots to add on each side.
#' @param e Numeric, spacing between extra knots and original range. Defaults to 0.0001.
#'
#' @return Numeric vector containing the expanded knot sequence.
#'
#' @examples
#' original_knots <- c(0.1, 0.5, 0.9)
#' expanded_knots <- extraknots(xi = original_knots, k = 2)
#' print(expanded_knots)
#' 
#' @export
extraknots <- function(xi, k, e = 0.001) {
  m <- min(xi) 
  M <- max(xi)
  extraL <- seq(m - k * e, m - e, by = e) # extra knots on the left
  extraR <- seq(M + e, M + k * e, by = e) # extra knots on the right
  c(extraL, xi, extraR)
}


#' Remove the Last Column from Derivative Matrices in an Object
#'
#' This auxiliary function is part of the [YourPackageName] package and is intended to be used internally.
#' It is designed to modify an S4 object that contains a slot `der`. The slot `der` is expected to be a list of matrices,
#' each representing a derivative matrix. The function iterates over this list and removes the last column
#' from each derivative matrix. This operation is useful in scenarios where the last column of the derivative
#' matrices is no longer needed due to changes in the model parameters or for the purposes of simplification.
#'
#' @param object An S4 object containing a slot `der`, which is a list of derivative matrices.
#' 
#' @return The same S4 object with the last column removed from each derivative matrix in the `der` list.
#'
#' @examples
#' # Assuming `myObject` is an S4 object with a slot `der`:
#' myObject <- remove_last_column_from_derivatives(myObject)
#'
#' @export
remove_last_column <- function(object) {
  n_der <- dim(object@der[[1]])[2]  # Get the number of columns in the first derivative matrix
  
  for (i in 1:length(object@der)) {
    # Remove the last column from each derivative matrix
    object@der[[i]] <- object@der[[i]][, -n_der]
    object@der[[i]] <- sym2one(object@der[[i]], object@supp[[i]], inv = TRUE)
  }
  
  return(object)
}


#' Add a Column of Zeros to Derivative Matrices
#'
#' This function modifies the derivative matrices stored in the `@der` slot
#' of the given object by adding a column of zeros to each matrix. It switches
#' the representation to one-sided, adds the column, and then switches back
#' to the symmetric representation.
#'
#' @param object An S4 object containing a list of derivative matrices in the `@der` slot.
#' @return The modified object with the updated derivative matrices.
#' @export
#' @examples
#' # Assuming `myObject` is your S4 object with a `@der` slot
#' # modifiedObject <- addZeroColumnToDerivatives(myObject)
addZeros <- function(object) {
  n = length(object@knots)-2
  if(length(object@supp) == 0){#if supp is NULL (the length is zero), then the full support is assumed.
  for(i in 1:length(object@der)){ 
    object@supp[[i]] = matrix(c(1,n+2), ncol = 2)
  } 
  }
  for(i in 1:length(object@der)){
    # Switch to one-sided representation
    object@der[[i]] <- sym2one(object@der[[i]], object@supp[[i]])
    # Add extra zero column
    object@der[[i]] <- cbind(object@der[[i]], rep(0, dim(object@der[[i]])[1]))
    # Switch back to symmetric representation
    #object@der[[i]] <- sym2one(object@der[[i]], object@supp[[i]], inv = TRUE)
  }
  return(object)
}



n_der= dim(ZB$bs@der[[1]])[2]
for (i in 1:length(ZB$bs@der)){
  ZB$bs@der[[i]] = ZB$bs@der[[i]][,-(n_der)]
  ZB$os@der[[i]] = ZB$os@der[[i]][,-(n_der)]
}
