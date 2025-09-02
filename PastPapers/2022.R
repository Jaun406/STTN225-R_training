# This is a script writen to solve an old test paper in preparation of 
# the paper I write this semester

# Question 1 - General:

#a) Calculate sqrt(1/3(SUM(mean - values)^6))

Xi <- c(3, 5, 6, 10) # Get variables
# Get final solution
final_1a = sqrt((sum((Xi-mean(Xi))^6))/3)
print(final_1a)
################################################################################

#b) Calculate P(X<0.5) if X~N(2,4)

final_1b = pnorm(q = 0.5,mean = 2, sd = 2,) 
print(final_1b)
################################################################################

#c) Determine the 95% percentile of X where X~F,1,7

final_1c = qf(0.95,1,7)
print(final_1c)
################################################################################

#d) Calculate the value of 𝑏 such that P(𝑊>𝑏)=0.3 where W~Chi(3)

final_1d = qchisq(1 - 0.3,3)
print(final_1d)
################################################################################


# Question 2: Bootstrap:
###############################################################################
# Data used in Q2:

# Define all variables with given values
Xj = c(138, 120, 140, 115, 147, 112, 160, 128, 115)
#Bootstrap of 1000 iteration
B  = 1000
#Monte Carlo of 1000 iteration
MC = 1000
#Define function
th_hat = function(Xj){prod(Xj)^(1/length(Xj))}
################################################################################

#a) Calculate the bootstrap for the variance = (PI(Xi)^(1/n))


#Create list with 1000 numerical values
th_hat_star_B = numeric(B)

#Start the bootstrap
for (b in 1:B){
  X_star = sample(Xj, replace=TRUE) # Redraw a sample out of the data with replacement
  th_hat_star_B[b] = th_hat(X_star) # add the statistic with the new data to a list
}

final_2a = var(th_hat_star) #get variance of all the bootstrapped statistics
print(final_2a)
################################################################################

#b) Estimate with Monte Carlo th where X ~Gamma(10,15) and n = 9

n = 9
th_hat_star_MC = numeric(MC)

#Start Monte Carlo
for (mc in 1:MC){
  Xg = rgamma(9, shape=10, scale=15)
  th_hat_star_MC[mc] = th_hat(Xg)
}
final_2b = var(th_hat_star_MC)
print(final_2b)
################################################################################

#Question3: Functions

X<-c(21,11,25,35,19,24,9)
Y<-c(56,54,67,25,72,62,76)

reg <- function(X, Y){
  if (length(X) != length(Y)){
    ans = NULL
    warning("Vectors x and y must be of equal length.")
    return(ans)
  }
  
  b = (sum(X*Y)-(1/length(X))*sum(X)*sum(Y))/(sum(X^2)-(1/length(X))*sum(X)^2)
  a = mean(Y) - b*mean(X)
  ans = list(a=a,b=b)

  return(ans)
}

final_3 = reg(X,Y)
print(final_3)
################################################################################

#Question 4: Estimators
X <- c(0.086, 0.149, 0.001, 0.151, 0.128, 0.114, 0.072, 0.141)
# Write the M function:
M = function(lambda, X){
  sorted_X = sort(X)
  F_lambda = pexp(sorted_X,lambda)
  delta = c(F_lambda,1) - c(0,F_lambda)
  ans = mean(log(delta))
  return(ans)
}

#Optimization
final_4 = optimize(M,interval=c(0,200),maximum=TRUE,X=X)$maximum
print(final_4)

################################################################################
print("Question 1: ")
sprintf("a) %.4f",final_1a)
sprintf("b) %.4f",final_1b)
sprintf("c) %.4f",final_1c)
sprintf("d) %.4f",final_1d)

print("Question 2:")
sprintf("a) %.4f",final_2a)
sprintf("b) %.4f",final_2b)

print("Question 3:")
print(final_3)

print("Question 4:")
sprintf("answer: %.4f",final_4)





