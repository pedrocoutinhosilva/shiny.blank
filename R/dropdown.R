dropdown <- function(inputId, label, value = FALSE) {
  value <- restoreInput(id = inputId, default = value)

  if (!is.null(value) && value) value <- "checked"

  HTML(glue::glue(activeTemplate$dropdown))
}
