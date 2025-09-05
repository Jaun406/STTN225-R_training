
#------------------------------------------
# MLE Optimization using "brute force"
#------------------------------------------
x <- c(2.17310451260809,2.47856281967841,2.95866555833281,3.27184887575012,2.12129588072287,1.77728953105233,2.84029954019569,1.11972065864061,5.8477633597712,1.80590247892202,5.8515783473471,0.942542192227543,1.16024548115314,1.1985526498937,0.582235505459959,1.93012324504033,3.1264956189165,6.73206096962296,0.496463836350729,4.39656354416616)

MLEchisq <- function(x,G,strt,stp){
  theta <- seq(strt,stp,length=G)
  lik <- numeric(G)
  for(j in 1:G){
    ff <- dchisq(x,theta[j])
    lik[j] <- prod(ff)
  }
  jstar <- which(lik == max(lik))
  ans <- theta[jstar]
  return(ans)
}

MLEchisqlog <- function(x,G,strt,stp){
  theta <- seq(strt,stp,length=G)
  lik <- numeric(G)
  for(j in 1:G){
    ff <- log(dchisq(x,theta[j]))
    lik[j] <- sum(ff)
  }
  jstar <- which(lik == max(lik))
  ans <- theta[jstar]
  plot(theta,lik,type="l",lwd=2)
  abline(v=theta[jstar],lty=2)
  return(ans)
}

MLEchisq(x,G=100000,0.5,3.5)
MLEchisqlog(x,G=100000,0.5,4.5)

#-----------------------------
# MLE Optimisation using the "optim" function
#-----------------------------

x <- c(2.17310451260809,2.47856281967841,2.95866555833281,3.27184887575012,2.12129588072287,1.77728953105233,2.84029954019569,1.11972065864061,5.8477633597712,1.80590247892202,5.8515783473471,0.942542192227543,1.16024548115314,1.1985526498937,0.582235505459959,1.93012324504033,3.1264956189165,6.73206096962296,0.496463836350729,4.39656354416616)
myloglik <- function(th){ 
  ans <- -sum(log(dchisq(x,th)))  
  return(ans)
}
myloglik <- Vectorize(myloglik)

th <- seq(0.1,10,length=1000)
plot(th,myloglik(th),type="l")

optim( 1 , myloglik , method="L-BFGS-B" )$par
MLEchisqlog(x,G=100000,0.5,4.5)
