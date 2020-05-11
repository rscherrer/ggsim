#' Append a string to another
#'
#' @param x A character vector
#' @param string A character string to append
#' @param sep Optional separator string
#'
#' @return A character vector
#'
#' @export

str_append <- function(x, string, sep = "") {

  stringr::str_replace(x, "$", paste0(sep, string))

}
