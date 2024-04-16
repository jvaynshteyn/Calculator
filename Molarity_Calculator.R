library(shiny)

# Define the UI
ui <- fluidPage(
  titlePanel("Solution Mass Calculator"),
  sidebarLayout(
    sidebarPanel(
      numericInput("formulaWeight", "Formula weight (g/mol):", value = 1),
      numericInput("finalVolume", "Desired final volume (mL):", value = 1),
      numericInput("concentration", "Desired concentration (mM):", value = 1),
      actionButton("calculate", "Calculate Mass")
    ),
    mainPanel(
      textOutput("result")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  result <- eventReactive(input$calculate, {
    # Calculate the mass in mg
    ((input$concentration * input$finalVolume) / 1000000) * input$formulaWeight 
  })
  
  output$result <- renderText({
    if (input$calculate > 0) {
      paste("Required mass (mg):", format(result(), digits = 4))
    }
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

