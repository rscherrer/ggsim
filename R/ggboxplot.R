#' Plot a boxplot
#'
#' @param data A data frame
#' @param variable Name of the variable to plot
#' @param x Optional name of a categorial variable for the horizontal axis
#' @param mapping A named list of arguments to `ggplot2::aes_string`, containing
#' additional mappings
#' @param is_jitter Whether to add jittered points
#' @param jitter_pars Parameters to be passed to `ggplot2::geom_jitter`
#' @param ... Parameters to be passed to `ggplot2::geom_boxplot`
#'
#' @return A ggplot
#'
#' @examples
#'
#' mtcars$vs <- factor(mtcars$vs)
#' ggboxplot(mtcars, "mpg", is_jitter = TRUE, jitter_pars = list(width = 0.2))
#' ggboxplot(mtcars, "mpg", mapping = list(fill = "vs"), alpha = 0.5)
#'
#' @return A ggplot
#'
#' @export

ggboxplot <- function(
  data,
  variable,
  x = NULL,
  mapping = NULL,
  is_jitter = FALSE,
  jitter_pars = list(),
  ...
) {

  xnull <- FALSE
  if (is.null(x)) {
    xnull <- TRUE
    x <- "xx"
    xx <- ""
  }

  p <- ggplot2::ggplot(data, ggplot2::aes_string(x = x, y = variable))
  if (!is.null(mapping)) {
    this_aes <- ggplot2::aes_string
    this_mapping <- do.call("this_aes", mapping)
    p <- p + this_mapping
  }
  p <- p +
    ggplot2::geom_boxplot(...) +
    ggplot2::theme_bw()
  if (is_jitter) {
    this_jitter <- ggplot2::geom_jitter
    p <- p + do.call("this_jitter", jitter_pars)
  }
  if (xnull) p <- p +
    theme(axis.text.x = element_blank()) +
    xlab(NULL)

  return(p)

}
