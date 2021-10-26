
#' Import and format USGS water flow data
#'
#' @param site a numeric unique USGS identifier for a water monitoring site
#' @param start_date the desired start date
#' @param end_date  the desired end date
#'
#' @return a list containing a data frame of raw daily flow data and a data frame of summarized monthly flow data
#'
#' @importFrom magrittr %>%
#' @importFrom zoo rollmean
#' @import dplyr
#'
#' @export
#'
#' @examples
#' dontrun{
#' import_format()
#' }
import_format <- function(site = "15908000",
                          start_date = "1996-01-01",
                          end_date = "2020-12-31",
                          skiplines = 34){

  # Access the data (1996-2020)
  myurl <- paste0("https://waterservices.usgs.gov/nwis/dv/?format=rdb&sites=", site,
                 "&startDT=", start_date,
                 "&endDT=", end_date,
                 "&siteStatus=all")
  daily <- read.table(file = myurl,
                      sep = "\t",
                      skip = skiplines,  # Skip the long header
                      header = TRUE)

  # Reformat and summarize daily data
  daily <- daily[-1, ]  # remove the first row
  daily <- daily %>%
    dplyr::select(c(3, 10)) %>%  # select rows with data
    dplyr::rename(Date = datetime,  # rename the columns
                  DA = X1211_00060_00003) %>%  # DA = daily average flow
    dplyr::mutate(Date = as.Date(Date, format = "%Y-%m-%d"),  # reformat
                  DA = as.numeric(DA),
                  MA7 = zoo::rollmean(DA, k = 7, fill = NA), # Calculate 7-day moving average
                  DayOfYear = as.factor(strptime(Date, format = "%Y-%m-%d")$yday + 1),
                  Year = as.factor(format(Date, "%Y")),
                  Month = as.factor(format(Date, "%m")),
                  Period = as.factor(ifelse(Date < "2008-01-01", "1996-2007",
                                            ifelse(Date > "2007-12-31" & Date < "2013-01-01",
                                                   "2008-2012", "2013-2020"))))

  # Summarize monthly data
  monthly <- aggregate(DA ~ Month + Year, data = daily, FUN = median)
  monthly$Period <- as.factor(ifelse(as.numeric(monthly$Year) < 2008, "1996-2007",
                                     ifelse(as.numeric(monthly$Year) > 2007 & as.numeric(monthly$Year) < 2013,
                                            "2008-2012", "2013-2015")))
  dat <- list("daily" = daily,
              "monthly" = monthly)
}
