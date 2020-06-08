#' Plot a density distribution
#'
#' @param data A data frame
#' @param variable Name of the variable to plot
#' @param mapping A named list of arguments to `ggplot2::aes_string`, containing
#' additional mappings
#' @param ... Parameters to be passed to `ggplot2::geom_density`
#'
#' @return A ggplot
#'
#' @examples
#'
#' mtcars$vs <- factor(mtcars$vs)
#' ggdensity(mtcars, "mpg")
#' ggdensity(mtcars, "mpg", mapping = list(fill = "vs"), alpha = 0.5)
#'
#' @return

ggdensity <- function(data, variable, mapping = NULL, ...) {

  p <- ggplot2::ggplot(data, ggplot2::aes_string(x = variable))
  if (!is.null(mapping)) {
    this_aes <- ggplot2::aes_string
    this_mapping <- do.call("this_aes", mapping)
    p <- p + this_mapping
  }
  p <- p +
    ggplot2::geom_density(...) +
    ggplot2::theme_bw()

  return(p)

}
