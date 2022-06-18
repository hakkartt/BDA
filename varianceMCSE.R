```{r}
alpha_test <- c(1.896, -3.6, 0.374, 0.964, -3.123, -1.581)
beta_test <- c(24.76, 20.04, 6.15, 18.65, 8.16, 17.4)

posterior_mean <- function(alpha, beta){
  weights = normalized_importance_weights(alpha, beta)
  c(sum(alpha*weights), sum(beta*weights))
}

variance <- function(alpha, beta){
  w = normalized_importance_weights(alpha, beta)
  
  # E(x)^2
  Ealpha_squared = sum(alpha*w)^2 / sum(w)
  Ebeta_squared = sum(beta*w)^2 / sum(w)
  
  # E(x^2)
  E_alphasquared = sum(alpha^2*w) / sum(w)
  E_betasquared = sum(beta^2*w) / sum(w)
  
  # var(x) = E(x^2) - E(x)^2
  c((E_alphasquared - Ealpha_squared), (E_betasquared - Ebeta_squared))
}

posterior_mean_MSCE <- function(alpha, beta){
  
  v = variance(alpha, beta)
  var_alpha = v[1]
  var_beta = v[2]
  
  msce_alpha = sqrt( var_alpha / S_eff(alpha, beta) )
  msce_beta = sqrt( var_beta / S_eff(alpha, beta) )
  c(msce_alpha, msce_beta)
}

posterior_mean_MSCE(alpha_test, beta_test)

```