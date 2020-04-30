#' Flexible plot facetting
#'
#' Customizable way to split a ggplot into multiple facets depending on facetting variables.
#'
#' @param p A ggplot
#' @param facet_rows Optional variables to facet by rows
#' @param facet_cols Optional variables to facet by columns
#' @param facet_wrapped If TRUE, `facet_wrap` is used instead of `facet_grid`, so columns and rows are irrelevant
#' @param prepend,append Optional list of strings to prepend or append to the facet labels. The list should be named after the factors to prepend to.
#' @param labelling Optional list of functions to pass to `labeller` (e.g. `facet_value`, `label_both` or `label_parsed`).
#'
#' @return A facetted ggplot
#'
#' @export

facettize <- function(
  p,
  facet_rows = NULL,
  facet_cols = NULL,
  facet_wrapped = FALSE,
  prepend = NULL,
  append = NULL,
  labelling = NULL
) {

  library(tidyverse)

  facets <- c(facet_rows, facet_cols)
  if (is.null(facets)) return (p)

  # Setup rows and columns
  if (!is.null(facet_rows)) lhs <- paste(facet_rows, collapse = " + ") else lhs <- "."
  if (!is.null(facet_cols)) rhs <- paste(facet_cols, collapse = " + ") else rhs <- "."

  # Choose what type of facetting to use
  if (facet_wrapped) thisfacet <- facet_wrap else thisfacet <- facet_grid

  # Change labels if needed
  for (i in seq_along(prepend)) p$data <- p$data %>% mutate_at(names(prepend)[i], str_replace, "^", prepend[i])
  for (i in seq_along(append)) p$data <- p$data %>% mutate_at(names(append)[i], str_replace, "$", append[i])

  # Split the plot into facets
  if (is.null(labelling)) return (p + thisfacet(formula(paste(lhs, "~", rhs))))
  p + thisfacet(formula(paste(lhs, "~", rhs)), labeller = do.call("labeller", labelling))

}

