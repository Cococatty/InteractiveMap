# LAST UPDATED AT 18.28 17/1

# Loading the requiring sources
require("shiny") || install.packages("shiny")
require("DT") || install.packages("DT")

# Set the working directory and read the required data
#setwd("//file/UsersY$/yzh215/Home/Desktop/GitHub/InteractiveMap/Shiny")
setwd("/home/cococatty/Desktop/InteractiveMap/Shiny")
source("helper.R")

# Initializing the variables
minGrp <- 1
maxGrp <- 2


#Definte UI for the application
ui <- fluidPage(
  sidebarPanel(
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
      , multiple = FALSE
    )
    
    , br()
    
    # The following part is groupCheckBox format for the travelMeans
    , checkboxGroupInput(
      "travelMeans"
      , label = "Select the mean below:"
      , choices = meanChoices
      , selected = NULL
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
    onetable <- subset(newtable, newtable$MeanCode == tail(input$travelMeans, 1), select = -c(MeanCode)
                       , colnames = c('Territory', 'Mean Name', 'Number of People', 'Overall weight'))
    onetable <- onetable[order(onetable$Percentage),]
  })
  
  output$onetable <- renderTable({
    updateoneTable()}
    , include.rownames = FALSE
    , options = list(paging = FALSE, searching = FALSE)
    , caption = paste("Travel mean: ", tail(input$travelMeans, 1))
    , caption.placement = getOption("xtable.caption.placement", "top")
    , caption.width = getOption("xtable.caption.width", NULL)
    
  )
  
  observe({
    if (length(input$travelMeans) > maxGrp)
    {
      updateCheckboxGroupInput(session, 'travelMeans', selected = tail(input$travelMeans,maxGrp))
    }
  })
  
  output$biTable <- renderTable({
    retrivingBiTable(input$travelMeans)
  })
  
  output$text1 <- renderText({paste("Travel mean: ", input$travelMeans, collapse = ',')})
  output$text2 <- renderText({paste("Selected ", input$categories, " categories")})
  
  output$oneMap <- renderPlot(singleMap(input$categories, input$travelMeans, input$classIntMethod))
  output$biMap  <- renderPlot(singleMap(input$categories, input$travelMeans, input$classIntMethod))
  
}

shinyApp(ui = ui, server = server)


#FROM UI
# The following part is SelectInput format for the travelMeans
#         selectInput("travelMeans", "Travel Mean"
#                       , label = "Select the mean below:"
#                       , choices = meanChoices
#                       , multiple = TRUE
#                       , width = "100%"
#         )



#WORKING two-way table (not desired thou)
#test <- xtabs(as.numeric(Ppl) ~ AreaCode + MeanCode, data=geodata)
#test <- test[!(test$dimnames$AreaCode == 'MeanCode' & test$dimnames$MeanCode == 'AreaCode'), ]
#test <- test[!(test$MeanCode == 'MeanCode' & test$AreaCode == 'AreaCode'), ]
#test <- as.table(test, dnn=c("MeanCode", "AreaCode"))

#test <- reactive({ length(input$travelMeans)})
#test1 <- reactive({ input$travelMeans})
#test <- reactive({summary(input$travelMeans) })
#test

#    updatebiTable <- reactive({

#       biTable <- subset(newtable, newtable$MeanCode == input$travelMeans, select = -c(MeanCode)
#                          , colnames = c('Territory', 'Mean Name', 'Number of People', 'Overall weight'))
#       biTable <- biTable[order(biTable$Percentage),]
#    })
#  
#, colnames = c('Territory', 'Mean Name', 'Number of People', 'Overall weight')