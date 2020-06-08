#' Plot a density
#'
#' @param data A data frame
#' @param variable Name of the variable to plot
#' @param plot_type One of "histogram", "density", "boxplot" or "violin"
#' @param ... Extra parameters to be passed to either one of `gghistogram`,
#' `ggdensity`, `ggboxplot` or `ggviolin`
#'
#' @return A ggplot
#'
#' @examples
#'
#' ggdensityplot(mtcars, "mpg", mapping = list(fill = "vs"), alpha = 0.5)
#' ggdensityplot(mtcars, "mpg", x = "cyl", plot_type = "boxplot")
#'
#' @export

ggdensityplot <- function(
  data,
  variable,
  plot_type = "histogram",
  ...
) {

  if (plot_type == "histogram") {
    gghistogram(data, variable, mapping = mapping, ...)
  } else if (plot_type == "density") {
    ggdensity(data, variable, mapping = mapping, ...)
  } else if (plot_type == "boxplot") {
    ggboxplot(data, variable, mapping = mapping, ...)
  } else if (plot_type == "violin") {
    ggviolin(data, variable, mapping = mapping, ...)
  } else {
    stop("Wrong plot_type")
  }

}
