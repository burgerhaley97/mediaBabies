#' Calculate Percent Changes
#'
#' @param counts A vector of sequential counts
#'
#' @return A vector of percent changes, with the first being 0
#' @export
#'
#' @examples
#' calculate_percent_change(c(1:10))
calculate_percent_change <- function(counts) {
  pc <- c(0, diff(counts) / counts[seq_along(counts) - 1] * 100)
  return(pc)
}

#' Create Percent Change Dataframe
#'
#' @description
#' Creates a dataframe from a names dataframe with percent change year over year
#'   rather than yearly counts
#'
#' @param count_df A dataframe with columns "name" and a bunch of years, where
#'   the years columns contain a count of names within that year.
#'
#' @return A dataframe with columns "name" and a bunch of years, where the years
#'   columns contain a percent change from the last year.
#' @export
create_percent_change_df <- function(count_df) {
  # TODO: Should we have the count df have years as rows and names as cols?
  # Transpose count_df so years are rows and names are columns
  tcount_df <- as.data.frame(t(count_df[, -1]))
  colnames(tcount_df) <- count_df$name

  # Calculate percent changes
  pc_df <- as.data.frame(apply(tcount_df, 2, calculate_percent_change))
  return(pc_df)
}


#' Create Point of Interest Dataframe
#'
#' @param pc_df The percent change dataframe from which to find points of
#'   interest
#' @param pc_cutoff The cutoff above which percent changes (positive or
#'   negative) are interesting
#'
#' @return A dataframe consisting of three columns: name, year, and
#'   percent_change.
#' @export
create_poi_df <- function(pc_df, pc_cutoff = 100.0) {
  # Create df template for poi_df
  poi_df <- data.frame(name = character(),
                       year = integer(),
                       percent_change = numeric(),
                       stringsAsFactors = FALSE)

  for (name in colnames(pc_df)) {
    prev_year_above_cutoff <- FALSE
    for (year in 1:(nrow(pc_df) - 1)) {

      # If the percent change is above the cutoff
      if (abs(pc_df[year, name]) > pc_cutoff) {

        # If the last year was not above the cutoff
        if (!prev_year_above_cutoff) {
          poi_df <- rbind(poi_df,
                          data.frame(name = name,
                                     year = as.integer(rownames(pc_df)[year]),
                                     percent_change = pc_df[year, name]))
        }

        prev_year_above_cutoff <- TRUE
      } else { # If the percent change is not above the cutoff
        prev_year_above_cutoff <- FALSE
      }
    }
  }

  return(poi_df)
}
