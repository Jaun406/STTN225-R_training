##EXAMPLE 1 p13:
##R Class Exercise

#Data
ClassData <- data.frame(matrix(c(1124224,82,1,1122355,72,1,1125465,69,1,1202115,65,0,1456877,81,0,1003219,74,1,1019701,52,0,1126394,79,0,1526974,76,0),ncol=3,byrow=TRUE))
names(ClassData) <- c("StudentNo","Score","Gender")
ClassData
#Get mean marks
mean_marks <- mean(ClassData$Score)
mean_marks

medain_marks <- median(ClassData$Score)
mean_median

sd_marks <- sd(ClassData$Score)
sd_marks

female_max <- max(ClassData$Score[ClassData$Gender == 0])
female_max

n <- length(ClassData$StudentNo)
n

prop_male <- mean(ClassData$Gender)
prop_male

################################################################################
## EXAMPLE 2 p14:

meanTrim = function(X, alpha){
  X <- sort(X)
  n <- length(X)
  
  trim_count <- floor(n*(alpha/2))
  trim_X <- X[trim_count+1:n-trim_count]
  ans <- sum(trim_X)/length(trim_X)
  
  return(ans)
}

# Use scores in previous examples as test case

myFunc <- meanTrim(ClassData$Score,0.1)
buildFunc <- mean(ClassData$Score, trim = 0.1)
myFunc
buildFunc
################################################################################









