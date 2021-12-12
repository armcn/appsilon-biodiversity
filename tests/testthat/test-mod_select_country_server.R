testServer(mod_select_country_server, {
  session$setInputs(select_country = none_selected())

  expect_equal(session$returned(), none_selected())

  session$setInputs(select_country = "Poland")

  expect_equal(session$returned(), "Poland")
})

test_that("get_country_names returns list of countries", {
  country_names <- get_country_names(
    dir = file.path("..", "..", preprocessed_dir())
  )

  expect_true("Poland" %in% country_names)
})
