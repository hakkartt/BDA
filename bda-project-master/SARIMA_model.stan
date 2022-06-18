//
// This Stan program defines a SARIMAX model where hour is the main variable of the time series.
// Seasonalities of 24 hours (daliy) and 168 hours (weekly) are included. 
// Additionally external variables X, Y and Z are used.

data {
  int<lower=0> N;
  vector[N] count;
  vector[N] real_temp;
  vector[N] feel_temp;
  vector[N] humidity;
  vector[N] wind;
  vector[N] weather;
  vector[N] holiday;
  vector[N] weekend;
  vector[N] season;
  vector[N] hour;
}


parameters {
  real alpha;
  real beta_1;
  real beta_24;
  real beta_168;
  real<lower=0> sigma;
}

// The model to be estimated. We model the output
// 'count' to be SARIMA distributed with AR(1), SAR(24) and SAR(168).
model {
  // weak priors
  alpha ~ normal(0, 10);
  beta_1 ~ normal(0, 1);
  beta_24 ~ normal(0, 1);
  beta_168 ~ normal(0, 1);
  sigma ~ normal(0, 10);
  
  
  for (n in 169:N)
    count[n] ~ normal(alpha + beta_1 * count[n-1] + beta_24 * count[n-24] + beta_168 * count[n-168], sigma);
}

