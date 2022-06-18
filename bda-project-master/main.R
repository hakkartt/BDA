library(lubridate)
library(rstan)
data <- read.csv("data/london_merged.csv") # read in data

stan.data <- list(N=dim(data)[1],count=data$cnt, real_temp=data$t1,
                  feel_temp=data$t2,
                  humidity=data$hum, wind=data$wind_speed,
                  weather=data$weather_code, holiday=data$is_holiday,
                  weekend=data$is_weekend, season=data$season,
                  hour=hour(as.character(data$timestamp)))
model <- stan_model("base.stan")
model.fit <- sampling(model, data=stan.data)

