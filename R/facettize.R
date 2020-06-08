#' Flexible plot facetting
#'
#' Customized facetted plot
#'
#' Flexible tool for making facetted plots in various layouts and with various facet labels.
#'
#' @param p A ggplot
#' @param rows Optional variables to facet by rows
#' @param cols Optional variables to facet by columns
#' @param wrap If TRUE, `facet_wrap` is used instead of `facet_grid`, so columns and rows are irrelevant
#' @param prepend,append Optional character strings to prepend or append to the labels, respectively. Can be either of (1) an unnamed character string that will be recycled over all facetting variables, (2) an unnamed character vector that must be of the same length as there are facetting variables (rows first, columns second), or (3) a named character vector where names refer to the faccetting variables to apply each character string.
#' @param parsed Optional names of the facetting variables that should have their labels parsed. See `?bquote` and the `plotmath` syntax documentation for how the labels should be formatted if they are parsed into mathematical expressions.
#' @param header Optional names of facetting variables to which to prepend their own column names. Overwrites `prepend`, if any.
#' @param sep Separator to use when prepending a `header`.
#'
#' @return A facetted ggplot
#'
#' @export

facettize <- function(
  p,
  rows = NULL,
  cols = NULL,
  wrap = FALSE,
  prepend = NULL,
  append = NULL,
  parsed = NULL,
  header = NULL,
  sep = " = "
) {

  facets <- c(rows, cols)
  if (is.null(facets)) return (p)

  # Make the arguments the same length as the number of facets
  prepend <- facettize_check(prepend, facets)
  append <- facettize_check(append, facets)

  # Prepend with column headers if needed
  if (!is.null(header)) {
    names(prepend) <- facets
    prepend[header] <- paste0(header, sep)
  }

  # Set labeller function
  labeller <- ggplot2::label_value

  surround <- rep('', length(facets))

  # If any facet must be parsed...
  if (!is.null(parsed)) {

    # Update labeller function
    labeller <- ggplot2::label_parsed

    # Protect unparsed labels from parsing
    names(surround) <- facets
    not_parsed <- facets[!facets %in% parsed]
    surround[not_parsed] <- '"'

  }

  # Modify the labels of the facetting variables in the dataset
  for (i in seq_along(facets)) {
    p$data <- p$data %>%
      dplyr::mutate_at(
        facets[i],
        ~ fct_facetlabel(., prepend[i], append[i], surround[i])
      )
  }

  # Setup rows and columns
  if (!is.null(rows)) lhs <- paste(rows, collapse = " + ") else lhs <- "."
  if (!is.null(cols)) rhs <- paste(cols, collapse = " + ") else rhs <- "."
  formula <- formula(paste(lhs, "~", rhs))

  # Choose what type of facetting to use
  if (wrap) {
    thisfacet <- ggplot2::facet_wrap
  } else {
    thisfacet <- ggplot2::facet_grid
  }

  # Split the plot into facets
  p + thisfacet(formula, labeller = labeller)

}

