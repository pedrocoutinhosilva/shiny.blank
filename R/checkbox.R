checkbox <- function(inputId, label, value = FALSE, active = TRUE) {
  value <- restoreInput(id = inputId, default = value)

  options <- list(
    inputId = inputId,
    label = label,
    value = ifelse (value, "checked", ""),
    disabled = ifelse (active, "", "disabled")
  )

  component("checkbox", options)
}
