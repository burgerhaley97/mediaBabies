test_that("calculate_percent_change calculates correctly", {
  # Arrange
  test_counts <- c(1:10, 8, 6, 4, 2)
  expected_percent_changes <- c(0, 100, 50, 33.3333, 25, 20, 16.6667, 14.2857,
                                12.5, 11.1111, -25, -33.33, -50, -100)

  # Act
  actual_percent_changes <- calculate_percent_change(test_counts)

  # Assert
  expect_equal(actual_percent_changes,
               expected_percent_changes,
               tolerance = 0.001)
})

test_that("create_percent_change_df creates df correctly", {
  # Arrange
  test_count_df <- data.frame(Betty = c(33, 71, 83),
                              Murial = c(92, 43, 15),
                              Theola = c(69, 88, 56))
  rownames(test_count_df) <- c(2020, 2021, 2022)
  expected_pc_df <- data.frame(Betty = c(0, 115.1515, 16.9014),
                               Murial = c(0, -113.9535, -186.6667),
                               Theola = c(0, 27.5362, -57.1429))
  rownames(expected_pc_df) <- c(2020, 2021, 2022)

  # Act
  actual_pc_df <- create_percent_change_df(test_count_df)

  # Assert
  expect_equal(actual_pc_df, expected_pc_df, tolerance = 0.001)
})

test_that("create_poi_df creates df correctly with one poi per sequence", {
  # Arrange
  test_pc_df <- data.frame(Betty = c(0, 115.1515, 16.9014),
                           Murial = c(0, -121.4286, -180),
                           Theola = c(0, 27.5362, -57.1429))
  rownames(test_pc_df) <- c(2020, 2021, 2022)
  expected_poi_df <- data.frame(name = c("Betty", "Murial"),
                                year = c(2021, 2021),
                                percent_change = c(115.1515, -121.4286))

  # Act
  actual_poi_df <- create_poi_df(test_pc_df)

  # Assert
  expect_equal(actual_poi_df, expected_poi_df)
})
