#' Create Media Names Dataframe
#'
#' @description
#' Correlates names from poi_df and characters from media_df when the year from
#'   poi_df is within 0 and max_range years after the year from media_df
#'
#' @param poi_df A data frame that contains columns name, year, percent change.
#' @param media_df A data frame with columns name, title, and year.
#' @param max_range The maximum range between a release year and a poi year to
#'   consider significant
#' @return The media_influenced_names data frame with name, title, release_year,
#'    poi_year, and percent_change columns.
#' @export
create_media_names_df <- function(poi_df, media_df, max_range = 5) {
  # Perform the merge on the 'name' and 'character' columns
  merged_data <- merge(poi_df, media_df, by.x = "name", by.y = "character")

  # Filter to keep only rows where year from poi_df is within 0 to max_range
  #   years after year from media_df
  condition_1 <- merged_data$year.x - merged_data$year.y >= 0
  condition_2 <- merged_data$year.x - merged_data$year.y <= max_range
  merged_df <- merged_data[condition_1 & condition_2, ]

  # Put the columns in order and rename them
  merged_df <- merged_df[, c("name",
                             "title",
                             "year.y",
                             "year.x",
                             "percent_change")]
  colnames(merged_df) <- c("name",
                           "title",
                           "release_year",
                           "poi_year",
                           "percent_change")

  return(merged_df)
}
