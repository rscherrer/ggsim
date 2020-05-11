#' Append a string to another
#'
#' @param x A character vector
#' @param string A character string to prepend
#' @param sep Optional separator string
#'
#' @return A character vector
#'
#' @export

str_prepend <- function(x, string, sep = "") {

  stringr::str_replace(x, "^", paste0(string, sep))

}
