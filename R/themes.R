availableThemes <- function() {
  themes_dir <- system.file("themes", package = "shiny.blank")
  list.dirs(
    themes_dir,
    recursive = FALSE,
    full.names = FALSE
  )
}

getTemplate <- function(template) {
  themes_dir <- system.file("themes", package = "shiny.blank")

  template_path <- paste(themes_dir, getActiveTheme(), "templates", paste0(template, ".html"), sep = "/")

  paste(readLines(template_path), collapse="\n")
}

setActiveTheme <- function(theme, force = TRUE) {
  if (!(theme %in% availableThemes()))
    stop("Theme not available")

  if (!exists("active_theme") || force)
    assign("active_theme", theme, envir = .GlobalEnv)
}

getActiveTheme <- function() {
  if (!exists("active_theme")) setActiveTheme("default")

  return (active_theme)
}

getActiveThemeDependency <- function() {
  getThemeDependency(getActiveTheme())
}

getThemeDependency <- function(theme) {
  switch(
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
}
