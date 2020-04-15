input <- function(inputId, label, value = "", type = "text", class = "", attributes = "") {
  if (type == "date") value <- as.character(Sys.Date())
  if (type == "week") value <- format(Sys.time(), "%Y-W%W")
  if (type == "month") value <- format(Sys.time(), "%Y-%m")
  if (type == "time") value <- format(Sys.time(), "%H:%M")
  if (type == "datetime-local") value <- format(Sys.time(), "%Y-%m-%dT%H:%M")
  if (type == "checkbox" && value == "") value <- FALSE
  if (type == "color" && value == "") value <- "#000000"

  script <- glue::glue("
    var input_<<inputId>> = document.getElementById('<<inputId>>');

    shinyReady(function() {
      $(input_<<inputId>>).val('<<value>>');
      Shiny.setInputValue('<<inputId>>', '<<value>>', {priority : 'event'});
    });
  ", .open = "<<", .close = ">>")

  if (type %in% c("date", "color", "datetime-local", "week", "month", "time")) {
    script <- glue::glue("
      <<script>>
      input_<<inputId>>.addEventListener('input', function() {
        $(input_<<inputId>>).val(this.value);
        Shiny.setInputValue('<<inputId>>', this.value, {priority : 'event'})
      });
    ", .open = "<<", .close = ">>")
  }
  value <- restoreInput(id = inputId, default = value)

  options <- list(
    inputId = inputId,
    label = label,
    class = class,
    value = value,
    type = type,
    attributes = attributes
  )

  component("input", options, script)
}
