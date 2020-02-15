button <- function(inputId, content = NULL, actions = NULL, active = TRUE) {
  value <- restoreInput(id = inputId, default = NULL)

  script <- tagList(
    lapply(
      names(actions),
      function(action) {
        HTML(glue::glue(
          '$( document ).ready(function() {{
            $("#{inputId}").on("{action}", function(e){{
              {actions[[action]]}
            }});
          }});'
        ))
      }
    )
  )

  options <- list(
    inputId = inputId,
    content = content,
    disabled = ifelse (active, "", "disabled")
  )

  component("button", options, script)
}
