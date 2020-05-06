#' Prepend a string to another
#'
#' @param x A string
#' @param string A string to prepend
#' @param sep Optional separator string
#'
#' @export

str_prepend <- function(x, string, sep = "") {
  stringr::str_replace(x, "^", paste0(string, sep))
}
