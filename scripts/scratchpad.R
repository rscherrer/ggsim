rm(list = ls())

library(ggsim)
library(tidyverse)
library(cowplot)

data <- readRDS("vignettes/vignette_data/simulations.rds")

hmp <- ggheatmap(
  data, "X", x = "a1", y = "b", reduce = "simulation",
  how = c(last, mean), keep = c("mu", "lambda_a")
)

hmp + facet_grid(mu ~ lambda_a, labeller = label_parsed)

hmp %>% facettize(rows = "mu", cols = "lambda_a", prepend = c("mu==", "lambda = "),
                  append = c(lambda_a = "%"), parsed = "mu", header = "lambda_a", wrap = TRUE)
