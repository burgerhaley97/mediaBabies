library(DBI)

# Set queries
media_query <- paste("SELECT m.tconst,",
                     "m.primaryTitle AS title,",
                     "m.startYear AS year",
                     "FROM media m")

# Read in the data from the db
con <- dbConnect(RSQLite::SQLite(), "data-raw/media_data_raw.db")
chars <- RSQLite::dbGetQuery(con, "SELECT * FROM characters")
media <- RSQLite::dbGetQuery(con, media_query)

# Combine all characters with the same tconst
chars_combined <- aggregate(characters ~ tconst,
                            data = chars,
                            FUN = function(x) paste(x, collapse = " "))

# Replace commas with spaces
chars_combined$characters <- gsub(",", " ", chars_combined$characters)

# Remove non-letter characters
chars_combined$characters <- gsub("[^a-zA-Z ]", "", chars_combined$characters)

# Split each individual character name
chars_split <- strsplit(chars_combined$characters, " ")

chars_clean <- unique(data.frame(
  tconst = rep(chars_combined$tconst, sapply(chars_split, length)),
  character = unlist(chars_split)
))

# Merge the two dataframes on the tconst column
characters <- merge(chars_clean, media, by = "tconst")
characters <- CHARACTERS[, !(names(CHARACTERS) %in% "tconst")]

usethis::use_data(characters, overwrite = TRUE)
