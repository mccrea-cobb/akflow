#' Run a water flow report for the Sag River
#'
#' @param outdir the output directory to store the report
#'
#' @return a pdf report
#'
#' @import bookdown
#' @import rmarkdown
#' @import kableExtra
#'
#' @export
#'
#' @examples
#' dontrun{
#' run_report()
#' }

run_report <- function(outdir = "./reports") {
  rmarkdown::render(system.file("rmd", "report.Rmd", package = "akflow"),
                    output_dir = outdir,
                    output_file = I("flow_report.pdf"),
                    clean = TRUE)
}
