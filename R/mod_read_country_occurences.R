mod_read_country_occurences <- function(id,
                                        country,
                                        dir_path) {
  moduleServer(id, \(input, output, session) {
    eventReactive(
      req(country() != none_selected()),
      read_country_occurences(
        country = country(),
        dir_path = dir_path
      ),
      ignoreInit = TRUE
    )
  })
}

read_country_occurences <- function(country, dir_path) {
  country |>
    build_country_path(dir_path) |>
    readr::read_csv(
      col_types = readr::cols_only(
        country = readr::col_character(),
        scientific_name = readr::col_character(),
        vernacular_name = readr::col_character(),
        latitude = readr::col_double(),
        longitude = readr::col_double(),
        count = readr::col_integer(),
        date = readr::col_date()
      )
    )
}

build_country_path <- function(country, dir_path) {
  file.path(dir_path, stringr::str_c(country, ".csv"))
}
