subgroupPredict <- function(X){
 
  # load parameters 
  readRDS("data/output.RData")
  nu = output$nu
  lambda = output$lambda
  psi = output$psi
  gamma = output$gamma
  epsilon = output$epsilon
  
  # calculate log-likelihoods
  sigma = lambda %*% t(lambda) + diag(psi)
  V = chol(sigma)
  logdetV = log(det(V))
  Z = sweep(X, 2, nu, "-") %*% solve(V)
  ind_lik = -(1/2)*(p*log(2*pi) + 2*logdetV + apply(Z, 1, function(y) t(y) %*% y))
  ind_lik_rem = log(gamma*exp(ind_lik) + (1-gamma)*epsilon)
  
  # predict weight
  weight_num = log(gamma)+ind_lik
  weight_denom = ind_lik_rem
  log_weight = weight_num - weight_denom
  weight = exp(log_weight)
  
  pred = 1-weight
  return(pred)
}

