# dengue-model.R
# Author: Sumon
# Project: Dengue Outbreak Prediction in Bangladesh

# Load packages
library(tidyverse)
library(lubridate)
library(forecast)
library(ggplot2)

# Load your data
# Example: df <- read.csv("data/dengue_data.csv")
# Replace with your actual data path
# df <- read.csv("dengue_cases.csv")

# Sample simulated structure
df <- data.frame(
  date = seq.Date(from = as.Date("2018-01-01"), by = "month", length.out = 72),
  cases = round(abs(rnorm(72, mean = 100, sd = 50))),
  rainfall = round(runif(72, 100, 400)),
  temperature = round(runif(72, 25, 35), 1)
)

# Convert to time series
df_ts <- ts(df$cases, frequency = 12, start = c(2018, 1))

# Plot dengue cases over time
ggplot(df, aes(x = date, y = cases)) +
  geom_line(color = "firebrick") +
  labs(title = "Monthly Dengue Cases in Bangladesh", x = "Date", y = "Cases")

# Fit ARIMA model
model <- auto.arima(df_ts)
summary(model)

# Forecast next 12 months
forecast_result <- forecast(model, h = 12)

# Plot forecast
autoplot(forecast_result) +
  labs(title = "Forecast of Dengue Cases", y = "Predicted Cases")

# Save forecast to CSV (optional)
# write.csv(forecast_result, "dengue_forecast.csv")
