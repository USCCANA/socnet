#' SOCNET's listserv web address
#' @export
#' @name socnet-archives
#' @return
#' Currently, the values of both variables is
#' -  `SOCNET_ARCHIVES_WWW`: \Sexpr{socnet::SOCNET_ARCHIVES_WWW}
#' -  `LISTS_UFL_WWW`: \Sexpr{socnet::LISTS_UFL_WWW}
#' @aliases SOCNET_ARCHIVES_WWW
#' @format Character scalars with web addresses.
SOCNET_ARCHIVES_WWW <- "https://lists.ufl.edu/cgi-bin/wa?A0=SOCNET"

#' @rdname socnet-archives
#' @export
#' @aliases LISTS_UFL_WWW
LISTS_UFL_WWW <- "https://lists.ufl.edu"

warn_cached <- function(x) {
  message("Using cached version of SOCNET Listserv")
  message(readLines(
    system.file("cache/readme.md", package="socnet"),
    warn = FALSE)
  )
}

#' List SOCNET archives by month
#' @param url Character scalar. SOCNET's listserv archive website.
#' @template cached
#' @return A data frame.
#' @family SOCNET webscrapping tools
#' @export
socnet_list_archives <- function(
  url    = SOCNET_ARCHIVES_WWW,
  cached = FALSE
  ) {

  # If retrieving cached version of the data
  if (cached) {
    warn_cached()
    url <- system.file("cache/socnet-archives.html", package="socnet")
  }

  ans <- xml2::read_html(url)
  ans <- xml2::xml_find_all(ans, xpath = "//tr/td/ul/li/a")

  data.frame(
    url  = paste0(LISTS_UFL_WWW, xml2::xml_attr(ans, "href")),
    date = xml2::xml_text(ans),
    stringsAsFactors = FALSE
  )
}

#' Coerce a short list of XML nodes (rows) from a particular month's data
#' @param x An XML node from a particular row.
#' @noRd
xml_to_row <- function(x) {
  ans <- data.frame(

    links    = xml2::xml_find_first(x, ".//a") %>%
      xml2::xml_attr(attr = "href"),

    contents = xml2::xml_text(x),

    stringsAsFactors = FALSE

    )

  data.frame(
    url     = paste0(LISTS_UFL_WWW, ans$links[1]),
    subject = ans$contents[1],
    from    = ans$contents[2],
    date    = ans$contents[3],
    size    = ans$contents[4]
  )
}

#' Retrieve the table with the links from a particular archive
#'
#' @param url Character scalar. A web address from a particular SOCNET listserv
#' @template cached
#' @export
#' @family SOCNET webscrapping tools
socnet_list_subjects <- function(
  url,
  cached=FALSE
  ) {

  # If it is more than one
  if (length(url) > 1)
    return(lapply(url, socnet_list_subjects))

  # Checking if it is a cached version
  if (cached) {
    tmp <- paste0(stringr::str_extract(url, "(?<=[=]ind)[0-9]+"), ".zip")
    tmp <- system.file("cache/archives", tmp, package = "socnet")

    # If exists, it must be unzipped
    if (tmp!="") {

      warn_cached()
      url <- unzip(tmp, exdir = tempdir(), unzip="internal")

    } else
      warning("No cached version of ", url,". Downloading from the web.")

  }

  ans <- xml2::read_html(url)

  xml2::xml_find_all(ans, "//table[2][@class='tableframe']") %>%
    xml2::xml_children() %>%
    lapply(xml2::xml_find_all, xpath = ".//p[@class='archive']") %>%
    lapply(xml_to_row) %>% do.call(what = rbind)

}

#' Retrieve contents from a particular subject
#' @param url Character scalar. A web address to a SOCNET Listserv sibject
#' @examples
#' \dontrun{
#' socnet_parse_subject(
#'   "https://lists.ufl.edu/cgi-bin/wa?A2=ind1711&L=SOCNET&T=0&F=&S=&P=47265"
#' )
#' }
#' @export
#' @family SOCNET webscrapping tools
socnet_parse_subject <- function(url) {

  if (length(url) > 1)
    return(lapply(url, socnet_parse_subject))

  # Reading the website
  ans  <- xml2::read_html(url)
  ans2 <- xml2::xml_find_all(ans, "//b[text()='Subject:']") %>%
    xml2::xml_parent() %>%
    xml2::xml_parent() %>%
    xml2::xml_parent() %>%
    xml2::xml_siblings()

  # Getting the metadata
  meta <- ans2 %>% lapply(xml2::xml_find_all, xpath = ".//tt") %>%
    lapply(xml2::xml_text) %>%
    lapply(stringr::str_trim, side="both") %>%
    do.call(what = rbind)

  meta[,2] %>%
    `names<-`(meta[,1])

  # Extracting the contents (plain format)
  contents <- ans %>%
    xml2::xml_find_all(xpath = ".//a[text()='text/plain']") %>%
    xml2::xml_attr(attr="href")

  contents <- paste0(LISTS_UFL_WWW, contents) %>% readLines

  # Returning the output
  structure(
    list(
      meta = meta,
      contents = contents
    )
  )
}





