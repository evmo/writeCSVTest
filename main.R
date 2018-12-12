library(tidyverse)
library(data.table)
library(nycflights13)
library(microbenchmark)

sw <- function(fun, num_samples, num_rows) {
  # sample & write
  i <- 1
  for (i in 1:num_samples) {
    sample_n(flights, size = num_rows) %>%
      fun(file.path("data", paste0(i, ".csv")))
    i <- i + 1
  }
}

# 10 samples of 10 rows
microbenchmark(sw(write.csv, 10, 10))
microbenchmark(sw(fwrite, 10, 10))
microbenchmark(sw(write_csv, 10, 10))

# 100 samples of 100 rows
microbenchmark(sw(write.csv, 100, 100))
microbenchmark(sw(fwrite, 100, 100))
microbenchmark(sw(write_csv, 100, 100))
