rm(list = ls())

library(ggsim)
library(dplyr)
library(ggplot2)

data <- readRDS("data/simulations.rds")

head(data)

data <- data %>% filter(scaleI == "1 0 0", mutation == 0.001)

colors <- colorRampPalette(c("red", "blue"))(5)
p <- ggdensityplot(data, "EI", grouping = "hsymmetry", plot_type = "density", colors = colors)
p

# Add a legend for those
alpha <- 0.5
p + aes(fill = colors)
