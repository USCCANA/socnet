#' Complete dataset of SOCNET emails
#' @format A data frame with \Sexpr{nrow(socnet::subjects)} observations and the following variables
#' - `url` Character. URL of the email.
#' - `subject` Character. Title (subject) of the email.
#' - `from` Character. Author of the email.
#' - `date` \Sexpr{paste(class(socnet::subjects$date))}. Date of the email.
#' - `size` Integer. Number of lines of the email.
#'
#' @docType data
#' @source \Sexpr{readLines(system.file("cache","readme.md", package="socnet"), warn=FALSE)}
"subjects"

