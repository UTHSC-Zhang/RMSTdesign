% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/additive_gam_boot.R
\name{GAM.ss.boot}
\alias{GAM.ss.boot}
\title{Find Sample Size for a Semiparametric Additive RMST Model via Simulation}
\usage{
GAM.ss.boot(
  pilot_data,
  time_var,
  status_var,
  arm_var,
  strata_var = NULL,
  target_power,
  linear_terms = NULL,
  smooth_terms = NULL,
  L,
  n_sim = 1000,
  alpha = 0.05,
  parallel.cores = 1,
  patience = 5,
  n_start = 50,
  n_step = 25,
  max_n_per_arm = 2000
)
}
\arguments{
\item{pilot_data}{A \code{data.frame} with pilot study data.}

\item{time_var}{A character string for the time-to-event variable.}

\item{status_var}{A character string for the event status variable.}

\item{arm_var}{A character string for the treatment arm variable.}

\item{strata_var}{An optional string for a stratification variable.}

\item{target_power}{A single numeric value for the target power.}

\item{linear_terms}{Optional character vector of covariates with a linear effect.}

\item{smooth_terms}{Optional character vector of covariates with a non-linear effect.}

\item{L}{The numeric truncation time for RMST.}

\item{n_sim}{Number of bootstrap simulations per search step.}

\item{alpha}{The significance level.}

\item{parallel.cores}{Number of cores for parallel processing.}

\item{patience}{Number of consecutive non-improving steps in the search before terminating.}

\item{n_start}{The starting sample size per arm/stratum for the search.}

\item{n_step}{The increment in sample size at each step of the search.}

\item{max_n_per_arm}{The maximum sample size per arm/stratum to search up to.}
}
\value{
A \code{list} containing:
\item{results_data}{A \code{data.frame} with the target power and required sample size.}
\item{results_plot}{A \code{ggplot} object of the search path.}
\item{results_summary}{A \code{data.frame} summarizing the estimated treatment effect.}
}
\description{
Performs an iterative sample size search to achieve a target power
using a flexible, semiparametric additive model for the RMST.
}
\details{
This function iteratively searches for the sample size required to
achieve a \code{target_power}. At each step, it runs a full bootstrap simulation
(as described in \code{GAM.power.boot}) to estimate the power for the
current sample size. The search proceeds until the target power is met or
other stopping criteria are satisfied.
}
\note{
This function's methodology is bootstrap-based.
}
\examples{
\dontrun{
pilot_df_effect <- data.frame(
  time = c(stats::rexp(50, 0.1), stats::rexp(50, 0.04)), # Effect
  status = stats::rbinom(100, 1, 0.9),
  arm = rep(0:1, each = 50)
)

ss_results <- GAM.ss.boot(
  pilot_data = pilot_df_effect,
  time_var = "time",
  status_var = "status",
  arm_var = "arm",
  target_power = 0.80,
  L = 15,
  n_sim = 100,      # Low n_sim for example
  n_start = 100,
  n_step = 50,
  patience = 2,
  parallel.cores = 2
)
print(ss_results$results_data)
print(ss_results$results_plot)
}
}
