library(shiny)
library(shiny.grid)

# Define UI for application
ui <- blankPage(
    theme = "default",
    title = "Blank components",

    gridPanel(
      columns = "repeat(5, 1fr)",
      gap = "30px",

      gridPanel(
        rows = "1fr 30px 1fr",

        tags$script(glue::glue('
          Shiny.addCustomMessageHandler("button_server_message",
            function(message) {{
              $("#button_server_message").text(message);
            }}
          );
        ')),

        h2("Button with server message"),
        button("button_server", "Trigger message via server"),
        div(id = "button_server_message")
      ),

      gridPanel(
        rows = "1fr 30px 1fr",

        h2("Button with javascript message"),
        button("button_javascript", "Trigger message via javascript",
          list(
            "click" = '$("#button_javascript_message").text(String(new Date()));'
          )
        ),
        div(id = "button_javascript_message")
      ),

      gridPanel(
        rows = "1fr 1fr 1fr",
        h2("Checkbox"),
        checkbox("test_checkbox", "A checkbox"),
        verbatimTextOutput("checkbox_message")
      ),

      gridPanel(
        rows = "1fr 1fr 1fr",
        h2("Progress"),
        div(
          slider("progress_slider", 25),
          uiOutput("test_progress")
        ),
        verbatimTextOutput("progress_message")
      ),

      gridPanel(
        rows = "1fr 1fr 1fr",
        h2("Input Text"),
        input("test_input_text", "Test Text Input", "A default text"),
        verbatimTextOutput("input_text_message")
      ),

      gridPanel(
        rows = "1fr 1fr 1fr",
        h2("Input Number"),
        input("test_input_number", "Test Number Input", 3, type = "number"),
        verbatimTextOutput("input_number_message")
      ),

      gridPanel(
        rows = "1fr 1fr 1fr",
        h2("Input Date"),
        input("test_input_date", "Test Date Input", type = "date"),
        verbatimTextOutput("input_date_message")
      ),

      gridPanel(
        rows = "1fr 1fr 1fr",
        h2("Input Datelocal"),
        input("test_input_datelocal", "Test DateTime Input", type = "datetime-local"),
        verbatimTextOutput("input_datelocal_message")
      ),

      gridPanel(
        rows = "1fr 1fr 1fr",
        h2("Input Checkbox"),
        input("test_input_checkbox", "Test Checkbox Input", type = "checkbox"),
        verbatimTextOutput("input_checkbox_message")
      ),

      gridPanel(
        rows = "1fr 1fr 1fr",
        h2("Input Color"),
        input("test_color_input", "Test Color Input", type = "color"),
        verbatimTextOutput("input_color_message")
      ),

      gridPanel(
        rows = "1fr 1fr 1fr",
        h2("Input Week"),
        input("test_input_week", "Test Week Input", type = "week"),
        verbatimTextOutput("input_week_message")
      ),

      gridPanel(
        rows = "1fr 1fr 1fr",
        h2("Input Month"),
        input("test_input_month", "Test Month Input", type = "month"),
        verbatimTextOutput("input_month_message")
      ),

      gridPanel(
        rows = "1fr 1fr 1fr",
        h2("Input Time"),
        input("test_input_time", "Test Time Input", type = "time"),
        verbatimTextOutput("input_time_message")
      ),

      gridPanel(
        rows = "1fr 1fr 1fr",
        h2("Input Radio Group"),
        div(
          radio("radio_one", "Radio Group", "one"),
          radio("radio_two", "Radio Group", "two"),
          radio("radio_three", "Radio Group", "three", TRUE),
          radio("radio_four", "Radio Group", "four")
        ),
        verbatimTextOutput("input_radio_message")
      ),

      gridPanel(
        rows = "1fr 30px 1fr",
        h2("Dropdown"),
        dropdown(
          "test_dropdown",
          list(
            list(value = 1, label = "one"),
            list(value = 2, label = "two"),
            list(value = 3, label = "three")
          )
        ),
        verbatimTextOutput("test_dropdown_message")
      ),

      gridPanel(
        rows = "1fr 30px 1fr",
        h2("Disabled Dropdown"),
        dropdown(
          "test_dropdown_disabled",
          list(
            list(value = 1, label = "one"),
            list(value = 2, label = "two"),
            list(value = 3, label = "three")
          ),
          list(
            "disabled"
          )
        ),
        verbatimTextOutput("test_dropdown_disabled_message")
      )
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
    progress("progress", value = input$progress_slider, type = "is-primary")
  })
  output$progress_message <- renderText({ input$progress_slider })

  # Inputs
  output$input_text_message <- renderText({ input$test_input_text })
  output$input_number_message <- renderText({ input$test_input_number })
  output$input_date_message <- renderText({ input$test_input_date })
  output$input_datelocal_message <- renderText({ input$test_input_datelocal })
  output$input_checkbox_message <- renderText({ input$test_input_checkbox })
  output$input_color_message <- renderText({ input$test_color_input })
  output$input_week_message <- renderText({ input$test_input_week })
  output$input_month_message <- renderText({ input$test_input_month })
  output$input_time_message <- renderText({ input$test_input_time })
  output$input_radio_message <- renderText({ input$`Radio Group` })
  output$test_dropdown_message <- renderText({ input$test_dropdown })
  output$test_dropdown__disabled_message <- renderText({ input$test_dropdown_disabled })
}

# Run the application
shinyApp(ui = ui, server = server)
