# ggsim: Plotting tools for simulation data

This R package provides wrappers around `ggplot2` functions to produce the usual sets of plots needed from typical simulation datasets, which often consists in multiple observations of multiple variables across a high-dimensional parameter space. We mainly provide functions for plotting summary heatmaps across parameter space, multiple line-plots, and various density plots (from histograms to boxplots) as well as a handy function to split a plot into facets with customized facet labels. Check out the [vignette](doc/vignette.pdf) for specific examples!

You can install the package from R using:

```{r}
devtools::install_github("rscherrer/ggsim", build_vignettes = TRUE)
```

where setting the `build_vignettes` argument to TRUE will allow you to view the vignette from R, using `browseVignettes("ggsim")` after installing the package.

Suggestions and contributions to further improve the package are welcome.
