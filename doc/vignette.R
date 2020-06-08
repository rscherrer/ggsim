## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
data <- readRDS("data/simulations.rds")
head(data)

## ---- message = FALSE---------------------------------------------------------
#devtools::install_github("rscherrer/ggsim") # if the package is not already installed
library(tidyverse)
library(ggsim)
library(patchwork) # to assemble multiple plots in the same figure

## ---- fig.width = 4, fig.height = 3-------------------------------------------
hmp <- ggheatmap(
  data, "X", x = "a", y = "b", reduce = "simulation", how = c(last, mean)
) +
  scale_fill_continuous(type = "viridis") +
  labs(x = "Inflow rate", y = "Outflow rate", fill = "Response") +
  ggtitle("Our first heatmap")
hmp

## -----------------------------------------------------------------------------
hmp <- ggheatmap(
  data, "X", x = "a", y = "b", reduce = "simulation", how = c(last, mean), 
  keep = c("hzg", "lambda_a")
)

## ---- fig.height = 3, fig.width = 4-------------------------------------------
facettize(
  hmp, rows = "hzg", cols = "lambda_a",
  prepend = c(hzg = "H = ", lambda_a = "lambda[a]=="),
  parsed = "lambda_a", wrap = FALSE
) +
  scale_fill_continuous(type = "viridis") +
  labs(x = "Inflow rate", y = "Outflow rate", fill = "Response") +
  ggtitle("Our facetted heatmap")

## ---- fig.height = 5, fig.width = 7-------------------------------------------
lns <- data %>%
  filter(hzg == 0.1, lambda_a == 2) %>%
  gglineplot(x = "time", y = "X", line = "simulation") + 
  aes(color = X) +
  scale_color_gradient(low = "black", high = "lightblue") +
  ggtitle(parse(text = '"Dynamics for heterozygosity" ~ H==0.1 ~ "and" ~ lambda[a]==2')) +
  labs(x = "Time (generations)", y = "Response", color = "Response")
lns %>% facettize(rows = "a", cols = "b", header = c("a", "b"))

## ---- warning = FALSE, message = FALSE, fig.width = 7, fig.height = 5---------

data$a <- factor(data$a)

p1 <- ggdensityplot(
  data, "X", plot_type = "histogram", mapping = list(fill = "a"), alpha = 0.5
)
p2 <- ggdensityplot(
  data, "X", plot_type = "density", mapping = list(fill = "a"), alpha = 0.5
)
p3 <- ggdensityplot(
  data, "X", plot_type = "boxplot", x = "a", mapping = list(fill = "a"), 
  alpha = 0.5
)
p4 <- ggdensityplot(
  data, "X", plot_type = "violin", x = "a", mapping = list(fill = "a"), 
  alpha = 0.5
)

(p1 | p2) / (p3 | p4) # using patchwork


