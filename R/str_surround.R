#' Surround a string with another
#'
#' @param x A character vector of strings to surround
#' @param string Another character
#'
#' @return A character vector
#'
#' @export

str_surround <- function(x, string = "") {

  x %>% str_prepend(string) %>% str_append(string)

}
