getTemplates <- function() {
  lapply(list.files(system.file("themes", package = "shiny.blank")), function(theme) {
    print(paste0(system.file("themes", package = "shiny.blank"), theme))
    jsonlite::read_json(paste0(system.file("themes", package = "shiny.blank"), "/", theme))
  })
}

getTemplate <- function(theme = NULL) {
  if(file.exists(paste0(system.file("themes", package = "shiny.blank"), "/", theme, ".json")))
    return(jsonlite::read_json(paste0(system.file("themes", package = "shiny.blank"), "/", theme, ".json")))
  else
    return(jsonlite::read_json(paste0(system.file("themes", package = "shiny.blank"), "/","default", ".json")))
}

setTemplate <- function(theme) {
  assign("activeTemplate", getTemplate(theme), envir = .GlobalEnv)
}
