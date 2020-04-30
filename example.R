rm(list = ls())

library(ggsim)
library(tidyverse)
library(cowplot)

data <- readRDS("data/simulations.rds")

variables <- c("EI", "RI", "SI")
colors <- c("lightgreen", "lightblue", "coral")
ylabs <- c("Ecological divergence", "Reproductive isolation", "Spatial isolation")

#### Plot heatmaps ####

list(variables, colors) %>%
  pmap(
    function(variable, color) {
      data %>%
        mutate(
          scaleI = scaleI %>% str_replace(" .*$", "") %>% str_replace("^", "sigma[I]=="),
          mutation = mutation %>% factor %>% str_replace("^", 'mu=="') %>% str_replace("$", '"') %>% str_replace("1e-04", "0.0001") %>% fct_rev
        ) %>%
        ggheatmap(variable, "hsymmetry", "ecosel", "simulation", c(last, mean), keep = c("mutation", "scaleI")) +
        facet_grid(mutation ~ scaleI, labeller = label_parsed) +
        scale_fill_gradient(low = "black", high = color) +
        theme_bw() +
        labs(x = "Habitat symmetry", y = "Divergent selection", fill = variable)
    }
  ) %>%
  plot_grid(plotlist = ., nrow = 3, labels = c("A", "B", "C"))

#### Plot trajectories ####

data %>%
  mutate(
    ecosel = ecosel %>% factor %>% str_replace("^", "s = ") %>% fct_rev,
    hsymmetry = hsymmetry %>% factor %>% str_replace("^", "h = "),
    time = time / 1000
  ) %>%
  group_by(mutation, scaleI) %>%
  group_map(function(df, ...) {

    filename <- "figures/trajectories_mutation_%s_scaleI_%s.png" %>%
      sprintf(df$mutation[1], df$scaleI[1])

    print(filename)

    list(variables, colors, ylabs) %>%
      pmap(function(variable, color, label) {

        df %>%
          group_by(simulation) %>%
          mutate(last = last(get(variable))) %>%
          ungroup() %>%
          gglineplot(x = "time", y = variable, line = "simulation") +
          aes(color = last) +
          scale_color_gradient(low = "black", high = color) +
          guides(color = FALSE) +
          labs(x = "Time (\U02715 1000 generations)", y = label) +
          facet_grid(ecosel ~ hsymmetry)

      }) %>%
      plot_grid(plotlist = ., ncol = 3, labels = c("A", "B", "C"))
  }, keep = TRUE)
