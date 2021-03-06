% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ggdensityplot.R
\name{ggdensityplot}
\alias{ggdensityplot}
\title{Plot a density}
\usage{
ggdensityplot(data, variable, plot_type = "histogram", ...)
}
\arguments{
\item{data}{A data frame}

\item{variable}{Name of the variable to plot}

\item{plot_type}{One of "histogram", "density", "boxplot" or "violin"}

\item{...}{Extra parameters to be passed to either one of \code{gghistogram},
\code{ggdensity}, \code{ggboxplot} or \code{ggviolin}}
}
\value{
A ggplot
}
\description{
Plot a density
}
\examples{

ggdensityplot(mtcars, "mpg", mapping = list(fill = "vs"), alpha = 0.5)
ggdensityplot(mtcars, "mpg", x = "cyl", plot_type = "boxplot")

}
