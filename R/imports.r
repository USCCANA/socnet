#' @importFrom magrittr "%>%"
#' @importFrom stringr str_extract str_trim
#' @importFrom xml2 read_html xml_find_all xml_text xml_attr xml_find_first
#' xml_children
#' @importFrom utils zip unzip
NULL

#' Webscrap The Social Networks Listserv
#'
#' @description This R package is created to access the data available in the
#' SOCNET website https://lists.ufl.edu/cgi-bin/wa?A0=SOCNET, which is hosted
#' by The University of Florida in its Listserv website.
#'
#' @section What is SOCNET?:
#'
#' From the http://insna.org/socnet.html
#'
#' \dQuote{SOCNET is a LISTSERV list. A LISTSERV list is essentially an
#' automated mail forwarding system in which subscribers send mail to a central
#' address and it is automatically rebroadcast to all other subscribers. The
#' purpose of SOCNET is to allow network researchers worldwide to discuss
#' research and professional issues, make announcements, and request help from
#' each other. Membership in SOCNET costs nothing and is available to all
#' members of INSNA.}
#'
#' @docType package
#' @aliases socnet-package
#' @name socnet
NULL
