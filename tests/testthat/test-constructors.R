# baby_count -------------------------------------------------------------------
test_that("baby_count obj should have a name and start_year attribute", {
  # Arrange
  test_df <- data.frame(Betty = c(73, 62, 86), Murial = c(93, 63, 27))
  rownames(test_df) <- c(1974:1976)
  expected_name_attr <- "Betty"
  expected_start_year_attr <- 1974
  expected_class_attr <- "baby_count"

  # Act
  baby <- baby_count(colnames(test_df)[1],
                     as.numeric(rownames(test_df)[1]),
                     test_df[[1]])

  # Assert
  expect_equal(attr(baby, "name"), expected_name_attr)
  expect_equal(attr(baby, "start_year"), expected_start_year_attr)
  expect_equal(class(baby), expected_class_attr)
})

test_that("baby_count constructor should throw an error if data not correct", {
  # Arrange
  test_vec_good_type <- c(73, 62, 86)
  test_vec_bad_type <- c("73", "62", "86")

  # Act
  # Assert
  expect_error(baby_count(666, 1976, test_vec_good_type))
  expect_error(baby_count("Murial", "1976", test_vec_good_type))
  expect_error(baby_count("Murial", 1976, test_vec_bad_type))
})

# baby_pc -------------------------------------------------------------------
test_that("baby_pc obj should have a name and start_year attribute", {
  # Arrange
  test_df <- data.frame(Betty = c(73, 62, 86), Murial = c(93, 63, 27))
  rownames(test_df) <- c(1974:1976)
  expected_name_attr <- "Betty"
  expected_start_year_attr <- 1974
  expected_class_attr <- "baby_pc"

  # Act
  baby <- baby_pc(colnames(test_df)[1],
                  as.numeric(rownames(test_df)[1]),
                  test_df[[1]])

  # Assert
  expect_equal(attr(baby, "name"), expected_name_attr)
  expect_equal(attr(baby, "start_year"), expected_start_year_attr)
  expect_equal(class(baby), expected_class_attr)
})

test_that("baby_pc constructor should throw an error if data not correct", {
  # Arrange
  test_vec_good_type <- c(73, 62, 86)
  test_vec_bad_type <- c("73", "62", "86")

  # Act
  # Assert
  expect_error(baby_pc(666, 1976, test_vec_good_type))
  expect_error(baby_pc("Murial", "1976", test_vec_good_type))
  expect_error(baby_pc("Murial", 1976, test_vec_bad_type))
})

# influences -------------------------------------------------------------------
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
