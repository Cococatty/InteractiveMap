library(shiny)

#Definte UI for the application
shinyUI((pageWithSidebar(
  
    #Appication Title (On the TOP)
    headerPanel("New Zealand Map", windowTitle = "New Zealand Travel Mean Study"),
    
    #Sidebar with a slider input for the number of categories
    #sidebarLayout(
    #  position= "left",
      
      sidebarPanel(
        helpText("Select the number of categories to..."),
        
      sliderInput("categories", "Number of Categories", min = 1, max = 20, value = 5)
    ),
      
    #Show the map
    mainPanel(
      "Main Panel Here (guess plot etc go here",
      h1("My title", align = "center"),
      textOutput("text"),
      plotOutput("map"),
      position="center",
      width= "auto",
      height= "auto"
    )
  )
))