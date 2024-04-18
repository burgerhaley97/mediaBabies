## code to prepare `babyNames` dataset

library(tidyverse)
library(data.table)

# pulling in text files from data-raw folder
listfile <- list.files("data-raw/babyNames",
                       pattern = "txt", full.names = TRUE, recursive = TRUE)

# Unique Baby Names
# creates df of unique names for each gender
unique_names <- function(listfile) {
  m_name <- c()
  f_name <- c()
  for (i in seq_along(listfile)){
    # adding in name and gender info
    dat <- read.table(listfile[i], header = FALSE, sep = ",")
    # identify genders
    m_rows <- (dat[, 2] == "M")
    f_rows <- (dat[, 2] == "F")
    # add names to list
    m_name <- c(m_name, dat[m_rows, 1])
    f_name <- c(f_name, dat[f_rows, 1])
  }
  # remove duplicate names
  m_name <- unique(m_name)
  f_name <- unique(f_name)
  # convert to data frame
  m_name <- as.data.frame(m_name)
  f_name <- as.data.frame(f_name)
  names(m_name) <- "baby_name"
  names(f_name) <- "baby_name"
  return(list(m_name, f_name))
}

# Name counts by year
# Add yearly counts to the names in unique names list
name_counts <- function(listfile, names_list) {
  # unique names lists
  m_name <- names_list[[1]]
  f_name <- names_list[[2]]
  # for each txt file...
  for (i in seq_along(listfile)){
    # empty vectors to store name counts
    male_info <- c()
    fem_info <- c()
    # extract year from file name
    year <- substring(listfile[i], 23, 26)
    # extract data from file
    dat <- read.table(listfile[i], header = FALSE, sep = ",")
    # identify male and female data rows
    male_rows <- (dat[, 2] == "M")
    fem_rows <- (dat[, 2] == "F")
    # add name and count info to vectors
    male_info <- c(male_info, dat[male_rows, c(1, 3)])
    fem_info <- c(fem_info, dat[fem_rows, c(1, 3)])
    # convert to a dataframe
    male_info <- as.data.frame(male_info)
    fem_info <- as.data.frame(fem_info)
    # assign names to dataframe
    names(male_info) <- c("baby_name", year)
    names(fem_info) <- c("baby_name", year)
    # join name count data to the unique baby names lists
    m_name <- left_join(m_name, male_info, by = "baby_name")
    f_name <- left_join(f_name, fem_info, by = "baby_name")
  }
  # replace all nas in year column with 0s
  m_name[is.na(m_name)] <- 0
  f_name[is.na(f_name)] <- 0
  return(list(m_name, f_name))
}

# Function to transpose data frame
transposed_df <- function(name_counts) {
  # dataframes of name and count data
  m_counts <- name_counts[[1]]
  f_counts <- name_counts[[2]]
  # transposing all but name column
  m_counts_t <- transpose(m_counts[, -1])
  f_counts_t <- transpose(f_counts[, -1])
  # assigning the years to be the row names and names to be column names
  rownames(m_counts_t) <- colnames(m_counts[, -1])
  colnames(m_counts_t) <- m_counts[, 1]
  rownames(f_counts_t) <- colnames(f_counts[, -1])
  colnames(f_counts_t) <- f_counts[, 1]
  return(list(m_counts_t, f_counts_t))
}

# Running the functions
# unique names
uniq_baby_names <- unique_names(listfile)
# name counts
baby_name_counts <- name_counts(listfile, uniq_baby_names)
# transposed data
baby_name_counts_t <- transposed_df(baby_name_counts)

# male and female baby name data
male_babies <- baby_name_counts_t[[1]]
female_babies <- baby_name_counts_t[[2]]

usethis::use_data(male_babies, overwrite = TRUE)
usethis::use_data(female_babies, overwrite = TRUE)
