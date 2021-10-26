################# #
### Autoregressive integrated moving averages (ARIMA) model (work in progress) ----

# General approach: First fit global model, then fit models separately 
# for each series, then construct an F-test to test the hypothesis of a 
# common set of parameters



# First check for stationarity in the data by examining 
# the autocorrelation function (ACF)
acf(dat$daily$DA, type = "correlation", lag.max = 365, plot = TRUE)
acf(dat$monthly$DA, type = "correlation", lag.max = 12, plot = TRUE)

acf(dat$daily$DA, type = "partial", lag.max = 30, plot = TRUE)
acf(dat$monthly$DA, type = "partial", lag.max = 12, plot = TRUE)


## Fit the ARIMA models
library(forecast)

# All data:
fitArima <- auto.arima(dat$monthly$DA, seasonal.test = "ocsb")
plot(forecast(fitArima, h = 12))
acf(residuals(fitArima), type = "correlation", lag.max = 12, plot = TRUE)
coef(fitArima)

# 1996-2007 data:
datDAMonthlyP1 <- aggregate(DA ~ Month + Year, 
                            data = filter(dat$daily, Period == "1996-2007"), 
                            FUN = mean)

fitArima1 <- auto.arima(datDAMonthlyP1$DA, seasonal.test = "ocsb")
plot(forecast(fitArima1, h = 12))
acf(residuals(fitArima1), type = "correlation", lag.max = 12, plot = TRUE)

# 2008-2012 data:
datDAMonthlyP2 <- aggregate(DA ~ Month + Year, 
                            data = filter(dat$daily, Period == "2008-2012"), 
                            FUN = mean)

fitArima2 <- auto.arima(datDAMonthlyP2$DA, seasonal.test = "ocsb")
plot(forecast(fitArima2, h = 12))
acf(residuals(fitArima2), type = "correlation", lag.max = 12, plot = TRUE)

# 2013-2020 data:
datDAMonthlyP3 <- aggregate(DA ~ Month + Year, 
                            data = filter(dat$daily, Period == "2013-2020"), 
                            FUN = mean)
fitArima3 <- auto.arima(datDAMonthlyP3$DA, seasonal.test = "ocsb")
plot(forecast(fitArima3, h = 12))
acf(residuals(fitArima3), type = "correlation", lag.max = 12, plot = TRUE)

# Compare models

