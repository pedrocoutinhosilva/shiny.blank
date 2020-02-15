button <- function(inputId, content = NULL, action = NULL) {
  value <- restoreInput(id = inputId, default = NULL)

  tagList(
    HTML(glue::glue(
      '<script>
        Shiny.addCustomMessageHandler("input_{inputId}",
          function(message) {{
            {action}
          }}
        );
      </script>'
    )),
    HTML(glue::glue('
      <button id={inputId} type="button" class="action-button">{content}</button>
    '))
  )
}
