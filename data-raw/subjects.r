rm(list = ls())

library(socnet)

# Listing archives
archives <- socnet_list_archives(cached = TRUE)

# Reading data
subjects <- suppressMessages(lapply(archives$url, socnet_list_subjects, cached=TRUE))

subjects <- do.call(rbind, subjects)

usethis::use_data(subjects, overwrite = TRUE)

