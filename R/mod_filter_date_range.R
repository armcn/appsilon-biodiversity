mod_filter_date_range <- function(id,
                                  species_occurences,
                                  date_range) {
  moduleServer(id, \(input, output, session) {
    reactive({
      req(
        is_non_empty_tbl(species_occurences()),
        date_range()
      )
      dplyr::filter(
        species_occurences(),
        dplyr::between(
          date,
          left = date_range()[[1]],
          right = date_range()[[2]]
        )
      )
    })
  })
}
