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
  pc <- c(0, diff(counts) / pmin(counts[seq_along(counts) - 1],
                                 counts[-1]) * 100)

  # Replace all NaN with 0
  pc[is.nan(pc)] <- 0

  # Replace all +- INF with +- 10000
  pc[is.infinite(pc)] <- ifelse(sign(pc[is.infinite(pc)]) == 1, 10000, -10000)
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
  pc_df <- as.data.frame(apply(count_df, 2, calculate_percent_change))
  rownames(pc_df) <- rownames(count_df)
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
