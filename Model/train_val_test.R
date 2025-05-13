
# Data Preparation

library(dplyr)
library(caret)
library(keras)

## Data Creation
df <- dplyr::tibble(x = 1:1000)
n_obs <- nrow(df)

## Train / Val / Test Split
#We create our own code for splitting data into training, validation, and testing.

train_ratio <- 0.6
validation_ratio <- 0.2
test_ratio <- 1 - train_ratio - validation_ratio

set.seed(123)
sample_size_train <- floor (train_ratio * n_obs)
sample_size_valid <- floor (validation_ratio * n_obs)
sample_size_test <- floor (test_ratio * n_obs)

indices_train <- sort(base::sample(1:n_obs, size = sample_size_train))
indices_not_train <- setdiff(1:n_obs, indices_train)
indices_validation <- sort(base::sample(indices_not_train, size = sample_size_valid))
indices_test <- setdiff(indices_not_train, indices_validation)

train <- df[indices_train, ]
val <- df[indices_validation, ]
test <- df[indices_test, ]

# Function for Train / Validation / Test Split

train_val_test_split <- function(df, train_ratio = .6, val_ratio = .2, test_ratio = .2) {
  n_obs <- nrow(df)
  sample_size_train <- floor (train_ratio * n_obs)
  sample_size_valid <- floor (val_ratio * n_obs)
  sample_size_test <- floor (test_ratio * n_obs)
  
  indices_train <- sort(base::sample(1:n_obs, size = sample_size_train))
  indices_not_train <- setdiff(1:n_obs, indices_train)
  indices_validation <- sort(base::sample(indices_not_train, size = sample_size_valid))
  indices_test <- setdiff(indices_not_train, indices_validation)
  
  train <- df[indices_train, ]
  val <- df[indices_validation, ]
  test <- df[indices_test, ]
  list(train, val, test)
}

#We will use assignment operator from **keras** package.

#Now we have everything in place to perform the split.

c(train, val, test) %<-% train_val_test_split(df)
