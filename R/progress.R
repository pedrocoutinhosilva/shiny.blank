progress <- function(inputId, value = 0, max = 100, type = "", attributes = "") {
  value <- restoreInput(id = inputId, default = value)

  options <- list(
    inputId = inputId,
    value = value,
    max = max,
    type = type,
    attributes = attributes
  )

  component("progress", options)
}
