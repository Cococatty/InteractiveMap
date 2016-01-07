library(shiny)
library(DT)
#library(rsconnect)


setwd("//file/UsersY$/yzh215/Home/Desktop/GitHub/InteractiveMap/Shiny")

source("helper.R")

#Definte server logic required to draw the map
shinyServer(
  function(input, output) {
    
    output$text1 <- renderText({paste("Travel mean: ", meandata$MeanName[meandata$MeanCode == input$travelMean])})
    output$text2 <- renderText({paste("Selected ", input$categories, " categories")})
    
    output$map <- renderPlot(nz_map(input$categories, input$travelMean, input$classIntMethod))
    
    updatenewtable <- reactive({
      newtable <- subset(newtable, newtable$MeanCode == input$travelMean, select = -c(MeanCode)
                         , colnames = c('Territory', 'Mean Name', 'Number of People', 'Overall weight'))
      newtable <- newtable[order(newtable$Percentage),]
      newtable
    })
    
    output$table <- renderTable({
        updatenewtable()}
      , include.rownames = FALSE
      , options = list(paging = FALSE, searching = FALSE)
      , #caption = c('Territory', 'Mean Name', 'Number of People', 'Overall weight')
      colnames = c('Territory', 'Mean Name', 'Number of People', 'Overall weight')
    )   
                                #orderClasses = TRUE 
                                #order = list(2, 'asc')
    
    #output$tblwCheckbox <- DT::renderDataTable({updatenewtable()}, options = list(lengthChange = FALSE)) #select-row
  })
