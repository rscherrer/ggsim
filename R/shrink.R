#' Serial shrinking
#'
#' Sequentially applies `group_by` and `summarize` to a data frame.
#'
#' @param data A data frame
#' @param variables Variables to summarize
#' @param grouping A list of single, or vectors of, grouping variables to be used sequentially. The groups are summarized in the order they are provided.
#' @param how A list of summarizing functions to be used, respectively, on each of the grouped data frames defined in `groups`
#'
#' @return A shrunk data frame
#'
#' @example shrink(data, variables, grouping = list("simulations", c("hsymmetry", "ecosel")), how = c(last, mean))
#'
#' @export

shrink <- function(data, variables, grouping, how = last) {

  library(tidyverse)

  if (length(grouping) != length(how)) stop("grouping and how must have the same length")
  if (length(how) == 1) how <- list(how)
  if (!is.list(grouping) & length(grouping) == 1) grouping <- list(grouping)

  for (i in seq_along(grouping)) {
    data <- data %>% group_by_at(do.call("c", grouping)) %>% summarize_at(variables, how[i])
    grouping <- grouping[-1]
  }

  return (data)

}
