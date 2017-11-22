#' @param cached Logical scalar. When `TRUE`, the function will check whether
#' the website is available in \Sexpr{system.file("cache", package="socnet")}
#' and read that instead of downloading the current version of the website.
#'
#' @details
#' Using `cached=FALSE` makes more sense if the user is trying to fetch versions
#' of SOCNET that require update, for example, the "SOCNET archives" website
#' itself.
