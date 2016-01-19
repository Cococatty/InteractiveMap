require(shiny)
runApp(
  list(
    ui = pageWithSidebar(
      headerPanel("multi-line test"),
      sidebarPanel(
        p("Demo Page.")
      ),
      mainPanel(
        verbatimTextOutput("text"),
        htmlOutput("text2")
      )
    ),
    server = function(input, output){
      
      output$text <- renderText({
        paste("hello", "world", sep="\n")
      })
      
      output$text2 <- renderUI({
        HTML(paste("hello", "world", sep="<br/>"))
      })
      
    }
  )
)