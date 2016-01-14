# 
# pck <- c("shiny", "DT")
# require(pck) || install.packages(pck)
# 
# library(shiny)
# library(DT)

require("shiny") || install.packages("shiny")
require("DT") || install.packages("DT")


#setwd("//file/UsersY$/yzh215/Home/Desktop/GitHub/InteractiveMap/Shiny")
setwd("/home/cococatty/Desktop/InteractiveMap/Shiny")

source("helper.R")

minGrp <- 1
maxGrp <- 2


#Definte UI for the application
ui <- shinyUI(pageWithSidebar(
      sliderInput("categories", "Number of Categories", min = 1, max = 10, value = 5
      )
      
      , selectInput(
                  "classIntMethod"#, "Division Method"
                  , label = "Select the intervals"
                  , choices = list("Equal" = "equal"
                                   , "Fisher" = "fisher"
                                   , "Fixed"= "fixed"
                                   , "Pretty" = "pretty"
                                   , "Quantiles" = "quantile"
                                   , "Standard Deviation" = "sd"
                  )
                  , selected = "quantile"
                  #                        , selectize = FALSE
                  , multiple = FALSE
                  #                        , width = "auto"
      )
      
      , br()
      
      # The following part is SelectInput format for the TravelMean
      #         selectInput("travelMean", "Travel Mean"
      #                       , label = "Select the mean below:"
      #                       , choices = meanChoices
      #                       , multiple = TRUE
      #                       , width = "100%"
      #         )
      
      # The following part is groupCheckBox format for the TravelMean
      , checkboxGroupInput(
        "travelMean"
        #                    , "Travel Mean"
        , label = "Select the mean below:"
        , choices = meanChoices
        , selected = NULL
        #, inline = FALSE
      )
      
      , br()
      , height = "10%"
    ),
    
    #Show the map
    mainPanel(
      
      h3("Map of New Zealand", align = "center")
      , h4(textOutput("text1"), align = "center")
      , h4(textOutput("text2"), align = "center")
      , h4("Data is in percentages", align = "center")
      
      , tabsetPanel(#type = "tabs",
          tabPanel("Single-Mean Table", tableOutput("onetable")  )
          , tabPanel("Single-Mean Plot", plotOutput("oneMap"))
          , tabPanel("Two-Mean Table", tableOutput("biTable")  )
          , tabPanel("Two-Mean Plot", plotOutput("biMap"))
      )
      
      , position="center"
      , width= "auto"
      , height= "auto"
    )
)
  



#Definte server logic required to draw the map
server <- function(input, output, session) {
    
    updateoneTable <- reactive({
      onetable <- subset(newtable, newtable$MeanCode == tail(input$travelMean, 1), select = -c(MeanCode)
                         , colnames = c('Territory', 'Mean Name', 'Number of People', 'Overall weight'))
      onetable <- onetable[order(onetable$Percentage),]
    })
    
    output$onetable <- renderTable({
      updateoneTable()}
      , include.rownames = FALSE
      , options = list(paging = FALSE, searching = FALSE)
      , caption = paste("Travel mean: ", tail(input$travelMean, 1))
      , caption.placement = getOption("xtable.caption.placement", "top")
      , caption.width = getOption("xtable.caption.width", NULL)
      #, colnames = c('Territory', 'Mean Name', 'Number of People', 'Overall weight')
    )
    
    observe({
      if (length(input$travelMean) > maxGrp)
      {
        updateCheckboxGroupInput(session, 'travelMean', selected = tail(input$travelMean,maxGrp))
      }
    })
    

      test <- xtabs(as.numeric(Ppl) ~ AreaCode + MeanCode, data=geodata)
      test <- as.table(test)
      test <- test[, input$travelMean, drop=FALSE]
      #test <- test[!(test$dimnames$AreaCode == 'MeanCode' & test$dimnames$MeanCode == 'AreaCode'), ]
      #test <- test[!(test$MeanCode == 'MeanCode' & test$AreaCode == 'AreaCode'), ]
      
      output$biTable <- renderTable({
        test
      })
        
        
     
#    renderTable({
#       updatebiTable()}
#       , include.rownames = FALSE
#       , options = list(paging = FALSE, searching = FALSE)
#       , caption = paste("Travel mean: ", input$travelMean, 1)
#       , caption.placement = getOption("xtable.caption.placement", "top")
#       , caption.width = getOption("xtable.caption.width", NULL)
#     )
    
    output$text1 <- renderText({paste("Travel mean: ", input$travelMean, collapse = ',')})
    #output$text1 <- renderText({paste("Travel mean: ", input$travelMean)})
    output$text2 <- renderText({paste("Selected ", input$categories, " categories")})
    
    output$oneMap <- renderPlot(singleMap(input$categories, input$travelMean, input$classIntMethod))
    output$biMap  <- renderPlot(singleMap(input$categories, input$travelMean, input$classIntMethod))

}

shinyApp(ui = ui, server = server)
