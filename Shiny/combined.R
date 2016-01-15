# 
# pck <- c("shiny", "DT")
# require(pck) || install.packages(pck)
# 
# library(shiny)
# library(DT)

require("shiny") || install.packages("shiny")
require("DT") || install.packages("DT")


setwd("//file/UsersY$/yzh215/Home/Desktop/GitHub/InteractiveMap/Shiny")
#setwd("/home/cococatty/Desktop/InteractiveMap/Shiny")

source("helper.R")

minGrp <- 1
maxGrp <- 2



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
    
    # JUST TEMPORARY
#     observe({
#       if (length(input$travelMean) > maxGrp)
#       {
#         updateCheckboxGroupInput(session, 'travelMean', selected = tail(input$travelMean,maxGrp))
#       }
#     })
    
    output$selectedMeans <- renderUI({
      # The following part is groupCheckBox format for the TravelMean
      checkboxGroupInput(
        "travelMean"
        , "Travel Mean"
        , label = "Select the mean below:"
        , choices = meanChoices
        , selected = NULL
      )
    })
    
    output$biTable <- renderTable({
      #methods <- names(biTableDraft)
      biTableDraft <- biTableDraft[(geodata$MeanCode %in% input$travelMean), ]
      #biTableDraft <- biTableDraft[, input$travelMean, drop=FALSE]
      #t <- names(biTableDraft)
      #biTableDraft <- biTableDraft[!(biTableDraft$dimnames$AreaCode == 'MeanCode' & biTableDraft$dimnames$MeanCode == 'AreaCode'), ]
      #biTableDraft <- biTableDraft[!(biTableDraft$MeanCode == 'MeanCode' & biTableDraft$AreaCode == 'AreaCode'), ]
      })
        
    
    output$text1 <- renderText({paste("Travel mean: ", input$travelMean, collapse = ',')})
    output$text2 <- renderText({paste("Selected ", input$categories, " categories")})
    
    output$oneMap <- renderPlot(singleMap(input$categories, input$travelMean, input$classIntMethod))
    output$biMap  <- renderPlot(singleMap(input$categories, input$travelMean, input$classIntMethod))

    output$choseMeans <- renderUI({
      colnames <- names(biTableDraft$MeanCode)
    })
}



#Definte UI for the application
ui <- #fluidPage(
    #sidebarPanel(
      shinyUI(
        pageWithSidebar(
          headerPanel(""),
          
          sidebarPanel(
            sliderInput("categories", "Number of Categories", min = 1, max = 10, value = 5
            )  
            
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


shinyApp(ui = ui, server = server)
