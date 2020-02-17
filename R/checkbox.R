checkbox <- function(inputId, label, value = FALSE, attributes = list()) {
  value <- restoreInput(id = inputId, default = value)

  options <- list(
    inputId = inputId,
    label = label,
    value = ifelse (value, "checked", ""),
    attributes = attributes
  )

  component("checkbox", options)
}
