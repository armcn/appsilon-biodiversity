preprocess <- function() {
  raw_country_files <- file.path(
    preprocessed_dir(),
    list.files(preprocessed_dir())
  )

  purrr::walk(
    raw_country_files,
    \(file) {
      readr::read_csv(file) |>
        clean_occurence_data() |>
        readr::write_csv(file)
    }
  )
}

clean_occurence_data <- function(occurence_data) {
  occurence_data |>
    dplyr::select(
      country,
      latitude = latitudeDecimal,
      longitude = longitudeDecimal,
      scientific_name = scientificName,
      vernacular_name = vernacularName,
      date = eventDate,
      count = individualCount
    ) |>
    dplyr::filter(!is.na(vernacular_name)) |>
    dplyr::distinct()
}
