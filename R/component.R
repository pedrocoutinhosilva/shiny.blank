component <- function(template = NULL, options = list(), script = NULL, style = NULL, html = NULL) {
  return(
    tagList(
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
  for (argument in names(arguments)) {
    assign(argument, arguments[[argument]])
  }
  attributes <- parseAttributes(attributes)

  HTML(glue::glue(getTemplate(template)))
}

parseAttributes <- function(options = NULL) {
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
}
