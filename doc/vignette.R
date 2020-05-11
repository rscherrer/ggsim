## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
data <- readRDS("vignette_data/simulations.rds")
head(data)

## ---- message = FALSE---------------------------------------------------------
#devtools::install_github("rscherrer/ggsim") # if the package is not already installed
library(tidyverse)
library(ggsim)
library(cowplot) # to assemble multiple plots in the same figure

## ---- fig.width = 4, fig.height = 3-------------------------------------------
hmp <- ggheatmap(data, "X", x = "a", y = "b", reduce = "simulation", how = c(last, mean)) +
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

## ---- fig.height = 5, fig.width = 6-------------------------------------------
lns <- data %>%
  filter(hzg == 0.1, lambda_a == 2) %>%
  gglineplot(x = "time", y = "X", line = "simulation") + 
  aes(color = X) +
  scale_color_gradient(low = "black", high = "lightblue") +
  ggtitle(parse(text = '"Dynamics for heterozygosity" ~ H==0.1 ~ "and" ~ lambda[a]==2')) +
  labs(x = "Time (generations)", y = "Response", color = "Response")
lns %>% facettize(rows = "a", cols = "b", header = c("a", "b"))

## ---- warning = FALSE, message = FALSE----------------------------------------
colors <-  colorRampPalette(c("goldenrod", "coral"))(nlevels(factor(data$a)))
custom1 <- function(p) p + labs(x = "Response")
custom2 <- function(p) p + labs(x = "Inflow rate", y = "Reponse")
p1 <- ggdensityplot(data, "X", "a", colors = colors) %>% custom1()
p2 <- ggdensityplot(data, "X", "a", "density", colors = colors) %>% custom1()
p3 <- ggdensityplot(data, "X", "a", "boxplot", colors = colors) %>% custom2()
p4 <- ggdensityplot(data, "X", "a", "violin", colors = colors) %>% custom2()
plot_grid(p1, p2, p3, p4, ncol = 2, nrow = 2, labels = c("A", "B", "C", "D"))

