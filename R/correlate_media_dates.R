#' @description
#' A function that creates a media_influenced_names data frame.
#'
#' @param poi_df A data frame that contains the year, percent change,
#'    baby names from the create_poi_df function.
#' @param media_df A data frame with the name, title, and release year for the
#'    media data.
#' @return The media_influenced_names data frame with name, title, release_year,
#'    poi_year, and percent_change columns.
#' @export
media_influenced_names <- function(poi_df, media_df){
  # only keep rows from  poi_df  and media_df where the poi_year and
  # is +5  or less years from the media release year
  # Rename columns in the data frames
  df1 <- rename(poi_df, poi_year = year)
  df2 <- rename(media_df, name = character, release_year = year)

  # Perform a cross join using cross_join(), then filter
  merged_df <- cross_join(df1, df2) %>%
    filter(poi_year >= release_year, poi_year <= release_year + 5)

  # make sure that columns are correclty ordered an remove repeat name column
  final_df <- merged_df %>%
    select(name.x, title, release_year, poi_year, percent_change) %>%
    rename(name = name.x)

  return(final_df)
}

media_df <- data.frame(
  character = c("Leia", "Jamie"),
  title = c("Star Wars", "Stranger Things"),
  year = c(1973, 2021)
)

poi_df <- data.frame(
  name = c("Leia", "Jamie"),
  percent_change = c(67, 114),
  year = c(1980, 2023)
)

library(dplyr)
media_influenced_names(poi_df, media_df)

