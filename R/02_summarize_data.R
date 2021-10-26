
#' Summarize USGS water flow data
#'
#' @param dat a data frame of daily water flow data returned from \code{import_format()}
#'
#' @return A list containing a line plot of daily values and 7-day moving averages;
#' a data frame of mean, SEs, and 95% CI of flow rates, by month and year;a boxplot
#' of the median monthly flows by time period; and a data frame of median monthly
#' flows by month and time period
#'
#' @importFrom plyr revalue
#' @importFrom reshape melt
#' @import ggplot2
#' @importFrom doBy summaryBy
#'
#' @export
#'
#' @examples
#' dontrun{
#' summarize_flows(dat$daily)
#' }

summarize_flows <- function(dat) {

  d <- list() # A list to store the output

  # Plot daily and 7-day moving average flow rates
  datLong <- reshape::melt(dat[, 1:3], id = "Date")
  datLong$variable <- plyr::revalue(datLong$variable,
                                    c("DA" = "Daily average",
                                      "MA7" = "7 day moving average"))
  d[["plot_daily"]] <- ggplot2::ggplot(datLong,
                                       aes(x = Date, y = value,
                                           color = variable)) +
    geom_line() +
    theme(legend.title = element_blank()) +
    labs(x = "Date", y = ~ "Flow rate " (ft^3 / s))

  # Summary table of mean, SEs, and 95% CI of flow rates, by month and year
  d[["tbl_monthly"]] <- Rmisc::summarySE(dat, "DA", c("Period", "Month"))

  # Plot mean monthly flow rates by time period, with SEs and 95% CIs
  pd <- ggplot2::position_dodge(0.1) # move them .05 to the left and right
  d[["plot_monthly"]] <- ggplot(d[["tbl_monthly"]],
                                aes(x=Month, y=DA, color = Period)) +
    geom_errorbar(aes(ymin=DA-ci, ymax=DA+ci), width=.1, position=pd) +
    geom_line(position = pd) +
    geom_point(position = pd) +
    ylab(~ "Flow rate " (ft^3 / s))

  # Boxplot of the median monthly flows by time period
  d[["boxplot_monthly"]] <- ggplot(data = dat, aes(y = DA, x = Month)) +
    geom_boxplot(aes(fill = Period)) +
    labs(x = "Month", y = ~ "Flow rate " (ft^3 / s))

  # Table of median monthly flows by month and time period
  d[["tbl_byperiod"]] <- doBy::summaryBy(DA ~ Month + Period,
                                   data = dat,
                                   FUN = list(median, mean, min, max, sd))
  colnames(d[["tbl_byperiod"]]) <- c("Month", "Period", "Median", "Mean",
                                     "Min", "Max", "SD")

  return(d)
}

