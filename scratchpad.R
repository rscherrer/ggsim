rm(list = ls())

library(ggsim)
library(tidyverse)
library(cowplot)

data <- readRDS("data/simulations.rds")
data <- data %>% filter(scaleI == "1 0 0" & mutation == 0.001)

colors <-  c("brown", "gold", "goldenrod", "coral", "red")
p <- ggdensityplot(data, "EI", "hsymmetry", colors = colors)

ggfacet(p, facet_rows = "hsymmetry", facet_cols = "mutation", wrap = TRUE,
        prepend = c(hsymmetry = "sigma[i]==", mutation = "mu=="),
        parsed = c("mutation", "hsymmetry"))


