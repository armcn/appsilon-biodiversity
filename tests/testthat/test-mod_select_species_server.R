mock_data <- tibble::tibble(
  scientific_name = c("Grus grus", "Tyto alba"),
  vernacular_name = c("Common Crane", "Western Barn Owl")
)

testServer(
  mod_select_species_server,
  args = list(country_occurences = reactive(mock_data)),
  {
    session$setInputs(
      select_scientific_name = none_selected()
    )

    session$setInputs(
      select_vernacular_name = none_selected()
    )

    expect_equal(scientific_name(), none_selected())
    expect_equal(vernacular_name(), none_selected())
    expect_equal(session$returned(), none_selected())
  }
)

testServer(
  mod_select_species_server,
  args = list(country_occurences = reactive(mock_data)),
  {
    session$setInputs(
      select_vernacular_name = none_selected()
    )

    session$setInputs(
      select_scientific_name = "Grus grus"
    )

    expect_equal(scientific_name(), "Grus grus")
    expect_equal(vernacular_name(), "Common Crane")
    expect_equal(session$returned(), "Grus grus")
  }
)

testServer(
  mod_select_species_server,
  args = list(country_occurences = reactive(mock_data)),
  {
    session$setInputs(
      select_scientific_name = none_selected()
    )

    session$setInputs(
      select_vernacular_name = "Western Barn Owl"
    )

    expect_equal(vernacular_name(), "Western Barn Owl")
    expect_equal(scientific_name(), "Tyto alba")
    expect_equal(session$returned(), "Tyto alba")
  }
)

testServer(
  mod_select_species_server,
  args = list(country_occurences = reactive(mock_data)),
  {
    session$setInputs(
      select_vernacular_name = none_selected()
    )

    session$setInputs(
      select_scientific_name = "Grus grus"
    )

    expect_equal(scientific_name(), "Grus grus")
    expect_equal(vernacular_name(), "Common Crane")
    expect_equal(session$returned(), "Grus grus")

    session$setInputs(
      select_vernacular_name = "Western Barn Owl"
    )

    expect_equal(vernacular_name(), "Western Barn Owl")
    expect_equal(scientific_name(), "Tyto alba")
    expect_equal(session$returned(), "Tyto alba")
  }
)

testServer(
  mod_select_species_server,
  args = list(country_occurences = reactive(mock_data)),
  {
    session$setInputs(
      select_scientific_name = "Grus grus"
    )

    session$setInputs(
      select_scientific_name = none_selected()
    )

    expect_equal(scientific_name(), none_selected())
    expect_equal(vernacular_name(), none_selected())
    expect_equal(session$returned(), none_selected())
  }
)

testServer(
  mod_select_species_server,
  args = list(country_occurences = reactive(mock_data)),
  {
    session$setInputs(
      select_vernacular_name = "Common Crane"
    )

    session$setInputs(
      select_vernacular_name = none_selected()
    )

    expect_equal(scientific_name(), none_selected())
    expect_equal(vernacular_name(), none_selected())
    expect_equal(session$returned(), none_selected())
  }
)
