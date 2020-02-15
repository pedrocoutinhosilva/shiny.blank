component <- function(template, options = list(), script = NULL, style = NULL) {
  tagList(
    tags$script(script),
    tags$style(style),
    do.call(applyTemplate, modifyList(list(template = template), options))
  )
}

applyTemplate <- function(...) {
  arguments <- list(...)
  for (argument in names(arguments)) {
    assign(argument, arguments[[argument]])
  }

  HTML(glue::glue(activeTemplate[[template]]))
}
