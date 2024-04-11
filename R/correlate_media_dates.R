
# Unit tests
#
# Should result in Media Influenced Names table
# (columns: name, title, release_year, poi_year, percent_change)

#' @description
#' Find the release date of the media events from the filtered media data frame.
#'
#' @param df Media data frame filtered by baby names. 
#' @return A data frame with years corresponding to the release dates of 
#'    the media events. 
#'    
#' @export
find_media_release_year <- function(df) {
  # Change character column to name
  colnames(df)[colnames(df) == "character"] <- "name"
  
  # Group the data by unique names and find the minimum year for each name
  earliest_years <- aggregate(year ~ name, data = df, FUN = min)
  
  # Merge the original data frame with the earliest year information
  merged_df <- merge(df, earliest_years, by = "name", suffixes = c("", "_earliest"))
  
  # Create a new column 'release_year' with 1 if the year corresponds to the 
  # earliest year for a given name group and 0 otherwise
  merged_df$release_year <- ifelse(merged_df$year == merged_df$year_earliest, 1, 0)
 
  # Remove the 'year_earliest' column
  merged_df <- merged_df[, !grepl("year_earliest", names(merged_df))]
  
  return(merged_df)
}

# test df for media release year function
df <- movie_titles
# Assuming 'df' is your data frame
df <- rbind(df, df)  # Copy each row 3 times
print(df)
# Increment years for the new rows
df$year <- c(1997:2001, 1998:2002)
print(df)


#' Correlate media release year with top percent change baby name years
#' # merge pc_df and media df by name??
#' 
#'  @description
#'  This function take in the pc_df data frame and the media_df with release_year 
#'  column added and creates a final data frame with the poi_years for our media
#'  events. 
#'  
#'  @param pc_df Percent change data frame with names, year, percent_change 
#'      columns. 
#'  @param media_df Filtered media data frame that has release_date
#'  @returns Data frame with new column that corresponds to years that are 
#'      points of interest, poi_year. poi_years are defined as the top 20 
#'      greatest percent change from year to year. 1 for poi_year = TRUE 0 
#'      otherwise.final_df has columns: name, title, release_year, poi_year, 
#'      and percent_change.
#'  
#' @export
correlate_poi_and_media <- function(pc_df) {
# Check if 'percent_change' column exists in the data frame
if (!"percent_change" %in% colnames(df)) {
  stop("Column 'percent_change' not found in the data frame.")
}

# Sort the data frame by 'percent_change' column in descending order
sorted_df <- df[order(-df$percent_change), ]
sorted_df$poi_year <- ifelse(row_number() <= 20, 1, 0)



return(sorted_df)
}