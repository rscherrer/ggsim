#' Check input
#'
#' This function checks the validity of an argument passed to `ggfacet_make` and reformats it if needed for the function to be able to use.
#'
#' @param arg The argument
#' @param facets A character vector of facetting variable names
#' @param default The default value to assign a facet
#'
#' @export

ggfacet_check <- function(arg, facets, default = "") {

  # If the argument is absent, return a vector of default characters
  if (is.null(arg)) return (rep(default, length(facets)))

  # Otherwise, if the argument is unnamed
  if (is.null(names(arg))) {

    # Recycle it if there is only one
    if (length(arg) == 1) return (rep(arg, length(facets)))

    # Otherwise there should be one value per facet
    if (length(arg) != length(facets)) stop("Please provide as many values as facets")
    return (arg)

  }

  # But if the argument is named, filter the names that match some facets
  arg <- arg[names(arg) %in% facets]

  # Error if none
  if (length(arg) == 0) stop("Please provide values named after the facets")

  # Selectively assign values to facets, leaving the other as the default
  out <- rep(default, length(facets))
  names(out) <- facets
  out[names(arg)] <- arg
  return (out)

}
