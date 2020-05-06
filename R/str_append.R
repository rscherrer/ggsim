#' Append a string to another
#'
#' @param x A string
#' @param string A string to prepend
#' @param sep Optional separator string
#'
#' @export

str_append <- function(x, string, sep = "") {
  stringr::str_replace(x, "$", paste0(sep, string))
}
