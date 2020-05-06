rm(list = ls())

library(ggsim)
library(tidyverse)
library(cowplot)

data <- readRDS("data/simulations.rds")

data <- data %>% filter(scaleI == "1 0 0" & mutation == 0.001)

head(data)

colors <-  c("brown", "gold", "goldenrod", "coral", "red")
p1 <- ggdensityplot(data, "EI", "hsymmetry", colors = colors)
p2 <- ggdensityplot(data, "EI", "hsymmetry", "density", colors = colors)
p3 <- ggdensityplot(data, "EI", "hsymmetry", "boxplot", colors = colors)
p4 <- ggdensityplot(data, "EI", "hsymmetry", "violin", colors = colors)
plot_grid(p1, p2, p3, p4, ncol = 2, nrow = 2)
