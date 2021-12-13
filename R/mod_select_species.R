mod_select_species_ui <- function(id) {
  ns <- NS(id)
  div(
    class = "select-species",
    uiOutput(outputId = ns("select_species_ui"))
  )
}

mod_select_species_server <- function(id,
                                      country_occurences) {
  moduleServer(id, \(input, output, session) {
    ns <- session$ns

    output$select_species_ui <- renderUI({
      req(is_non_empty_tbl(country_occurences()))
      gen_select_species_ui(
        scientific_id = ns("select_scientific_name"),
        vernacular_id = ns("select_vernacular_name"),
        scientific_names = get_scientific_names(
          country_occurences()
        ),
        vernacular_names = get_vernacular_names(
          country_occurences()
        )
      )
    })

    scientific_name <- reactiveVal()
    vernacular_name <- reactiveVal()

    observe({
      req(input$select_scientific_name)
      scientific_name(input$select_scientific_name)
    })
    observe({
      req(input$select_vernacular_name)
      vernacular_name(input$select_vernacular_name)
    })

    observe({
      req(vernacular_name(), country_occurences())
      scientific_name(
        vernacular_to_scientific(
          country_occurences = country_occurences(),
          vernacular_name_val = vernacular_name()
        )
      )
    })
    observe({
      req(scientific_name(), country_occurences())
      vernacular_name(
        scientific_to_vernacular(
          country_occurences = country_occurences(),
          scientific_name_val = scientific_name()
        )
      )
    })

    observe({
      req(vernacular_name())
      updateSelectInput(
        session = session,
        inputId = "select_vernacular_name",
        selected = vernacular_name()
      )
    })
    observe({
      req(scientific_name())
      updateSelectInput(
        session = session,
        inputId = "select_scientific_name",
        selected = scientific_name()
      )
    })

    return(scientific_name)
  })
}

scientific_to_vernacular <- function(country_occurences,
                                     scientific_name_val) {
  if (scientific_name_val == none_selected()) {
    none_selected()
  } else {
    country_occurences |>
      dplyr::filter(
        scientific_name == scientific_name_val
      ) |>
      dplyr::pull("vernacular_name") |>
      dplyr::first()
  }
}

vernacular_to_scientific <- function(country_occurences,
                                     vernacular_name_val) {
  if (vernacular_name_val == none_selected()) {
    none_selected()
  } else {
    country_occurences |>
      dplyr::filter(
        vernacular_name == vernacular_name_val
      ) |>
      dplyr::pull("scientific_name") |>
      dplyr::first()
  }
}

gen_select_species_ui <- function(scientific_id,
                                  vernacular_id,
                                  scientific_names,
                                  vernacular_names) {
  tagList(
    div(
      class = "select-vernacular-name",
      hr(),
      selectInput(
        inputId = vernacular_id,
        label = "Select a species",
        choices = c(none_selected(), vernacular_names),
        width = "100%"
      )
    ),
    div(
      class = "select-scientific-name",
      selectInput(
        inputId = scientific_id,
        label = "or select by scientific name",
        choices = c(none_selected(), scientific_names),
        width = "100%"
      )
    )
  )
}

get_scientific_names <- function(occurences) {
  sort(occurences$scientific_name)
}

get_vernacular_names <- function(occurences) {
  sort(occurences$vernacular_name)
}
