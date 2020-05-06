#' Flexible density plots
#'
#' A flexible function to explore different ways of plotting densities from a data frame
#'
#' @param data A data frame
#' @param variable What variable to plot the density of
#' @param grouping Optional grouping variable
#' @param plot_type Either of "density", "histogram", "boxplot" or "violin"
#' @param bins Number of bins in case of histogram
#' @param jitter Whether to add jitter in case of boxplot or violin
#' @param jitter_width Width of the jitter
#' @param color_groups Whether to color by group
#' @param alpha Transparency
#' @param colors Optional set of colors for the different groups
#'
#' @return A ggplot
#'
#' @export

ggdensityplot <- function(
  data,
  variable,
  grouping = NULL,
  plot_type = "histogram",
  bins = 30,
  jitter = FALSE,
  jitter_width = 0.2,
  color_groups = TRUE,
  alpha = 0.5,
  colors = NULL
) {

  library(tidyverse)

  # Convert grouping variable to factor if needed
  if (!is.null(grouping)) data[, grouping] <- as.factor(data[, grouping])

  if (!is.null(colors) & color_groups & length(colors) != nlevels(data[, grouping])) stop("Please provide as many colors as there are groups")

  plot_types <- c("density", "histogram", "boxplot", "violin")
  if (!plot_type %in% plot_types) stop("Please specify a valid plot type")
  eval(parse(text = paste0("this_geom <- geom_", plot_type)))

  p <- ggplot(data) + theme_bw()

  # One dimensional plot
  if (is.null(grouping)) return (p + this_geom(aes(x = get(variable)), bins = bins) + xlab(variable))

  p <- p + xlab(variable)

  # One dimensional plot with multiple layers
  if (plot_type %in% c("density", "histogram")) {
    grps <- levels(data[, grouping])
    if (is.null(colors)) colors <- rep("darkgrey", length(groups))
    layers <- data %>% split(f = data[, grouping])
    layers <- map(
      layers, ~ this_geom(
        data = .x,
        aes(x = get(variable), fill = .data[[grouping]][1]),
        alpha = alpha, bins = bins
      )
    )
    for (i in seq_along(layers)) p <- p + layers[i]
    p <- p + scale_fill_manual(values = colors, limits = grps)
    p <- p + labs(fill = grouping)
    return (p)
  }

  # Two dimensional plot
  p <- p + this_geom(aes(x = get(grouping), y = get(variable))) + xlab(grouping) + ylab(variable)
  if (jitter) p <- p + geom_jitter(aes(x = get(grouping), y = get(variable)), width = jitter_width)
  if (!color_groups) return (p)
  p <- p + aes(color = get(grouping)) + labs(color = grouping)
  if (!is.null(colors)) p <- p + scale_color_manual(values = colors)

  return (p)

}

