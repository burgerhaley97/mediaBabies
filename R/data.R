#' Characters In Recent Popular Media
#'
#' A subset of data from IMDB consisting of character name segments from recent
#'   (1973 - 2023) highly-rated pieces of media. A name segment is a single-word
#'   part of a name. For example, the name "John Doe" contains two name
#'   segments, "John" and "Doe". Pieces of media consist of movies and series.
#'
#' @format ## `CHARACTERS`
#' A data frame with 22,006 rows and 3 columns:
#' \describe{
#'   \item{name}{The name segment of the character}
#'   \item{title}{The title of the piece of media}
#'   \item{year}{The year the piece of media was first released}
#' }
#' @source <https://developer.imdb.com/non-commercial-datasets/>
"characters"
