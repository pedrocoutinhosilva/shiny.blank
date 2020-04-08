library(shiny)
library(shiny.grid)

# Define UI for application
ui <- blankPage(
    theme = "default",
    title = "Blank components",

    gridPanel(
      rows = "3fr 1fr 1fr",

      tags$script(glue::glue('
        Shiny.addCustomMessageHandler("button_server_message",
          function(message) {{
            $("#button_server_message").text(message);
          }}
        );
      ')),

      h1("Button with server message"),
      button("button_server", "Trigger message via server"),
      div(id = "button_server_message")
    ),

    gridPanel(
      rows = "3fr 1fr 1fr",

      h1("Button with javascript message"),
      button("button_javascript", "Trigger message via javascript",
        list(
          "click" = '$("#button_javascript_message").text(String(new Date()));'
        )
      ),
      div(id = "button_javascript_message")
    ),

    gridPanel(
      rows = "3fr 1fr 1fr",
      h1("Checkbox"),
      checkbox("test_checkbox", "A checkbox"),
      verbatimTextOutput("checkbox_message")
    ),

    gridPanel(
      rows = "1fr 1fr 1fr 1fr",
      h1("Progress"),
      uiOutput("test_progress"),
      slider("progress_slider", 25),
      verbatimTextOutput("progress_message")
    )
)

# Define server logic
server <- function(input, output, session) {

  # button
  observeEvent(input$button_server, {
    session$sendCustomMessage(type = 'button_server_message',
    message = as.character(Sys.time()))
  })

  # Checkbox
  output$checkbox_message <- renderText({ input$test_checkbox })

  # Progress
  output$test_progress <- renderUI({
    browser()
    print(names(input))
    progress("progress", value = input$progress_slider, type = "is-primary")
  })
  output$progress_message <- renderText({ input$progress_slider })
}

# Run the application
shinyApp(ui = ui, server = server)
