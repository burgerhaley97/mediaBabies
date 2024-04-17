test_that("media_influenced_names", {

  # create test data frames
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

  # create media influenced names table
  test_df <- create_media_names_df(poi_df, media_df)

  # Compare the filtered data with the expected output
  expect_true(nrow(test_df) == 1)
})
