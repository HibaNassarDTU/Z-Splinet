#' @title Gramian matrix, norms, and inner products of splines or Z-splines
#' @param Sp \code{Splinets} object;
#' @param norm_only logical, indicates if only the square norm of the 
#' elements in the input object is calculated; The default is \code{norm_only=FALSE};
#' @param sID vector of integers, the indicies specifying splines in the \code{Splinets} 
#' list \code{Sp} to be evaluated; If \code{sID=NULL} (default), then the inner products for all the pairs taken from the object are evaluated.
#' @param Sp2 \code{Splinets} object, the optional second  \code{Splinets}-object; The inner products between 
#' splines in \code{Sp} and in \code{Sp2} are evaluated, i.e. the cross-gramian matrix.
#' @param s2ID vector of integers, the indicies specifying splines in the \code{Sp2} to be considered in the cross-gramian;
#' @return 
#' \itemize{
#' \item \code{norm_only=FALSE} -- the Gram matrix of inner products of the splines within the input \code{Splinets}-objects is returned, 
#' \item \code{Sp2 = NULL} -- the non-negative definite matrix of the inner products of splines in \code{Sp} is returned,
#' \item both \code{Sp} and \code{Sp2} are non-\code{NULL} and contain splines \eqn{S_i}'s and \eqn{T_j}'s, respectively == 
#' the cross-gramian matris of the inner products for the pairs of splines \eqn{(S_i,T_j)} is returned,
#' \item \code{norm_only=FALSE}-- the vector of the norms of \code{Sp} is returned.
#' }
#' @description The function performs evaluation of the matrix of the inner products 
#' \eqn{\int S(t) \cdot T(t) dt }{\int S(t) * T(t) dt} of all the pairs of splines \eqn{S}, \eqn{T} from the input object.
#' The program utilizes the Taylor expansion of splines, see the reference for details.
#' @details If there is only one input \code{Splinet}-object, then the non-negative symmetrix matrix of the splines in this object is returned. 
#' If there are two input \code{Splinet}-objects, then the \eqn{m \times r}{m x r} matrix of the cross-inner product is returned, where \eqn{m} is 
#' the number of splines in the first object and \eqn{r} is their number in the second one. 
#' If only the norms are evaluated (\code{norm_only= TRUE}) it is always evaluating the norms of the first object. 
#' In the case of two input \code{Splinets}-objects, they should be over the same set of knots and of the same smoothness order. 
#' @export
#' @inheritSection Z-Splinet reference
#' @example R/Examples/ExGramian.R
#' 





gramian <- function(object, norm_only = FALSE, sID = NULL, Sp2 = NULL ,s2ID = NULL) {
  if (!is.null(attr(object, "is_z_spline")) && attr(object, "is_z_spline") == TRUE) {
    if(!is.null(Sp2)  && !is.null(attr(Sp2, "is_z_spline"))){ Sp2=remove_last_column(Sp2)}
    # Special handling for Z-splines
    object <- remove_last_column(object)  # Assume this function removes the last column
    object <- Splinets::gramian(object, norm_only = norm_only, sID = sID, Sp2 = Sp2 ,s2ID = s2ID)
    # Add a zero column to each derivative matrix
    #for(i in 1:length(spline@der)){
    # spline@der[[i]] <- cbind(spline@der[[i]], rep(0, dim(spline@der[[i]])[1]))
    # }
  } else {
    # Standard handling for non-Z-splines
    object <- Splinets::gramian(object, norm_only = norm_only, sID = sID, Sp2 = Sp2 ,s2ID = s2ID)
  }
  return(object)
}
