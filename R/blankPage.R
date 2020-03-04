blankPage <- function(...,
                      title = NULL,
                      theme = "default"
) {
  setActiveTheme(theme, FALSE)

  tagList(
    if (!is.null(title)) tags$head(tags$title(title)),
    getActiveThemeDependency(),
    ...
  )
}
