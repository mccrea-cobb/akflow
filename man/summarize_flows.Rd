% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/02_summarize_data.R
\name{summarize_flows}
\alias{summarize_flows}
\title{Summarize USGS water flow data}
\usage{
summarize_flows(dat)
}
\arguments{
\item{dat}{a data frame of daily water flow data returned from \code{import_format()}}
}
\value{
A list containing a line plot of daily values and 7-day moving averages;
a data frame of mean, SEs, and 95\% CI of flow rates, by month and year;a boxplot
of the median monthly flows by time period; and a data frame of median monthly
flows by month and time period
}
\description{
Summarize USGS water flow data
}
\examples{
dontrun{
summarize_flows(dat$daily)
}
}
