spinner_stop <- function() {
  waiter::waiter_hide()
}

is_non_empty_tbl <- function(x) {
  tibble::is_tibble(x) && nrow(x) > 0
}

none_selected <- \() "None selected..."

preprocessed_dir <- \() "preprocessed-data"
