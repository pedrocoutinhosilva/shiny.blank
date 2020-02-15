blankPage <- function(
  ...,
  title = NULL,
  theme = "default"
) {
  setTemplate(theme)

  dependency <- switch(
    theme,
    "default" = NULL,
    "bootstrap" = bootstrapLib(),
    "nes" = tagList(
      HTML('<link href="https://unpkg.com/nes.css@2.3.0/css/nes.min.css" rel="stylesheet" />'),
      HTML('<link href="https://fonts.googleapis.com/css?family=Press+Start+2P" rel="stylesheet">')
    ),
    "pure" = tagList(
      HTML('<link rel="stylesheet" href="https://unpkg.com/purecss@1.0.1/build/pure-min.css" integrity="sha384-oAOxQR6DkCoMliIh8yFnu25d7Eq/PHS21PClpwjOTeU2jRSq11vu66rf90/cZr47" crossorigin="anonymous">')
    )
  )

  tagList(
    if (!is.null(title)) tags$head(tags$title(title)),
    dependency,
    ...
  )
}
