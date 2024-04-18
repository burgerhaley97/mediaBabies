#' Function that takes in the movie and baby names data frames and filters and
#'    returns the filtered movie data frame.
#'
#' @param movie_titles The data frame with movie character information
#' @param baby_names The data frame with baby names information.
#' @returns The filtered movie character data frame with only movie characters
#'    that have a name listed in the baby names data frame.
#' @export
filter_char_by_baby_names <- function(movie_titles, baby_names) {
  filtered_char <- movie_titles[movie_titles$character %in% names(baby_names), ]
  return(filtered_char)
}

#' Function that takes in the movie and baby names data frames and filters and
#'    returns the filtered baby names data frame.
#'
#' @param baby_names The data frame with baby names information.
#' @param movie_titles The data frame with movie character information
#' @returns The filtered baby names data frame with only names
#'    that have an associated character in the movie titles data frame.
#' @export
filter_baby_names_by_char <- function(baby_names, movie_titles) {
  # filter baby names by characters
  filtered_names <- baby_names[, names(baby_names) %in% movie_titles$character]
  return(filtered_names)
}

#' Filter Baby Names By Names
#'
#' @description
#' Filters a dataframe of names by another dataframe and elminates all names
#'   that are more common in the other dataframe.
#'
#' @param filter_df The dataframe to filter
#' @param filter_by_df The dataframe to filter by
#' @param multiple The ratio of commonness. Values over 1 will allow names to
#'   be included even if they are more common in the other dataframe, while
#'   values uner 1 will eliminate names even if they are less common in the
#'   other data frame.
#'
#' @return The filtered dataframe
#' @export
filter_baby_names_by_names <- function(filter_df, filter_by_df, multiple = 1) {
  common_names <- intersect(names(filter_df), names(filter_by_df))

  filter_common <- filter_df[, common_names, drop = FALSE]
  filter_by_common <- filter_by_df[, common_names, drop = FALSE]

  filter_sums <- colSums(filter_common)
  filter_by_sums <- colSums(filter_by_common)
  ratio <- filter_by_sums / filter_sums

  names_to_remove <- names(ratio)[ratio > multiple]

  filtered_df <- filter_df[, !(names(filter_df) %in% names_to_remove)]
  return(filtered_df)
}
