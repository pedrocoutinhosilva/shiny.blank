library(shiny)
library(shiny.grid)

# Define UI for application
ui <- blankPage(
    theme = "nes",
    title = "Blank components",

    HTML(glue::glue(
      '<script>
        Shiny.addCustomMessageHandler("input_do",
          function(message) {{
            alert(JSON.stringify(message));
          }}
        );
      </script>'
    )),

    div(
      style = "margin: 50px",

      checkbox("somevalue", "Some value"),
      verbatimTextOutput("value"),

      # button("do", "Click Me", list(
      #   click = "alert('button pressed')",
      #   mouseover = "console.log('button hovered')"
      # )),

      button("open_modal", "open modal", list(
        click = "modal_aModal.classList.add('open')"
      )),

      modal("aModal", "hi there", TRUE, FALSE),

      uiOutput("green"),
      sliderInput("greenProgress", "N", 1, 100, 50),

      dropdown(
        "dropdown",
        list(
          list(value = 1, label = "one"),
          list(value = 2, label = "two"),
          list(value = 2, label = "three")
        ),
        list(
          "disabled"
        )
      )
    )
)

# Define server logic
server <- function(input, output, session) {

  output$value <- renderText({ input$green })

  output$green <- renderUI(
    progress("green", value = input$greenProgress, type = "is-primary")
  )

  # observeEvent(input$do, {
  #   session$sendCustomMessage(type = 'input_do',
  #     message = 'Thank you for clicking')
  # })
}

# Run the application
shinyApp(ui = ui, server = server)
