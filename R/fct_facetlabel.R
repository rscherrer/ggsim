#' Format a factor for use in plot facet
#'
#' Prepends, appends and surrounds the labels of a factor with specific character strings
#'
#' @param x A vector (will be coerced to a factor)
#' @param prepend,append,surround Character strings to use to prepend, append and surround the factor labels
#'
#' @return A factor
#'
#' @export

fct_facetlabel <- function(x, prepend = "", append = "", surround = "") {

  x <- factor(x)

  labels <- levels(x) %>%
    str_prepend(prepend) %>%
    str_append(append) %>%
    str_surround(surround)

  factor(x, levels = levels(x), labels = labels)

}
