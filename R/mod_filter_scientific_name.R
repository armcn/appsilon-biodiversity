mod_filter_scientific_name <- function(id,
                                       country_occurences,
                                       scientific_name) {
  moduleServer(id, \(input, output, session) {
    reactive({
      req(
        country_occurences(),
        scientific_name() != none_selected()
      )
      dplyr::filter(
        country_occurences(),
        scientific_name == scientific_name()
      )
    })
  })
}
