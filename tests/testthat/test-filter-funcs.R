test_that("filter_char_by_baby_names", {
  # Sample movie titles data
  movie_titles <- data.frame(
    year = 1997:2001,
    title = paste("Movie", 1:length(1997:2001)),
    character = c("Alice", "Bob", "Charlotte", "Evelyn", "David"),
    stringsAsFactors = FALSE
  )
  
  # Sample baby names data
  baby_names <- data.frame(
    Elizabeth = c(12358, 12264, 12472),
    Emily = c(3028, 4330, 5483),
    Charlotte = c(1330, 1251, 1080),
    Evelyn = c(1015, 941, 867))
  rownames(baby_names) <- as.character(1997:1999)
  
  filtered_df <- filter_char_by_baby_names(movie_titles, baby_names)
  
  # Expected output
  expected_output <- data.frame(
    character = c("Charlotte", "Evelyn"),
    stringsAsFactors = FALSE
  )
  
  # Compare the filtered data with the expected output
  expect_equal(filtered_df$character, expected_output$character)
  
})

test_that("filter_baby_names_by_char", {
  # Sample movie titles data
  movie_titles <- data.frame(
    year = 1997:2001,
    title = paste("Movie", 1:length(1997:2001)),
    character = c("Alice", "Bob", "Charlotte", "Evelyn", "David"),
    stringsAsFactors = FALSE
  )
  
  # Sample baby names data
  baby_names <- data.frame(
    Elizabeth = c(12358, 12264, 12472),
    Emily = c(3028, 4330, 5483),
    Charlotte = c(1330, 1251, 1080),
    Evelyn = c(1015, 941, 867))
  rownames(baby_names) <- as.character(1997:1999)
  
  filtered_df <- filter_baby_names_by_char(baby_names, movie_titles)
  
  # Expected output
  expected_output <- data.frame(
    character = c("Charlotte", "Evelyn"),
    stringsAsFactors = FALSE
  )
  
  # Compare the filtered data with the expected output
  expect_equal(names(filtered_df), expected_output$character)
  
})
