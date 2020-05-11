#' Check input
#'
#' Checks and if needed reformats some input arguments to the `facettize` function.
#'
#' @param arg The argument
#' @param facets A character vector of facetting variable names
#' @param default The default value to assign a facet
#'
#' @return A character vector

facettize_check <- function(arg, facets, default = "") {

  # If the argument is absent, return a vector of default characters
  if (is.null(arg)) return (rep(default, length(facets)))

  # Otherwise, if the argument is unnamed
  if (is.null(names(arg))) {

    # Recycle it if there is only one
    if (length(arg) == 1) return (rep(arg, length(facets)))

    # Error if there are not as many values as there are facets
    if (length(arg) != length(facets)) {
      stop("If unnamed and if not scalar, the argument must be as long as facets")
    }

    # Otherwise the argument does not need formatting
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
