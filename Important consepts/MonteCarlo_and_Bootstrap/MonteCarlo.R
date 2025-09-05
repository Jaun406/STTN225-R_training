## EXAMPLE 3 p17:

ExFunc1 <- function(MC,n){
  # Initialize
  ans_vec <- c()
  # Run Monte Carlo 
  for (i in 1:MC){
    X <- rnorm(n,mean = 10, sd = 3)
    ans_vec <- c(ans_vec,median(X))
  }
  # Compute the standard error
  SE <- sd(ans_vec)
  
  #Plot
  hist(ans_vec, 
       freq = FALSE,
       main = "Histogram of Median Values with KDE Overlay", 
       breaks = 5,
       xlab = "Median Value", 
       ylab = "Density",
       col = "lightblue", 
       border = "black")
  kernel_des <- density(ans_vec)
  
  lines(kernel_des,col="red",lwd=2)
  
  return(SE)
}

ExFunc1(100,10)

