
#' Make labels for a facetting variable
#'
#' This function is used by `ggfacet_make` to make facet labels for each facetting variable.
#'
#' @param labels A list of labels for a specific facetting variable
#' @param prepend,append Optional strings to prepend or append to the labels, respectively.
#' @param parsed Whether the labels should be parsed into `plotmath` expressions.
#'
#' @return A list of new labels.
#'
#' @export

ggfacet_labs <- function(labels, prepend = "", append = "", parsed = FALSE) {
  labels %>%
    map(function(x) {
      x <- as.character(x)
      x <- str_prepend(x, prepend)
      x <- str_append(x, append)
      if (parsed) c(parse(text = as.character(x))) else x
    })
}
