#' Plot a heatmap
#'
#' Generates a heatmap from a data frame
#'
#' @param data A data frame
#' @param variable What variable to plot?
#' @param x,y What variables for the x- and y-axes?
#' @param reduce Optional list of extra shrinking steps to perform prior to summarizing the data over all tiles (as defined by combining facets, `x` and `y`). See `?shrink`.
#' @param how Function used to summarize the data within each tile. Defaults to `last`. Irrelevant if the data already has one value for each tile. If `reduce` is specified, this argument must be provided explicitly as a list with one summary function for each grouping level in `reduce` and a final summary function for each tile. See `?shrink`.
#' @param keep Optional extra grouping variables to keep e.g. for facetting
#'
#' @return A ggplot
#'
#' @example ggheatmap(data, "EI", "hsymmetry", "ecosel", reduce = "simulation", how = c(last, mean))
#'
#' @export

ggheatmap <- function(
  data,
  variable,
  x,
  y,
  reduce = NULL,
  how = last,
  keep = NULL
) {

  library(tidyverse)

  grouping <- c(reduce, list(unlist(c(x, y, keep))))

  data <- data %>% shrink(variable, grouping, how) %>% ungroup()

  p <- ggplot(data, aes(x = get(x), y = get(y), fill = get(variable))) +
    geom_tile() +
    theme_bw() +
    labs(x = x, y = y, fill = variable)

  return (p)

}
