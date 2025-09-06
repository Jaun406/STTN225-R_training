# Statistical Inference Course Notes

## Example 1: Basic Data Analysis

### Data Setup
Creating a data frame with student data, including student number, score, and gender.

```R
ClassData <- data.frame(matrix(c(1124224,82,1,1122355,72,1,1125465,69,1,1202115,65,0,1456877,81,0,1003219,74,1,1019701,52,0,1126394,79,0,1526974,76,0),ncol=3,byrow=TRUE))
names(ClassData) <- c("StudentNo" ,"Score", "Gender")
ClassData
```

### Calculations
- **Mean Marks**: Calculate the average score of the class.
```R
mean_marks <- mean(ClassData$Score)
mean_marks
```

- **Median Marks**: Calculate the median score of the class.
```R
median_marks <- median(ClassData$Score)
median_marks
```

- **Standard Deviation**: Calculate the standard deviation of the scores.
```R
sd_marks <- sd(ClassData$Score)
sd_marks
```

- **Maximum Female Score**: Find the highest score among female students (Gender = 0).
```R
female_max <- max(ClassData$Score[ClassData$Gender == 0])
female_max
```

- **Sample Size**: Count the number of students.
```R
n <- length(ClassData$StudentNo)
n
```

- **Proportion of Males**: Calculate the proportion of male students (Gender = 1).
```R
prop_male <- mean(ClassData$Gender)
prop_male
```

## Example 2: Trimmed Mean Function

### Function Definition
Creating a function to calculate the trimmed mean of a dataset by removing a specified percentage of the lowest and highest values.

```R
meanTrim = function(X, alpha){
  X <- sort(X)
  n <- length(X)
  
  trim_count <- floor(n*(alpha/2))
  trim_X <- X[trim_count+1:n-trim_count]
  ans <- sum(trim_X)/length(trim_X)
  
  return(ans)
}
```

### Testing the Function
Using the scores from Example 1 to test the custom trimmed mean function and comparing it with R's built-in trimmed mean function.

```R
myFunc <- meanTrim(ClassData$Score,0.1)
buildFunc <- mean(ClassData$Score, trim = 0.1)
myFunc
buildFunc
```
