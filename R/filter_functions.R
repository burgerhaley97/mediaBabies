#' Function that takes in the movie and baby names data frames and filters and 
#'    returns the filtered movie data frame.
#'    
#' @param movie_titles The data frame with movie character information 
#' @param baby_names The data frame with baby names information.  
#' @returns The filtered movie character data frame with only movie characters
#'    that have a name listed in the baby names data frame.
#' @export    
filter_char_by_baby_names <- function(movie_titles, baby_names) {
  filtered_char <- data_with_titles[movie_titles$character %in% names(baby_names), ]
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
  filtered_names <- baby_names[ , names(baby_names) %in% movie_titles$character]
  return(filtered_names)
}


