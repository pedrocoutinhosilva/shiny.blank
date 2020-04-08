slider <- function(inputId, value = 0, min = 0, max = 100, type = "", attributes = "") {
  value <- restoreInput(id = inputId, default = value)

  options <- list(
    inputId = inputId,
    value = value,
    min = min,
    max = max,
    type = type,
    attributes = glue::glue("{attributes} data-value={value}")
  )

  script <- glue::glue("
    $( document ).ready(function() {
      Shiny.setInputValue('<<inputId>>', <<value>>, {priority : 'event'});
    });
    var slider_<<inputId>> = document.getElementById('<<inputId>>');
    slider_<<inputId>>.addEventListener('input', function() {
      $(slider_<<inputId>>).val(this.value).attr('value', this.value);
      Shiny.setInputValue('<<inputId>>', this.value, {priority : 'event'})
    });
  ", .open = "<<", .close = ">>")

  component("slider", options, script)
}
