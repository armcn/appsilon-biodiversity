mod_map_title_ui <- function(id) {
  ns <- NS(id)
  div(
    class = "map-title",
    uiOutput(outputId = ns("title"))
  )
}

mod_map_title_server <- function(id, filtered_occurences) {
  moduleServer(id, \(input, output, session) {
    output$title <- renderUI({
      req(is_non_empty_tbl(filtered_occurences()))
      p(build_map_title(filtered_occurences()))
    })
  })
}

build_map_title <- function(occurences) {
  dplyr::first(
    stringr::str_c(
      occurences$vernacular_name,
      " (", occurences$scientific_name, "), ",
      occurences$country, ", ",
      format_date_range(occurences$date)
    )
  )
}
