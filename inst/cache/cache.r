rm(list = ls())

library(socnet)

# Getting cached data
dat <- xml2::read_html(SOCNET_ARCHIVES_WWW)
xml2::write_html(dat, "inst/cache/socnet-archives.html")

# Going into the archives
archives <- socnet_list_archives("inst/cache/socnet-archives.html")

arch_id <- stringr::str_extract(
  archives$url, "(?<=[=]ind)[0-9]+"
)

# Saving the data
for (i in 1:nrow(archives)) {

  # Reading the archive
  a <- xml2::read_html(archives$url[i])

  # Saving it
  xml2::write_html(
    a,
    file = sprintf("inst/cache/archives/%s.html", arch_id[i])
    )

  message("Archive id:", arch_id[i], " done.")

}

# Zipping the data
for (a in arch_id) {
  zip(
    sprintf("inst/cache/archives/%s.zip", a),
    sprintf("inst/cache/archives/%s.html", a), flags = "-9Xmj" # High compression, Remove extra info, move, and junk path
  )

  message("File ", a," correctly zipped.")
}


cat(
  sprintf(
    "The cached version of SOCNET_ARCHIVES_WWW (%s) was last updated on %s.",
    SOCNET_ARCHIVES_WWW,
    Sys.time()
    ),
  file = "inst/cache/readme.md"
  )
