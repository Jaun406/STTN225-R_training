# Maximum Likelihood Estimation (MLE) for Chi-Square Distribution

## What is Maximum Likelihood Estimation (MLE)?

Maximum Likelihood Estimation (MLE) is a statistical method used to estimate the parameters of a probability distribution by finding the parameter values that make the observed data most likely. Given a dataset and a model (e.g., a chi-square distribution), MLE identifies the parameter (e.g., degrees of freedom) that maximizes the likelihood function, which measures the probability of observing the data under different parameter values.

In simple terms:
- The **likelihood function** is the product of the probability density function (PDF) evaluated at each data point for a given parameter.
- MLE finds the parameter that maximizes this product.
- To avoid numerical issues (e.g., multiplying many small numbers), we often maximize the **log-likelihood**, which is the sum of the logarithms of the PDFs.

For a dataset $\( x = \{x_1, x_2, \dots, x_n\} $\) and a PDF $\( f(x_i | \theta) \$), the likelihood and log-likelihood are:

$\[
L(\theta) = \prod_{i=1}^n f(x_i | \theta)
$\]

$\[
\ell(\theta) = \sum_{i=1}^n \log f(x_i | \theta)
$\]

The MLE is the $\( \theta $\) that maximizes $\( L(\theta) $\) or $\( \ell(\theta) $\).

## R Code Explanation

The provided R code estimates the degrees of freedom ($\( \theta $\)) for a chi-square distribution using a dataset of 20 observations. It implements MLE in two ways: a **brute-force approach** (evaluating likelihood over a grid) and an **optimization approach** (using R’s `optim` function).

### Dataset

The dataset is a vector of 20 observations assumed to follow a chi-square distribution:

```R
x <- c(2.17310451260809, 2.47856281967841, 2.95866555833281, 3.27184887575012,
       2.12129588072287, 1.77728953105233, 2.84029954019569, 1.11972065864061,
       5.8477633597712, 1.80590247892202, 5.8515783473471, 0.942542192227543,
       1.16024548115314, 1.1985526498937, 0.582235505459959, 1.93012324504033,
       3.1264956189165, 6.73206096962296, 0.496463836350729, 4.39656354416616)
```

### Brute-Force MLE

#### Function: `MLEchisq`

This function estimates $\( \theta $\) by evaluating the likelihood over a grid of values.

```R
MLEchisq <- function(x, G, strt, stp) {
  theta <- seq(strt, stp, length = G)
  lik <- numeric(G)
  for (j in 1:G) {
    ff <- dchisq(x, theta[j])
    lik[j] <- prod(ff)
  }
  jstar <- which(lik == max(lik))
  ans <- theta[jstar]
  return(ans)
}
```

- **Parameters**:
  - `x`: The input dataset.
  - `G`: Number of grid points for $\( \theta $\).
  - `strt`: Start of the grid.
  - `stp`: End of the grid.
- **Process**:
  - Creates a sequence of $\( \theta $\) values from `strt` to `stp` with `G` points.
  - For each $\( \theta $\), computes the chi-square PDF (`dchisq`) for all data points.
  - Calculates the likelihood as the product of these PDFs.
  - Finds the $\( \theta $\) that gives the maximum likelihood.
- **Usage**:
  ```R
  MLEchisq(x, G = 100000, 0.5, 3.5)
  ```
  This tests $\( \theta $\) from 0.5 to 3.5 with 100,000 grid points.
- **Limitation**: Multiplying many small probabilities can cause numerical underflow.

#### Function: `MLEchisqlog`

This function improves on `MLEchisq` by using the log-likelihood for numerical stability.

```R
MLEchisqlog <- function(x, G, strt, stp) {
  theta <- seq(strt, stp, length = G)
  lik <- numeric(G)
  for (j in 1:G) {
    ff <- log(dchisq(x, theta[j]))
    lik[j] <- sum(ff)
  }
  jstar <- which(lik == max(lik))
  ans <- theta[jstar]
  plot(theta, lik, type = "l", lwd = 2)
  abline(v = theta[jstar], lty = 2)
  return(ans)
}
```

- **Parameters**: Same as `MLEchisq`.
- **Process**:
  - Computes the log of the chi-square PDF (`log(dchisq)`) for each $\( \theta $\).
  - Calculates the log-likelihood as the sum of log-PDFs.
  - Finds the $\( \theta $\) that maximizes the log-likelihood.
  - Plots the log-likelihood versus $\( \theta $\), with a vertical line at the MLE.
- **Usage**:
  ```R
  MLEchisqlog(x, G = 100000, 0.5, 4.5)
  ```
  This tests $\( \theta $\) from 0.5 to 4.5 and visualizes the log-likelihood.
- **Advantage**: Using log-likelihood avoids numerical issues.

### Optimization-Based MLE

#### Function: `myloglik`

This function defines the negative log-likelihood for optimization.

```R
myloglik <- function(th) {
  ans <- -sum(log(dchisq(x, th)))
  return(ans)
}
myloglik <- Vectorize(myloglik)
```

- **Purpose**: Computes the negative log-likelihood (since `optim` minimizes).
- **Process**:
  - Takes a single $\( \theta $\) value.
  - Computes the log of the chi-square PDF for each data point.
  - Returns the negative sum of log-PDFs.
- **Vectorization**: Allows `myloglik` to handle vector inputs for plotting.

#### Visualization

This code plots the negative log-likelihood:

```R
th <- seq(0.1, 10, length = 1000)
plot(th, myloglik(th), type = "l")
```

- Creates a sequence of $\( \theta $\) from 0.1 to 10.
- Plots the negative log-likelihood to show where the minimum (i.e., MLE) occurs.

#### Optimization with `optim`

This uses `optim` to find the MLE:

```R
optim(1, myloglik, method = "L-BFGS-B")$par
```

- **Parameters**:
  - `1`: Initial guess for $\( \theta $\).
  - `myloglik`: Function to minimize.
  - `method = "L-BFGS-B"`: Optimization algorithm.
- **Output**: The $\( \theta $\) that minimizes the negative log-likelihood (i.e., maximizes the log-likelihood).

### Summary

- **Brute-Force (`MLEchisq`)**: Tests many $\( \theta $\) values but risks numerical issues.
- **Brute-Force with Log-Likelihood (`MLEchisqlog`)**: More stable and includes a plot.
- **Optimization (`optim`)**: Efficiently finds the MLE using numerical optimization.
- The code estimates the chi-square distribution’s degrees of freedom for the given dataset, with `MLEchisqlog` and `optim` being more reliable due to their use of log-likelihood.
