#' Characters In Recent Popular Media
#'
#' A subset of data from IMDB consisting of character name segments from recent
#'   (1973 - 2023) highly-rated pieces of media. A name segment is a single-word
#'   part of a name. For example, the name "John Doe" contains two name
#'   segments, "John" and "Doe". Pieces of media consist of movies and series.
#'
#' @format ## `characters`
#' A data frame with 22,006 rows and 3 columns:
#' \describe{
#'   \item{name}{The name segment of the character}
#'   \item{title}{The title of the piece of media}
#'   \item{year}{The year the piece of media was first released}
#' }
#' @source <https://developer.imdb.com/non-commercial-datasets/>
"characters"

#' Female Baby Names
#'
#' A subset of data from the Social Security Administration consisting of names
#'   given to female babies born 1973 - 2023.
#'
#' @format ## `female_babies`
#' A data frame with 50 rows and 61622 columns:
#' \describe{
#'   \item{names}{The counts of female babies given a particular name, with each
#'      row being a year}
#' }
#' @source <https://developer.imdb.com/non-commercial-datasets/>
"female_babies"

#' Male Baby Names
#'
#' A subset of data from the Social Security Administration consisting of names
#'   given to female babies born 1973 - 2023.
#'
#' @format ## `male_babies`
#' A data frame with 50 rows and 61622 columns:
#' \describe{
#'   \item{names}{The counts of male babies given a particular name, with each
#'      row being a year}
#' }
#' @source <https://developer.imdb.com/non-commercial-datasets/>
"male_babies"
