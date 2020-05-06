#' Customized facet labels
#'
#' Returns a list of facet labels for each facetting variable. This function can be passed to the `labeller` argument of `ggplot`'s facetting functions.
#'
#' @param facets A list of labels for each facetting variable. Typically the kind of list that is passed to the labeller function if `labeller` is specified in `ggplot`'s facetting functions. See e.g. `?facet_grid`.
#' @param prepend,append Optional character vectors specifying strings to prepend or append to the facet labels, respectively. If named, the names should refer to specific facetting variables to which to apply this concatenation. If unnamed, the number of values must match the number of facetting variables, or be one, in which case the single value is recycled for all facetting variables.
#' @param parsed Optional logical vector specifying for which facetting variables should the labels be parsed into `plotmath` expressions. Same rules apply as for the previous arguments.
#'
#' @return A list of facet labels for each facetting variable.
#'
#' @export

ggfacet_make <- function(facets, prepend = NULL, append = NULL, parsed = FALSE) {

  facetnames <- names(facets)

  prepend <- ggfacet_check(prepend, facetnames, default = "")
  append <- ggfacet_check(append, facetnames, default = "")
  parsed <- ggfacet_check(parsed, facetnames, default = FALSE)

  # Make a list of specifications
  args <- list(facets, prepend, append, parsed)

  # Make customized labels for each facetting variable
  out <- args %>%
    pmap(function(facet, prepend, append, parsed) {
      ggfacet_labs(facet, prepend, append, parsed)
    })
  names(out) <- names(facets)
  out

}
