library(googleVis)
library(shiny)


# Define UI for iris application
ui <- pageWithSidebar(
  headerPanel("Example 1: scatter chart"),
    sidebarPanel(
      selectInput("dataset", "Choose a dataset:", 
                  choices = c("rock", "pressure", "cars"))
    ),
    mainPanel(
      htmlOutput("view")
    )
  )



server <- function(input, output, session) {
  # Contributed by Joe Cheng, February 2013
  # Requires googleVis version 0.4.0 and shiny 0.4.0 or higher
  # server.R

    datasetInput <- reactive({
      switch(input$dataset,
             "rock" = rock,
             "pressure" = pressure,
             "cars" = cars)
    })
    
    output$view <- renderGvis({
      gvisScatterChart(datasetInput(), options=list(width=400, height=450))
    })
}


shinyApp(ui = ui, server = server)