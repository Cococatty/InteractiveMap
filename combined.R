# LAST UPDATED AT 20/1, 12pm
# 
# NEXT TO DO: LINE 

# Loading the requiring sources
# update.packages(ask = FALSE)
# update.packages(list("shiny","DT"))
require("shiny") || install.packages("shiny")
require("DT") || install.packages("DT")
# require("scatterD3") || install.packages("scatterD3")
require("googleVis") || install.packages("googleVis")

#devtools::install_github("rstudio/shiny")

#library(scatterD3)
library(googleVis)

# Set the working directory and read the required data
 setwd("//file/UsersY$/yzh215/Home/Desktop/InteractiveMap")
# setwd("/home/cococatty/Desktop/InteractiveMap")
# setwd("C:/Users/User/Desktop/InteractiveMap/Shiny")

 

source("helper.R")

# Initializing the variables
minGrp <- 1
maxGrp <- 2


#Definte UI for the application
ui <- fluidPage(
  titlePanel(title = "Interactive Map of New Zealand", windowTitle = "Interactive Map of New Zealand"),
  
  sidebarPanel(
    sliderInput("categories", "Number of Categories", min = 1, max = 10, value = 5
    )
    , br()
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
  ),
  
  #Show the map
  mainPanel(
    tabsetPanel(#type = "tabs",
      tabPanel("Single-Mean Table", DT::dataTableOutput("onetable"), hr())
      , tabPanel("Single-Mean Plot", plotOutput("oneMap", width = "1200px", height = "800px"))
      #, tabPanel("Two-way Scatterplot", scatterD3Output("biScatter", width = "100%", height = "600px"))
      , tabPanel("Two-way Scatterplot", htmlOutput("biScatter"))
      , tabPanel("Two-Mean Plot", plotOutput("biMap", width = "1200px", height = "800px")
                 , verbatimTextOutput("biMapText"))
    )
    
    , position="center"
    , height= "auto"
  )
)




#Definte server logic required to draw the map
server <- function(input, output, session) {
  
  updateoneTable <- reactive({
    onetable <- subset(newtable, newtable$MeanCode == tail(input$travelMeans, 1), select = -c(MeanCode)
                       , colnames = c('Territory', 'Mean Name', 'Number of People', 'Overall weight'))
    onetable <- onetable[order(onetable$Percentage),]
    row.names(onetable) <- seq(length = nrow(onetable))
    return (onetable)
  })
  
  output$onetable <- DT::renderDataTable({
    DT::datatable(
      updateoneTable(), selection = "none"
      , extensions = list("Scroller")
      , options = list(
        scrollY = 700
        , pageLength = 30
        , lengthMenu = list(c(30, -1), c("30", "All"))
      )
    )}
    , server = TRUE
  )
  
  
  observe({
    if (length(input$travelMeans) > maxGrp)
    {
      updateCheckboxGroupInput(session, 'travelMeans', selected = tail(input$travelMeans,maxGrp))
    }
  })
  
  
  output$biMapText <- renderText({
    paste("Red: ", meandata$MeanName[meandata$MeanCode == input$travelMeans[1]]
          , "Purple: A combination of both travel means"
          , "Blue: ", meandata$MeanName[meandata$MeanCode == input$travelMeans[2]], sep = "\n")
  })
  
  output$oneMap <- renderPlot(singleMap(input$categories, input$travelMeans, input$classIntMethod))
  output$biMap  <- renderPlot(biMap(input$travelMeans))
  
  biList <- reactive({
    prepareTwoMeans(input$travelMeans)
  })
  
#   output$biScatter <- renderScatterD3({
#     tooltips <- paste("Territory Authority: ", biList$AreaName,"</strong><br /> Percentage of x: "
#                       , biList$Percentage.x, "<br />"
#                       , "Percentage of y: ", biList$Percentage.y)
#     
#     #</strong><br />
#     plot <- scatterD3(x = biList$Percentage.x, y = biList$Percentage.y
#               , xlab = meandata$MeanName[meandata$MeanCode == unique(biList$MeanCode.x)]
#               , ylab = meandata$MeanName[meandata$MeanCode == unique(biList$MeanCode.y)]
#               , tooltip_text = tooltips
#     )
#     return (plot)
#   })
  
  output$biScatter <- renderGvis({
    gvisScatterChart(biList(), options=list(width=400, height=450))
  })
}

shinyApp(ui = ui, server = server)