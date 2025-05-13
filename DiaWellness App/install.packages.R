# This script installs all required packages for the DiaWellness Shiny App.

options(repos = c(CRAN = "https://cloud.r-project.org/"))

required_packages <- c(
  "shiny",
  "caret",
  "e1071",
  "kernlab",
  "pROC",
  "MLmetrics",
  "shinythemes",
  "ggplot2",
  "gridExtra",
  "DT"
)

# Function to check and install packages
install_if_missing <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    message(paste("Installing", pkg, "..."))
    install.packages(pkg, dependencies = TRUE)
  } else {
    message(paste(pkg, "is already installed."))
  }
}

# Apply installation check for all required packages
invisible(lapply(required_packages, install_if_missing))

message("All required packages are installed.")
