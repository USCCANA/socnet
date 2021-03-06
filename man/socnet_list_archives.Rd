% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/socnet.r
\name{socnet_list_archives}
\alias{socnet_list_archives}
\title{List SOCNET archives by month}
\usage{
socnet_list_archives(url = SOCNET_ARCHIVES_WWW, cached = FALSE)
}
\arguments{
\item{url}{Character scalar. SOCNET's listserv archive website.}

\item{cached}{Logical scalar. When \code{TRUE}, the function will check whether
the website is available in \Sexpr{system.file("cache", package="socnet")}
and read that instead of downloading the current version of the website.}
}
\value{
A data frame in which each observation represents one archive
website. The data frame has two columns:
\itemize{
\item \code{url}: The web address to that archive.
\item \code{date}: The date of the archive.
}
}
\description{
List SOCNET archives by month
}
\details{
Using \code{cached=FALSE} makes more sense if the user is trying to fetch versions
of SOCNET that require update, for example, the "SOCNET archives" website
itself.
}
\examples{

# Listing what is available currently in the cached version.
archives <- socnet_list_archives(cached=TRUE)

}
\seealso{
Other SOCNET webscrapping tools: \code{\link{socnet_list_subjects}},
  \code{\link{socnet_parse_subject}}
}
\concept{SOCNET webscrapping tools}
