# Bootstrap Confidence Interval Explanation

This document explains the R code for computing bootstrap confidence intervals for the coefficient of variation (CV) and the median of a dataset using two functions: `BootCI` and `BootCIHYB`. The code is designed to perform bootstrap resampling to estimate confidence intervals for these statistics.

## Dataset
The dataset `x` is a numeric vector containing 114 observations. It represents the data for which we want to compute confidence intervals for the coefficient of variation (CV) and the median.

## Functions Overview

### `BootCI` Function
The `BootCI` function computes a bootstrap confidence interval for the coefficient of variation (CV), defined as the standard deviation divided by the mean of a sample.

**Parameters:**
- `X`: The input dataset (numeric vector).
- `B`: The number of bootstrap resamples.
- `alpha`: The significance level for the confidence interval (e.g., 0.05 for a 95% confidence interval).

**Steps:**
1. Initialize an empty vector `vec` to store the CV values from bootstrap samples.
2. For each of the `B` iterations:
   - Generate a bootstrap sample `Xstar` by sampling with replacement from `X`.
   - Compute the CV as `sd(Xstar) / mean(Xstar)`.
   - Store the CV in `vec`.
3. Sort the `vec` in ascending order.
4. Calculate the indices `r` and `s` for the lower and upper quantiles:
   - `r = floor(B * alpha / 2)` for the lower quantile.
   - `s = floor(B * (1 - alpha / 2))` for the upper quantile.
5. Compute the confidence interval using the pivotal method:
   - `lower = 2 * median(X) - vec[s]`
   - `upper = 2 * median(X) - vec[r]`
6. Return the lower and upper bounds of the confidence interval.

### `BootCIHYB` Function
The `BootCIHYB` function computes a bootstrap confidence interval for the median of the dataset.

**Parameters:**
- Same as `BootCI`: `X` (dataset), `B` (number of resamples), and `alpha` (significance level).

**Steps:**
1. Initialize an empty vector `vec` to store the median values from bootstrap samples.
2. For each of the `B` iterations:
   - Generate a bootstrap sample `Xstar` by sampling with replacement from `X`.
   - Compute the median of `Xstar`.
   - Store the median in `vec`.
3. Sort the `vec` in ascending order.
4. Calculate the indices `r` and `s` for the lower and upper quantiles (same as in `BootCI`).
5. Compute the confidence interval using the pivotal method:
   - `lower = 2 * median(X) - vec[s]`
   - `upper = 2 * median(X) - vec[r]`
6. Return the lower and upper bounds of the confidence interval.

## Key Differences
- **`BootCI`** focuses on the coefficient of variation (CV), which measures the relative variability of the data.
- **`BootCIHYB`** focuses on the median, which measures the central tendency of the data.
- Both functions use the pivotal bootstrap method to construct confidence intervals, which involves reflecting the bootstrap distribution around the observed statistic (median of `X`).

## Example Usage
The code calls both functions with the dataset `x`, using `B = 10000` resamples and `alpha = 0.05` (for a 95% confidence interval):

```R
BootCI(x, 10000, 0.05)
BootCIHYB(x, 10000, 0.05)
```

- `BootCI(x, 10000, 0.05)` computes the 95% confidence interval for the CV of `x`.
- `BootCIHYB(x, 10000, 0.05)` computes the 95% confidence interval for the median of `x`.

## Why Bootstrap?
The bootstrap method is used to estimate the sampling distribution of a statistic (CV or median) by resampling the data with replacement. This approach is particularly useful when the theoretical distribution of the statistic is unknown or complex, allowing for robust confidence interval estimation without strong parametric assumptions.

## Notes
- The pivotal method used here (`2 * median(X) - vec[s/r]`) is a common technique in bootstrap confidence interval construction, leveraging the symmetry of the bootstrap distribution.
- The dataset `x` contains a mix of small and large values, which may affect the variability and robustness of the CV and median estimates.
- Increasing `B` (number of resamples) improves the accuracy of the confidence intervals but increases computation time.

## How to Run
1. Ensure you have R installed.
2. Copy the dataset `x` and the functions `BootCI` and `BootCIHYB` into an R script.
3. Run the function calls as shown above to obtain the confidence intervals.
4. The output will be a vector of two values: the lower and upper bounds of the confidence interval.

This code is suitable for statistical analysis tasks requiring robust estimation of confidence intervals for the coefficient of variation or median.
The output will be a vector of two values: the lower and upper bounds of the confidence interval.

This code is suitable for statistical analysis tasks requiring robust estimation of confidence intervals for the coefficient of variation or median.
