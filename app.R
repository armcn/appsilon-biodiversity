ui <- fillPage(
  theme = app_theme(),
  includeCSS("www/styles.css"),
  spinner_start(),
  container(sidebar(), main())
)

server <- function(input, output, session) {
  country <- mod_select_country_server(
    id = "select_country"
  )

  country_occurences <- mod_read_country_occurences(
    id = "read_country_occurences",
    country = country,
    dir_path = preprocessed_dir()
  )

  scientific_name <- mod_select_species_server(
    id = "select_species",
    country_occurences = country_occurences
  )

  species_occurences <- mod_filter_scientific_name(
    id = "filter_scientific_name",
    country_occurences = country_occurences,
    scientific_name = scientific_name
  )

  date_range <- mod_select_date_range_server(
    id = "select_date_range",
    species_occurences = species_occurences
  )

  filtered_occurences <- mod_filter_date_range(
    id = "filter_date_range",
    species_occurences = species_occurences,
    date_range = date_range
  )

  mod_map_server(
    id = "map",
    filtered_occurences = filtered_occurences
  )

  mod_timeseries_server(
    id = "timeseries",
    filtered_occurences = filtered_occurences
  )

  spinner_stop()
}

shinyApp(ui = ui, server = server)
