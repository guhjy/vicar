% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mouthwash.R
\name{mouthwash}
\alias{mouthwash}
\title{MOUTHWASH: Maximize Over Unobservables To Help With Adaptive SHrinkage.}
\usage{
mouthwash(Y, X, k = NULL, cov_of_interest = ncol(X),
  include_intercept = TRUE, limmashrink = TRUE, fa_func = pca_naive,
  fa_args = list(), likelihood = c("normal", "t"),
  mixing_dist = c("normal", "uniform", "+uniform", "sym_uniform"),
  lambda_type = c("zero_conc", "uniform"),
  pi_init_type = c("zero_conc", "uniform", "random"),
  degrees_freedom = NULL, pi_init = NULL, grid_seq = NULL,
  lambda_seq = NULL, lambda0 = 10, scale_var = TRUE,
  plot_update = FALSE, sprop = 0, var_inflate_pen = 0,
  subsample = FALSE, num_sub = min(1000, ncol(Y)), same_grid = FALSE,
  use_t_adjust = FALSE, detailed_output = FALSE, verbose = TRUE)
}
\arguments{
\item{Y}{A matrix of numerics. These are the response variables
where each column has its own variance. In a gene expression
study, the rows are the individuals and the columns are the
genes.}

\item{X}{A matrix of numerics. The observed covariates.}

\item{k}{A non-negative integer.The number of unobserved
confounders. If not specified and the R package sva is
installed, then this function will estimate the number of
hidden confounders using the methods of Buja and Eyuboglu
(1992).}

\item{cov_of_interest}{A positive integer. The column number of the
covariate in X whose coefficients you are interested in.
The rest are considered nuisance parameters and are regressed
out by OLS.}

\item{include_intercept}{A logical. If \code{TRUE}, then it will
check \code{X} to see if it has an intercept term. If not, then
it will add an intercept term. If \code{FALSE}, then \code{X}
will be unchanged.}

\item{limmashrink}{A logical. Should we apply hierarchical
shrinkage to the variances (\code{TRUE}) or not (\code{FALSE})?
If \code{degrees_freedom = NULL} and \code{limmashrink = TRUE}
and \code{likelihood = "t"}, then we'll also use the limma
returned degrees of freedom.}

\item{fa_func}{A factor analysis function. The function must have
as inputs a numeric matrix \code{Y} and a rank (numeric scalar)
\code{r}. It must output numeric matrices \code{alpha} and
\code{Z} and a numeric vector \code{sig_diag}. \code{alpha} is
the estimate of the coefficients of the unobserved confounders,
so it must be an \code{r} by \code{ncol(Y)} matrix. \code{Z}
must be an \code{r} by \code{nrow(Y)} matrix. \code{sig_diag}
is the estimate of the column-wise variances so it must be of
length \code{ncol(Y)}. The default is the function
\code{pca_naive} that just uses the first \code{r} singular
vectors as the estimate of \code{alpha}. The estimated
variances are just the column-wise mean square.}

\item{fa_args}{A list. Additional arguments you want to pass to
fa_func.}

\item{likelihood}{Either \code{"normal"} or \code{"t"}. If
\code{likelihood = "t"}, then the user may provide the degrees
of freedom via \code{degrees_freedom}.}

\item{mixing_dist}{A character. Should we use a mixture of uniforms
(\code{"uniform"}), a mixture of uniforms with minimum at 0
(\code{"+uniform"}), a mixture of uniforms symmetric at 0
(\code{"sym_uniform"}), or a mixture of normals
(\code{"normal"})?}

\item{lambda_type}{A character. Should we apply a penalty on zero
(\code{"zero_conc"}) or no penalty (\code{"uniform"}). Not used
if \code{lambda_seq} is not \code{NULL}.}

\item{pi_init_type}{How should we initialize the mixing
proportions? By concentrating on zero (\code{"zero_conc"}), by
equal weights on all mixing distributions (\code{"uniform"}),
or by sampling uniformly on the simplex (\code{"random"})?}

\item{degrees_freedom}{if \code{likelihood = "t"}, then this is the
user-defined degrees of freedom for that distribution. If
\code{degrees_freedom} is \code{NULL} then the degrees of
freedom will be the sample size minus the number of covariates
minus \code{k}.}

\item{pi_init}{A numeric vector. These are the initial values of
the mixing proportions.}

\item{grid_seq}{The grid for the mixing distribution. If
\code{mixing_dist = "uniform"} or \code{"+uniform"}, then these
should be the non-zero limits of the uniform distributions. If
\code{mixing_dist = "sym_uniform"}, then these should be the
right limits of the uniform distributions. If \code{mixing_dist
= "normal"}, then these should be the variances of the mixing
normal distributions.}

\item{lambda_seq}{A numeric vector with elements all greater than
or equal to 1. These are the tuning parameters for the mixing
proportions. This can only be specified if \code{grid_seq} is
also specified.}

\item{lambda0}{A numeric greater than or equal to 1. The penalty on
zero if \code{lambda_type = "zero_conc"}.}

\item{scale_var}{A logical. Should we estimate a variance inflation
parameter (\code{TRUE}) or not (\code{FALSE})?}

\item{plot_update}{A logical. Should I plot the the path of the
log-likelihood (\code{TRUE}) or not (\code{FALSE})? Only
applicable when \code{mixing_dist} is not \code{"normal"}.}

\item{sprop}{If \eqn{b} is an effect and \eqn{s} is an estimated
standard error, then we model \eqn{b/s^{sprop}} as
exchangeable. The default is 0. When \code{sprop = 1}, for
identifiability reasons it must be the case that
\code{scale_var = FALSE}.}

\item{var_inflate_pen}{The penalty to apply on the variance inflation parameter.
Defaults to 0, but should be something non-zero when \code{alpha = 1}
and \code{scale_var = TRUE}.}

\item{subsample}{A logical. Should we only use a subsample of the genes to estimate
the hidden covariates (\code{TRUE}) or use all of the genes (\code{FALSE})? If
\code{TRUE}, then \code{\link[ashr]{ash}} will be re-run on the residuals (after
subtracting out the contribution from the unobserved confounders) to obtain the
estimated prior.}

\item{num_sub}{The number of genes to subsample if \code{subsample = TRUE}. Not used if
\code{subsample = FALSE}.}

\item{same_grid}{A logical. If \code{subsample = FALSE}, should we use the same grid as
when we estimated the unobserved confounders (\code{TRUE}) or the default grid from
\code{\link[ashr]{ash.workhorse}} (\code{FALSE})?}

\item{use_t_adjust}{A logical. Should we adjust the variance estimates so that the p-values
from the z-statistics match the corresponding p-values from the original
t-statistics (\code{TRUE}) or not (\code{FALSE})?}

\item{detailed_output}{A logical. Should we return a lot of output (\code{TRUE}) or the standard
output (\code{FALSE}). Most users should only need this set to (\code{FALSE}).}

\item{verbose}{If \code{verbose = TRUE}, print progress of the algorithm
to the console.}
}
\value{
A list with some or all of the following elements.

    \code{fitted_g}: The estimated unimodal prior. It is of class
    \code{\link[ashr]{unimix}} if \code{mixing_dist} is one of
    \code{"uniform"}, \code{"+uniform"}, or
    \code{"sym_uniform"}. It is of class
    \code{\link[ashr]{normalmix}} if \code{mixing_dist} is
    \code{"normal"}.

    \code{loglik} The final log-likelihood.

    \code{logLR} The likelihood ratio compared to the all-null setting (point-mass on zero).

    \code{data} Post-confounder adjusted ashr data.

    \code{pi0} The estimate of the proportion of null genes.

    \code{z2} The estimated confounders (after rotation)
    corresponding the covariates of interest (\code{z2}). Mostly output for
    debugging reasons.

    \code{xi} The estimated variance inflation parameter.

    \code{Zhat} The estimate of the confounders.

    \code{alphahat} The estimate of the coefficients of the confounders.

    \code{sig_diag} The estimate of the column-specific variances.

    \code{result} A data frame with the results from MOUTHWASH. The columns of which are
    \itemize{
      \item{NegativeProb}{The probability that the effect is negative.}
      \item{PositiveProb}{The probability that the effect is positive.}
      \item{lfsr}{The local false sign rates of each effect.}
      \item{svalue}{The s-values, a measure of significance.}
      \item{lfdr}{The local false discovery rates.}
      \item{qvalue}{The q-values, a measure of significance.}
      \item{PosteriorMean}{The posterior means of the effects.}
      \item{PosteriorSD}{The posterior standard deviations of the effects.}
      \item{extra}{If \code{detailed_output = TRUE}, this list is returned with some extra output. Mostly used for debugging.}
    }
}
\description{
This function implements the full MOUTHWASH method. First, it
rotates the response and explanatory variables into a part that we
use to estimate the confounding variables and the variances, and a
part that we use to estimate the coefficients of the observed
covariates. This function will implement a factor analysis for the
first part then run \code{\link{mouthwash_second_step}} for the
second part.
}
\details{
The assumed model is \deqn{Y = X\beta + Z\alpha + E.} \eqn{Y} is a
\eqn{n} by \code{p} matrix of response variables. For example, each
row might be an array of log-transformed gene-expression data.
\eqn{X} is a \eqn{n} by \eqn{q} matrix of observed covariates. It
is assumed that all but one column of which contains nuisance
parameters. For example, the first column might be a vector of ones
to include an intercept. \eqn{\beta} is a \eqn{q} by \eqn{p} matrix
of corresponding coefficients.  \eqn{Z} is a \eqn{n} by \eqn{k}
matrix of confounder variables. \eqn{\alpha} is the corresponding
\eqn{k} by \eqn{p} matrix of coefficients for the unobserved
confounders. \eqn{E} is a \eqn{n} by \eqn{p} matrix of error
terms. \eqn{E} is assumed to be matrix normal with identity row
covariance and diagonal column covariance \eqn{\Sigma}. That is,
the columns are heteroscedastic while the rows are homoscedastic
independent.

This function will first rotate \eqn{Y} and \eqn{X} using the QR
decomposition. This separates the model into three parts. The first
part contains nuisance parameters, the second part contains
the coefficients of interest, and the third part contains the
confounders. \code{mouthwash} applies a user-provided factor
analysis to the third part to estimate the confounding factors,
then runs an EM (or coordinate-ascent) algorithm on the second part
to estimate the coefficients of interest.

There are a couple forms of factor analysis available in this
package. The default is PCA with the column-wise residual
mean-squares as the estimates of the column-wise variances.

For instructions and examples on how to specify your own factor analysis, run the following code in R:
\code{utils::vignette("customFA", package = "vicar")}. If it doesn't work, then you probably haven't built
the vignettes. To do so, see \url{https://github.com/dcgerard/vicar#vignettes}.
}
\examples{
library(vicar)

## Generate data ----------------------------------------------------------
set.seed(116)
n <- 13
p <- 101
k <- 2
q <- 3
is_null       <- rep(FALSE, length = p)
is_null[1:57] <- TRUE

X <- matrix(stats::rnorm(n * q), nrow = n)
B <- matrix(stats::rnorm(q * p), nrow = q)
B[2, is_null] <- 0
Z <- X \%*\% matrix(stats::rnorm(q * k), nrow = q) +
     matrix(rnorm(n * k), nrow = n)
A <- matrix(stats::rnorm(k * p), nrow = k)
E <- matrix(stats::rnorm(n * p, sd = 1 / 2), nrow = n)
Y <- X \%*\% B + Z \%*\% A + E

## Fit MOUTHWASH ----------------------------------------------------------
mout <- mouthwash(Y = Y, X = X, k = k, cov_of_interest = 2,
                  include_intercept = FALSE)
mout$pi0 ## mouthwash estimate
mean(is_null) ## truth

## plot ordering
order_lfdr <- order(mout$result$lfdr)
graphics::plot(mout$result$lfdr[order_lfdr], col = is_null[order_lfdr] + 3,
               ylab = "lfdr")
graphics::legend("topleft", col = c(3, 4), legend = c("non-null", "null"),
                 pch = 1)

## Compare to ASH on OLS coefficients -------------------------------------
lmout <- limma::lmFit(t(Y), X)
betahat_ols <- lmout$coefficients[, 2]
sebetahat_ols <- lmout$stdev.unscaled[, 2] * lmout$sigma
aout <- ashr::ash.workhorse(betahat = betahat_ols, sebetahat = sebetahat_ols,
                            optmethod = "mixEM")
ashr::get_pi0(aout) ## ash estimate
mean(is_null) ## truth

ash_lfdr <- ashr::get_lfdr(aout)
aorder_lfdr <- order(ash_lfdr)
graphics::plot(ash_lfdr[aorder_lfdr], col = is_null[aorder_lfdr] + 3,
               ylab = "lfdr")
graphics::legend("topleft", col = c(3, 4), legend = c("non-null", "null"),
                 pch = 1)

## ROC Curves -------------------------------------------------------------
afpr <- cumsum(is_null[aorder_lfdr]) / sum(is_null)
atpr <- cumsum(!is_null[aorder_lfdr]) / sum(!is_null)
mfpr <- cumsum(is_null[order_lfdr]) / sum(is_null)
mtpr <- cumsum(!is_null[order_lfdr]) / sum(!is_null)
graphics::plot(afpr, atpr, type = "l", xlab = "False Positive Rate",
               ylab = "True Positive Rate", main = "ROC Curve", col = 3,
               lty = 2)
graphics::lines(mfpr, mtpr, col = 4, lty = 1)
graphics::abline(0, 1, lty = 2, col = 1)
graphics::legend("bottomright", legend = c("MOUTHWASH", "ASH"), col = c(4, 3),
                 lty = c(1, 2))

}
\seealso{
Factor analyses available in the \code{vicar} package:
    \code{\link{pca_naive}}, \code{\link{fa_ml}}.

\code{\link{backwash}} for a similar method that puts a prior on the
    unobserved confounders rather than maximizes over them.
}
\author{
David Gerard
}
