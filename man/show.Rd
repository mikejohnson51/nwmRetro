% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/show.R
\name{show}
\alias{show}
\title{Graph joined spatial and NWM data}
\usage{
show(obj = NULL, type = "annual", stream_name = NA)
}
\arguments{
\item{obj}{A spatial object from \code{nwmRetro::join()}}

\item{type}{A character string that determines the type of data to plot. Valid options include:
\itemize{
  \item annual
  \item seasonal
  \item monthly
}}

\item{stream_name}{A character string specifing what stream to graph (should match a
valid `gnis_name` in `obj`). \code{NA} (default) will plot all reaches.}
}
\value{
a ggplot
}
\description{
Returns a visualization of the resulting object from \code{nwmRetro::join()}
}
