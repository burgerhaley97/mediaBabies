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

#' Female Baby Name Counts
#'
#' A consolidated dataset from the Social Security Administration website
#'   consisting of female baby names and counts from 1973 to 2022.
#'
#' @format ## `FEMALE_BABIES`
#' A data frame with 50 rows and 61,622 columns:
#' \describe{
#'   \item{name}{There is an individual column for each unique female baby name}
#'   \item{year}{The rownames are the years of 1973 to 2022 and contain the
#'      counts of the baby names for that year}
#' }
#' @source <https://www.ssa.gov/oact/babynames/limits.html>
"female_babies"

#' Male Baby Name Counts
#'
#' A consolidated dataset from the Social Security Administration website
#'   consisting of male baby names and counts from 1973 to 2022.
#'
#' @format ## `MALE_BABIES`
#' A data frame with 50 rows and 39,079 columns:
#' \describe{
#'   \item{name}{There is an individual column for each unique male baby name}
#'   \item{year}{The rownames are the years of 1973 to 2022 and contain the
#'      counts of the baby names for that year}
#' }
#' @source <https://www.ssa.gov/oact/babynames/limits.html>
"male_babies"
