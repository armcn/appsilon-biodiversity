test_that("read_country_occurences reads in data", {
  poland_occurences <- read_country_occurences(
    country = "Poland",
    dir_path = file.path("..", "..", preprocessed_dir())
  )

  expect_true(tibble::is_tibble(poland_occurences))
  expect_true(nrow(poland_occurences) > 0)
  expect_true("Poland" %in% poland_occurences$country)
})

test_that("build_country_path builds correct path", {
  expect_equal(
    build_country_path(
      country = "Poland",
      dir_path = "test"
    ),
    "test/Poland.csv"
  )
})
