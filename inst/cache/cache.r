rm(list = ls())

library(socnet)

# Getting cached data
dat <- xml2::read_html(SOCNET_ARCHIVES_WWW)
xml2::write_html(dat, "inst/cache/socnet-archives.html")

# Going into the archives
archives <- socnet_list_archives("inst/cache/socnet-archives.html")

arch_id <- stringr::str_extract(
  archives$url, "(?<=[=]ind)[0-9]+[~]?"
)

# Saving the data
for (i in 1:nrow(archives)) {

  # Output name
  oname <- gsub("[~]", "-", arch_id[i])
  zname <- sprintf("inst/cache/archives/%s.zip", oname)
  oname <- sprintf("inst/cache/archives/%s.html", oname)

  # Only update the latest one or if the archives do not exists
  if ((i != 1) & file.exists(zname)) {
    message("Skipping archive id:", arch_id[i])
    next
  }

  # Reading the archive
  a <- xml2::read_html(archives$url[i])

  # Saving it
  xml2::write_html(a, file = oname)

  message("Archive id:", arch_id[i], " done.")

}

# Zipping the data
for (a in arch_id) {

  # Making name
  oname <- gsub("[~]", "-", a)
  zname <- sprintf("inst/cache/archives/%s.zip", oname)
  oname <- sprintf("inst/cache/archives/%s.html", oname)

  if (!file.exists(oname))
    next

  zip(
    zname, oname,
    flags = "-9Xmj" # High compression, Remove extra info, move, and junk path
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
