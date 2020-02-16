dropdown <- function(inputId, options = list(), active = TRUE) {

  dropdown_options <- tagList(
    lapply(options, function(option){
      component("option", option)
    })
  )

  options <- list(
    inputId = inputId,
    disabled = ifelse (active, "", "disabled"),
    options = dropdown_options
  )

  component("dropdown", options)
}
