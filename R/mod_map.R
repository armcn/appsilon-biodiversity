mod_map_ui <- function(id) {
  ns <- NS(id)
  div(
    class = "grid-map box",
    mod_map_title_ui(ns("map_title")),
    div(
      class = "map",
      leaflet::leafletOutput(
        outputId = ns("map"),
        width = "100%",
        height = "100%"
      )
    )
  )
}

mod_map_server <- function(id, filtered_occurences) {
  moduleServer(id, \(input, output, session) {
    mod_map_title_server(
      id = "map_title",
      filtered_occurences = filtered_occurences
    )
    output$map <- leaflet::renderLeaflet({
      req(is_non_empty_tbl(filtered_occurences()))
      plot_map(filtered_occurences())
    })
  })
}

plot_map <- function(filtered_occurences) {
  filtered_occurences |>
    leaflet::leaflet() |>
    leaflet::addTiles(
      urlTemplate = "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png"
    ) |>
    leaflet::addCircleMarkers(
      lng = ~longitude,
      lat = ~latitude,
      label = ~ gen_label(count, vernacular_name),
      stroke = FALSE,
      fillColor = yellow(),
      fillOpacity = 1,
      radius = ~ scale_radius(count, max_radius = 10)
    )
}

gen_label <- function(count, vernacular_name) {
  stringr::str_glue("{vernacular_name} ({count})")
}

scale_radius <- function(x, max_radius) {
  sqrt_x <- sqrt(x)
  sqrt_x / max(sqrt_x) * max_radius
}
