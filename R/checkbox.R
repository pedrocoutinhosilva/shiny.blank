checkbox <- function(inputId, label, value = FALSE, active = TRUE) {
  value <- restoreInput(id = inputId, default = value)

  options <- options(
    inputId = inputId,
    label = label,
    value = ifelse (value, "checked", ""),
    disabled = ifelse (active, "", "disabled")
  )

  component("checkbox", options)
}
