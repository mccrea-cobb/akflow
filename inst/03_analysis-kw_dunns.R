
#' Kruskal-Wallis and Dunn's tests for monthly differences in water flow across time periods
#'
#' @param dat a data frame of daily water flow data returned from \code{import_format()}
#'
#' @return a list containing Kruskal Wallis chi square test results and a data
#' frame containing Dunn's test results
#'
#' @import dunn.test
#' @importFrom data.table rbindlist
#'
#' @export
#'
#' @examples
#' dontun{
#' kw_dunns(dat)
#' }

kw_dunns <- function(dat){

  library(dunn.test)

  l <- list()  # A list to store the output

  # Kruskal Wallis test for differences between time periods
  kw <- kruskal.test(DA ~ Period, data = dat)
  l[["kw"]] <- kw


  dunntest <- function(dat, month, ..) {
    # Run a Dunn's test, subset by time period and month. Returns a list
    d <- subset(dat,
                as.numeric(Month) == as.numeric(month))
    dunn.test(d$DA,
              d$Period,
              kw = TRUE,
              method = "bonferroni")
  }

  # Apply the function to each month
  d <- lapply(c(1:length(unique(dat$Month))), function(x){
    dunntest(dat, x)
  })

  # Bind the results into a single data frame
  d <- data.table::rbindlist(d)

  # Add Month column
  d$Month <- rep(levels(dat$Month),
                 each = length(unique(dat$Period)))

  l[["dunns"]] <- d

  return(l)
}
