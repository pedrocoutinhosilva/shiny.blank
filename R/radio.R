radio <- function(inputId, name, value, state = FALSE, label = value, attributes = "") {
  value <- restoreInput(id = name, default = value)

  options <- list(
    inputId = inputId,
    name = glue::glue("group_{name}"),
    label = label,
    value = value,
    state = ifelse (state, "checked", ""),
    attributes = attributes
  )

  script <- glue::glue("
    var input_<<inputId>> = document.getElementById('<<inputId>>');
  ", .open = "<<", .close = ">>")

  if (state) {
    script <- glue::glue("
      <<script>>
      shinyReady(function() {
        Shiny.setInputValue('<<name>>', '<<value>>', {priority : 'event'});
      });
    ", .open = "<<", .close = ">>")
  }

  script <- glue::glue("
    <<script>>
    input_<<inputId>>.addEventListener('input', function() {
      Shiny.setInputValue('<<name>>', '<<value>>', {priority : 'event'});
    });
  ", .open = "<<", .close = ">>")

  component("radio", options, script)
}
