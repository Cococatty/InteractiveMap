data_sets <- c("mtcars", "morley", "rock")

server <- function(input, output) {
  
  # Drop-down selection box for which data set
  output$choose_dataset <- renderUI({
    selectInput("dataset", "Data set", as.list(data_sets))
  })
  
  # Check boxes
  output$choose_columns <- renderUI({
    # If missing input, return to avoid error later in function
    if(is.null(input$dataset))
      return()
    
    # Get the data set with the appropriate name
    dat <- get(input$dataset)
    colnames <- names(dat)
    
    # Create the checkboxes and select them all by default
    checkboxGroupInput("columns", "Choose columns", 
                       choices  = colnames,
                       selected = colnames)
  })
  
  
  # Output the data
  output$data_table <- renderTable({
    # If missing input, return to avoid error later in function
    if(is.null(input$dataset))
      return()
    
    # Get the data set
    dat <- get(input$dataset)
    
    # Make sure columns are correct for data set (when data set changes, the
    # columns will initially be for the previous data set)
    if (is.null(input$columns) || !(input$columns %in% names(dat)))
      return()
    
    # Keep the selected columns
    dat <- dat[, input$columns, drop = FALSE]
    
    # Return first 20 rows
    head(dat, 20)
  })
}

ui <-
  shinyUI(pageWithSidebar(
    
    headerPanel(""),
    
    sidebarPanel(
      uiOutput("choose_dataset"),
      
      uiOutput("choose_columns"),
      br(),
      a(href = "https://gist.github.com/4211337", "Source code")
    ),
    
    
    mainPanel(
      tableOutput("data_table")
    )
  ))


shinyApp(ui = ui, server = server)