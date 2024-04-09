test_that("influences obj should have name attribute", {
  # Arrange
  test_df <- data.frame(name = c("Betty", "Betty"),
                        title = c("Jumanji", "Phantom"),
                        release_year = c(1996, 1990),
                        poi_year = c(1996, 1991),
                        percent_change = c(154.6532, -233.9874))
  expected_name_attr <- "Betty"
  expected_class_attr <- "influences"

  # Act
  betty_influences <- influences(test_df)

  # Assert
  expect_equal(attr(betty_influences, "name"), expected_name_attr)
  expect_equal(class(betty_influences), expected_class_attr)
})

test_that("validate_influences should throw error when too many/few columns", {
  # Arrange
  test_df_short <- data.frame(name = c("Betty", "Betty"),
                              title = c("Jumanji", "Phantom"),
                              release_year = c(1996, 1990),
                              poi_year = c(1996, 1991))
  test_df_long <- data.frame(name = c("Betty", "Betty"),
                             title = c("Jumanji", "Phantom"),
                             release_year = c(1996, 1990),
                             poi_year = c(1996, 1991),
                             percent_change = c(154.6532, -233.9874),
                             extra_column = c("wrong", "length"))

  # Assert
  expect_error(influences(test_df_short))
  expect_error(influences(test_df_long))
})

test_that("validate_influences should throw error when column names wrong", {
  # Arrange
  test_df <- data.frame(baby = c("Betty", "Betty"),
                        show = c("Jumanji", "Phantom"),
                        release_year = c(1996, 1990),
                        poi_year = c(1996, 1991),
                        percent_change = c(154.6532, -233.9874))

  # Assert
  expect_error(influences(test_df))
})

test_that("validate_influences should throw error if wrong data types", {
  # Arrange
  test_df <- data.frame(name = c("Betty", "Betty"),
                        title = c("Jumanji", "Phantom"),
                        release_year = c("1996", "1990"),
                        poi_year = c(1996, 1991),
                        percent_change = c(154.6532, -233.9874))

  # Assert
  expect_error(influences(test_df))
})
