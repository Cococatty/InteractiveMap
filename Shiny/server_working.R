

library(shiny)
#library(rsconnect)


setwd("//file/UsersY$/yzh215/Home/Desktop/Map/Shiny")

source("helper.R")

#Definte server logic required to draw the map
shinyServer(
  function(input, output) {
  
    output$text <- renderText({paste("You have selected ", input$categories, " categories")})
  
    output$map <- renderPlot(nz_map(input$categories)
                              
  )  
  
})
