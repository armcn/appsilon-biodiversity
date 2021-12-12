mod_timeseries_ui <- function(id) {
  ns <- NS(id)
  div(
    class = "plot box",
    plotly::plotlyOutput(
      outputId = ns("timeseries"),
      width = "100%",
      height = "100%"
    )
  )
}

mod_timeseries_server <- function(id, filtered_occurences) {
  moduleServer(id, \(input, output, session) {
    output$timeseries <- plotly::renderPlotly({
      req(is_non_empty_tbl(filtered_occurences()))
      filtered_occurences() |>
        calc_daily_occurences() |>
        plot_timeseries()
    })
  })
}

calc_daily_occurences <- function(filtered_occurences) {
  filtered_occurences |>
    dplyr::group_by(date) |>
    dplyr::summarise(
      count = sum(count),
      scientific_name = dplyr::first(scientific_name),
      vernacular_name = dplyr::first(vernacular_name)
    )
}

plot_timeseries <- function(daily_occurences) {
  daily_occurences |>
    plotly::plot_ly() |>
    plotly::add_trace(
      type = "bar",
      x = ~date,
      y = ~count,
      marker = list(color = yellow()),
      hoverinfo = "text",
      hovertext = ~ format_tooltip(
        vernacular_name = vernacular_name,
        scientific_name = scientific_name,
        count = count,
        date = date
      )
    ) |>
    plotly::layout(
      xaxis = list(
        title = "Date",
        showgrid = FALSE,
        zeroline = FALSE,
        tickformat = "%b %d, %Y",
        color = white()
      ),
      yaxis = list(
        title = "Count observed",
        showgrid = FALSE,
        zeroline = FALSE,
        color = white()
      ),
      paper_bgcolor = dark_grey(),
      plot_bgcolor = dark_grey()
    )
}

format_tooltip <- function(vernacular_name,
                           scientific_name,
                           count,
                           date) {
  stringr::str_c(
    vernacular_name, " (", scientific_name, ")",
    "<br>",
    format_date(date),
    "<br>",
    "Count observed: ", count
  )
}
