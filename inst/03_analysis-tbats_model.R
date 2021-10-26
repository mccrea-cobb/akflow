### ### ### 
## TBATS model (Trigonometric Box-Cox ARMA Trend and Seasonal components) ----

## Reference:
## DeLivera, A, R. Hyndman, and R. Snyder. 2011. Forecasting time series with
##   complex seasonal patterns using exponential smoothing. Journal of the
##   American Statistical Association 106: 1513-1527.

library(forecast)

datP1 <- subset(dat, Date < "2008-01-01")  # subset 1995-2007 data
datP2 <- subset(dat, Date > "2007-3-31" &
                  Date < "2013-01-01")  # subset 2008-2012 data
datP3 <- subset(dat, Date > "2012-01-31")  # subset 2013-2015 data


## Daily flows, 1995-2007

# Create multi-seasonal time series object:
datP1MSTS <- msts(datP1[, 3], seasonal.periods = c(365.25),
                  ts.frequency = 365.25, start = 1995)

# Fit the TBATS model:
fitP1 <- tbats(datP1MSTS) 

# Plot the model forecast:
plot(forecast(fitP1, h = 365.25)) # h is how long to forecast in time

# View the forecast data frame (values and 95% CIs)
head(summary(forecast(fitP1, h = 1826.25)))

# Plot the decomposition of the seasons from the model:
plot(fitP1)

# Plot the residuals:
plot(residuals(fitP1))

# Plot the fitted values:
plot(fitted.values(fitP1))

