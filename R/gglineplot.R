#' Plot multiple lines
#'
#' Flexible way to plot multiple lines from a data frame
#'
#' @param data A data frame
#' @param x,y Variables to plot against each other
#' @param line Variable to group data points into separate lines. If NULL (defaults), a single line is drawn per facet.
#' @param alpha Baseline transparency of the lines.
#' @param step Range of the noise in transparency across lines. Giving the lines different transparency values allows to plot many lines together on the same plot. Keep this parameter small to make the differences in transparency unnoticeable.
#' @param color Color of the lines. Leave unspecified if you want to assign color as an aesthetics (do that outside the function).
#'
#' @return A ggplot
#'
#' @export

gglineplot <- function(
  data,
  x,
  y,
  line = NULL,
  alpha = 0.5,
  step = 0.1,
  color = NULL
) {

  alphamin <- ifelse(alpha - step < 0, 0, alpha - step)
  alphamax <- ifelse(alpha + step > 1, 1, alpha + step)

  if (is.null(line)) {
    data <- data %>% dplyr::mutate(linecol = 1)
    line <- "linecol"
  }

  data <- data %>% dplyr::mutate_at(line, as.factor)
  nlines <- nlevels(data[[line]])

  if (is.null(color)) args <- list() else args <- list(color = color)

  p <- ggplot2::ggplot(data, aes(x = get(x), y = get(y), alpha = get(line))) +
    do.call("geom_line", args) +
    ggplot2::theme_bw() +
    ggplot2::labs(x = x, y = y) +
    ggplot2::guides(alpha = FALSE) +
    ggplot2::scale_alpha_manual(values = runif(n = nlines, min = alphamin, max = alphamax))

  return (p)

}
