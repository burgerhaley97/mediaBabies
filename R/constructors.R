# baby_count -------------------------------------------------------------------

#' baby_count S3 object
#'
#' @param name The name of the baby
#' @param start_year The year at which the vector of counts starts
#' @param vec The vector of counts by year
#'
#' @return The baby_count object
#' @export
#'
#' @examples
#' df <- data.frame(Betty=c(73, 62, 86), Murial=c(93, 63, 27))
#' rownames(df) <- c(1974:1976)
#' baby_count(colnames(df)[1], as.numeric(rownames(df)[1]), df[[1]])
baby_count <- function(name, start_year, vec) {
  obj <- validate_baby_count(name, start_year, vec)

  attr(obj, "name") <- name
  attr(obj, "start_year") <- start_year
  class(obj) <- "baby_count"
  return(obj)
}

#' Validator for baby_count constructor
#'
#' @param name The name of the baby
#' @param start_year The year at which the vector of counts starts
#' @param vec The vector of baby counts per year
#'
#' @return The validated vector
#' @export
#'
#' @examples
#' df <- data.frame(Betty=c(73, 62, 86), Murial=c(93, 63, 27))
#' rownames(df) <- c(1974:1976)
#' validate_baby_count(colnames(df)[1], as.numeric(rownames(df)[1]), df[[1]])
validate_baby_count <- function(name, start_year, vec) {
  if (!is.character(name)) {
    stop("The name must be a string.")
  }

  if (!is.numeric(start_year) && start_year > 0) {
    stop("The start year must be a positive number.")
  }

  if (!is.numeric(vec)) {
    stop("`vec` must be a numeric vector.")
  }

  return(vec)
}

# baby_pc ----------------------------------------------------------------------
#' baby_pc S3 object
#'
#' @param name The name of the baby
#' @param start_year The year at which the vector of percent changes starts
#' @param vec The vector of percent changes by year
#'
#' @return The baby_pc object
#' @export
#'
#' @examples
#' df <- data.frame(Betty=c(-73.5, -62.7, 86.1), Murial=c(93, 63, -27))
#' rownames(df) <- c(1974:1976)
#' baby_pc(colnames(df)[1], as.numeric(rownames(df)[1]), df[[1]])
baby_pc <- function(name, start_year, vec) {
  obj <- validate_baby_pc(name, start_year, vec)

  attr(obj, "name") <- name
  attr(obj, "start_year") <- start_year
  class(obj) <- "baby_pc"
  return(obj)
}

#' Validator for baby_pc constructor
#'
#' @param name The name of the baby
#' @param start_year The year at which the vector of percent changes starts
#' @param vec The vector of percent changes per year
#'
#' @return The validated vector
#' @export
#'
#' @examples
#' df <- data.frame(Betty=c(-73.5, -62.7, 86.1), Murial=c(93, 63, -27))
#' rownames(df) <- c(1974:1976)
#' validate_baby_pc(colnames(df)[1], as.numeric(rownames(df)[1]), df[[1]])
validate_baby_pc <- function(name, start_year, vec) {
  if (!is.character(name)) {
    stop("The name must be a string.")
  }

  if (!is.numeric(start_year) && start_year > 0) {
    stop("The start year must be a positive number.")
  }

  if (!is.numeric(vec)) {
    stop("`vec` must be a numeric vector.")
  }

  return(vec)
}

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
#' df <- data.frame(name=c("Betty","Betty"), title=c("Jumanji", "Phantom"),
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

#' Validator for influences class
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

  if (!(is.character(df[["name"]]) &&
          is.character(df[["title"]]) &&
          is.numeric(df[["release_year"]]) &&
          is.numeric(df[["poi_year"]]) &&
          is.numeric(df[["percent_change"]]))) {
    stop(paste("`df` should have five columns with the following format:",
               "name (char), title(char), release_year (int),",
               "poi_year (int), and percent_change (double)."))
  }

  if (!all(df$name == df$name[1])) {
    stop("All entries in the dataframe must be for the same name.")
  }

  return(df)
}
