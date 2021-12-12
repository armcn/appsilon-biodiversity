app_theme <- function() {
  bslib::bs_add_variables(
    theme = bslib::bs_theme(
      version = 5,
      bg = dark_grey(),
      fg = white(),
      primary = yellow(),
      base_font = bslib::font_google("Roboto", wght = 300),
      heading_font = bslib::font_google("Lato"),
      font_scale = 1.2
    ),
    "input-color" = yellow(),
    "input-border-color" = dark_grey(),
    "input-border-radius" = "0px"
  )
}

spinner_start <- function() {
  tagList(
    waiter::use_waiter(),
    waiter::waiter_show_on_load(
      html = waiter::spin_3(),
      color = grey()
    )
  )
}

container <- function(...) {
  div(class = "grid-container", ...)
}

sidebar <- function() {
  div(
    class = "grid-sidebar",
    sidebar_title(),
    mod_select_country_ui("select_country"),
    mod_select_species_ui("select_species"),
    mod_select_date_range_ui("select_date_range")
  )
}

sidebar_title <- function() {
  div(
    class = "sidebar-title",
    h4(
      "Species Tracker",
      style = stringr::str_glue("color: {yellow()};")
    )
  )
}

main <- function() {
  div(
    class = "main",
    mod_map_ui("map"),
    mod_timeseries_ui("timeseries")
  )
}

format_date_range <- function(x) {
  if (dplyr::n_distinct(x) == 1) {
    format_min_date(x)
  } else {
    stringr::str_c(
      format_min_date(x),
      " - ",
      format_max_date(x)
    )
  }
}

format_min_date <- function(x) {
  rep(format_date(min(x)), length(x))
}

format_max_date <- function(x) {
  rep(format_date(max(x)), length(x))
}

format_date <- function(x) {
  format(x, "%B %d, %Y")
}

yellow <- \() "#EEE510"

white <- \() "#FFFFFF"

light_grey <- \() "#808080"

grey <- \() "#454D55"

dark_grey <- \() "#343A40"
