component <- function(template = NULL, options = list(), script = NULL, style = NULL, html = NULL) {
  return(
    shiny::tagList(
      if(!is.null(template))
        do.call(applyTemplate, modifyList(list(template = template), options)),
      if(!is.null(html)) {
        if(is.character(html)) HTML(html)
        else html
      },
      if(!is.null(script)) tags$script(script),
      if(!is.null(style)) tags$style(style)
    )
  )
}

applyTemplate <- function(template, ...) {
  arguments <- list(...)
  shiny::HTML(do.call(
    glue::glue,
    modifyList(
      list(
          getTemplate(template),
          attributes = parseAttributes(arguments$attributes)
      ),
      arguments
    )
  ))
}

parseAttributes <- function(options = list()) {

  asString <- ""
  if (!is.null(options) && length(options) > 0) {
    for(index in 1:length(options)) {
      attributeNames <- attributes(options)$names

      asString <- ifelse (
        attributeNames[[index]] == "",
        glue::glue("{asString} {options[[index]]} "),
        glue::glue("{asString} {attributeNames[[index]]} = {options[[index]]} ")
      )
    }
  }

  return (asString)
}
