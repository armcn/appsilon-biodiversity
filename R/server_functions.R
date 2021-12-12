filter_country <- function(occurences,
                           country_val) {
  dplyr::filter(occurences, country == country_val)
}

filter_scientific_name <- function(occurences,
                                   scientific_name_val) {
  dplyr::filter(
    occurences,
    scientific_name == scientific_name_val
  )
}

filter_vernacular_name <- function(occurences,
                                   vernacular_name_val) {
  dplyr::filter(
    occurences,
    vernacular_name == vernacular_name_val
  )
}

filter_date_range <- function(occurences,
                              min_date,
                              max_date) {
  dplyr::filter(
    occurences,
    dplyr::between(date, min_date, max_date)
  )
}

spinner_stop <- function() {
  waiter::waiter_hide()
}

is_non_empty_tbl <- function(x) {
  tibble::is_tibble(x) && nrow(x) > 0
}

is_non_empty_vector <- function(x) {
  is.atomic(x) && length(x) > 0
}

none_selected <- \() "None selected..."

raw_dir <- \() "biodiversity-data"

preprocessed_dir <- \() "preprocessed-data"
