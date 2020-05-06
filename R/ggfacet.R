#' Flexible plot facetting
#'
#' Customized facetted plot
#'
#' Flexible tool for making facetted plots in various layouts and with various facet labels.
#'
#' @param p A ggplot
#' @param facet_rows Optional variables to facet by rows
#' @param facet_cols Optional variables to facet by columns
#' @param wrap If TRUE, `facet_wrap` is used instead of `facet_grid`, so columns and rows are irrelevant
#' @param prepend,append Optional strings to prepend or append to the labels. See `?ggfacet_make`
#' @param parsed Optional names of the facetting variables that should have their labels parsed.
#' @param header Optional names of facetting variables to which to prepend their own column names
#' @param sep Separator to use when prepending a header.
#'
#' @return A facetted ggplot
#'
#' @export

ggfacet <- function(
  p,
  facet_rows = NULL,
  facet_cols = NULL,
  wrap = FALSE,
  prepend = NULL,
  append = NULL,
  parsed = NULL,
  header = NULL,
  sep = " = "
) {

  library(tidyverse)

  facets <- c(facet_rows, facet_cols)
  if (is.null(facets)) return (p)

  # Setup rows and columns
  if (!is.null(facet_rows)) lhs <- paste(facet_rows, collapse = " + ") else lhs <- "."
  if (!is.null(facet_cols)) rhs <- paste(facet_cols, collapse = " + ") else rhs <- "."

  # Choose what type of facetting to use
  if (wrap) thisfacet <- facet_wrap else thisfacet <- facet_grid

  # Prepend column headers if needed
  if (!is.null(header)) prepend[header] <- paste0(header, sep)

  # Check which variables must be parsed
  is_parsed <- rep(FALSE, length(facets))
  is_parsed[parsed] <- TRUE

  # Split the plot into facets
  p + thisfacet(
    formula(paste(lhs, "~", rhs)),
    labeller = function(x) {
      ggfacet_make(x, prepend, append, is_parsed)
    }
  )

}

