#' Print the top left hand corner of a matrix of data frame
#'
#' @param x matrix or data.frame, object to print top corner from
#' @param n numeric, how many rows and columns to print
#' @param n_row numeric, how many rows to print, overwrites n
#' @param n_col numeric, how many cols to print, overwrites n
#'
#' @return top left corner of x
#' @export
#'
#' @examples
corner <- function(x, n = 6, n_row = NULL, n_col = NULL){
  if (is.matrix(x) | is.data.frame(x)) {
    if (is.null(n_row)) {
      n_row <- n
    }
    n_row <- min(c(nrow(x), n_row)) #if more rows than in x, reduce

    if (is.null(n_col)) {
      n_col <- n
    }
    n_col <- min(c(ncol(x), n_col)) #if more cols than in x, reduce

    x[1:n_row, 1:n_col]

  } else {
    stop("object supplied is not a matrix or dataframe")
  }

}
