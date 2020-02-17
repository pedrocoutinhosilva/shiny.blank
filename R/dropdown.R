dropdown <- function(inputId, options = list(), attributes = list()) {

  dropdown_options <- tagList(
    lapply(options, function(option){
      component("option", option)
    })
  )

  options <- list(
    inputId = inputId,
    options = dropdown_options,
    attributes = attributes
  )

  component("dropdown", options)
}
