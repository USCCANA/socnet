rm(list = ls())

library(socnet)

# Listing archives
archives <- socnet_list_archives(cached = TRUE)

# Reading data
subjects <- suppressMessages(lapply(archives$url, socnet_list_subjects, cached=TRUE))

subjects <- do.call(rbind, subjects)

# Date
time <- stringr::str_replace_all(subjects$date, "^[a-zA-Z]+,\\s+|\\s+([+]|[-])[0-9]+", "")
mon <- sprintf("-%02i-", 1:12)
for (i in 1:12) {

  time <- stringr::str_replace(
    time,
    paste0("\\s+", month.abb[i], "\\s+"),
    mon[i])
}

time <- stringr::str_replace(time, "^([0-9]-)", "0\\1")
time <- lubridate::dmy_hms(time)

subjects$date <- time
subjects$size <- as.integer(stringr::str_replace(subjects$size, "\\s+lines$", ""))

usethis::use_data(subjects, overwrite = TRUE)

