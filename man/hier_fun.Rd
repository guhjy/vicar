% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ruvb.R
\name{hier_fun}
\alias{hier_fun}
\title{Hierarchical prior density function as described in Gerard and Stephens (2016)}
\usage{
hier_fun(beta_mat, shape_param = 1, rate_param = 1,
  return_log = TRUE)
}
\arguments{
\item{beta_mat}{A matrix. The rows are the coefficients of the
difference covariates. The columns are the different genes.}

\item{shape_param}{A positive numeric. The shape parameter for the
gamma prior.}

\item{rate_param}{A positive numeric. The rate parameter for the
gamma prior.}

\item{return_log}{A logical. Should we return the log-density
(\code{"TRUE"}) or the the density (\code{"FALSE"})?}
}
\description{
Hierarchical prior density function as described in Gerard and Stephens (2016)
}
\author{
David Gerard
}
