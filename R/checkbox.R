checkbox <- function(inputId, label, value = FALSE) {
  value <- restoreInput(id = inputId, default = value)

  if (!is.null(value) && value) value <- "checked"

  HTML(glue::glue('
    <label>
      <input id={inputId} type="checkbox" class="nes-checkbox" {value} />
      <span>{label}</span>
    </label>
  '))
}
