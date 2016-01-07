library(shiny)

#Definte UI for the application
shinyUI((fluidPage(
  
  #Appication Title (On the TOP)
  #headerPanel("New Zealand Map", windowTitle = "New Zealand Travel Mean Study"),
  title = "New Zealand Map",
  plotOutput("map"),
  
  # Draw a breakline
  hr(),
  
  #sidebarPanel (
  h4("Select the number of categories"),
  sliderInput("categories", "Number of Categories", min = 1, max = 20, value = 5)
  #)
  )
))