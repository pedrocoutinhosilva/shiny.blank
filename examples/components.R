library(shiny)
library(shiny.grid)

# Define UI for application
ui <- gridPage(
    title = "Blank components",
    dependency = NULL,

    HTML('<link href="https://unpkg.com/nes.css@2.3.0/css/nes.min.css" rel="stylesheet" />'),
    HTML('<link href="https://fonts.googleapis.com/css?family=Press+Start+2P" rel="stylesheet">'),

    div(
      style = "margin: 51px; background: lightgray;",

      checkboxInput("somevalue2", "Some value", FALSE),
      verbatimTextOutput("value2"),

      checkbox("somevalue", "Some value", FALSE),
      verbatimTextOutput("value"),

      button("do", "Click Me", "alert(JSON.stringify(message));")
    )
)

# Define server logic
server <- function(input, output, session) {
  output$value <- renderText({ input$somevalue })
  output$value2 <- renderText({ input$somevalue2 })

  observeEvent(input$do, {
    session$sendCustomMessage(type = 'input_do',
      message = 'Thank you for clicking')
  })
}

# Run the application
shinyApp(ui = ui, server = server)
