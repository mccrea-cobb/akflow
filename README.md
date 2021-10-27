[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

# akflow
An R package that includes functions for importing, formating, summarizing, and visualizing daily water flow data for the Sag River, Alaska. Functions for testing for differences in flow rates between time periods using Kruskal Wallis and Dunn's tests.

# USFWS Disclaimer
The United States Fish and Wildlife Service (FWS) GitHub project code is provided on an "as is" basis and the user assumes responsibility for its use. FWS has relinquished control of the information and no longer has responsibility to protect the integrity, confidentiality, or availability of the information. Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring by FWS. The FWS seal and logo shall not be used in any manner to imply endorsement of any commercial product or activity by FWS or the United States Government.

# Instructions

`install.packages("devtools")`  
`library(devtools)`  
`devtools::install_github("mccrea-cobb/akflow")`  
`library(akflow)`  
`akflow::run_report()`  
