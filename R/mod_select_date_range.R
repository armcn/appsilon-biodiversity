mod_select_date_range_ui <- function(id) {
  ns <- NS(id)
  div(
    class = "select-date-range",
    uiOutput(outputId = ns("select_date_range_ui"))
  )
}

mod_select_date_range_server <- function(id,
                                         species_occurences) {
  moduleServer(id, \(input, output, session) {
    ns <- session$ns
    output$select_date_range_ui <- renderUI({
      req(is_non_empty_tbl(species_occurences()))
      gen_date_range_ui(
        id = ns("select_date_range"),
        dates = species_occurences()$date
      )
    })
    return(reactive(input$select_date_range))
  })
}

gen_date_range_ui <- function(id, dates) {
  min_date <- min(dates)
  max_date <- max(dates)
  tagList(
    hr(),
    dateRangeInput(
      input = id,
      label = "Filter by date",
      start = min_date,
      end = max_date,
      min = min_date,
      max = max_date,
      width = "100%"
    )
  )
}
