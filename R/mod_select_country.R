mod_select_country_ui <- function(id) {
  ns <- NS(id)
  div(
    class = "select-country",
    selectInput(
      inputId = ns("select_country"),
      label = "Select a country to begin",
      choices = NULL,
      width = "100%"
    )
  )
}

mod_select_country_server <- function(id) {
  moduleServer(id, \(input, output, session) {
    updateSelectInput(
      session = session,
      inputId = "select_country",
      choices = c(none_selected(), get_country_names())
    )
    return(reactive(input$select_country))
  })
}

get_country_names <- function(dir = preprocessed_dir()) {
  list.files(dir) |>
    stringr::str_remove(".csv") |>
    sort()
}
