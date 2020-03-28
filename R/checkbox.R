checkbox <- function(inputId, label, value = FALSE, class = "", attributes = "") {
  value <- restoreInput(id = inputId, default = value)

  options <- list(
    inputId = inputId,
    label = label,
    class = class,
    value = ifelse (value, "checked", ""),
    attributes = attributes
  )

  component("checkbox", options)
}
