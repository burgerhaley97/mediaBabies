# baby_count -------------------------------------------------------------------



# baby_pc ----------------------------------------------------------------------




# influences -------------------------------------------------------------------

#' influences S3 class
#'
#' @param df The dataframe to convert to an influences object. Should have five
#'   columns: name, title, release_year, poi_year, and percent_change.
#'
#' @return The influences object
#' @export
#'
#' @examples
#' df <- data.frame(name=c("Betty","Murial"), title=c("Jumanji", "Phantom"),
#'   release_year=c(1996, 1990), poi_year=c(1996, 1991),
#'   percent_change=c(154.6532, -233.9874))
#' influences(df)
#'
influences <- function(df) {
  obj <- validate_influences(df)

  attr(obj, "name") <- obj$name[1]
  class(obj) <- "influences"
  return(obj)
}

#' influence class validator
#'
#' @param df The dataframe to validate. Should have five
#'   columns: name, title, release_year, poi_year, and percent_change.
#'
#' @return The validated dataframe
#' @export
validate_influences <- function(df) {
  if (length(df) != 5) {
    stop("`df` must be a dataframe with five columns")
  }

  if (!all.equal(colnames(df), c("name", "title", "release_year",
                                 "poi_year", "percent_change"))) {
    stop(paste("`df` must have the following named columns:",
               "name, title, release_year, poi_year, percent_change"))
  }

  if (!(is.character(df[[1]]) && is.character(df[[2]]) && is.numeric(df[[3]]) &&
          is.numeric(df[[4]]) && is.numeric(df[[5]]))) {
    stop(paste("`df` should have five columns with the following format:",
               "name (char), title(char), release_year (int),",
               "poi_year (int), and percent_change (double)."))
  }

  if (!all(df$name == df$name[1])) {
    stop("All entries in the dataframe must be for the same name.")
  }

  return(df)
}
