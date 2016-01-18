# LAST UPDATED AT 18/1 17.38
# 
# NEXT TO DO: LINE 129

# Loading the requiring sources
require("shiny") || install.packages("shiny")
require("DT") || install.packages("DT")


# Set the working directory and read the required data
# setwd("//file/UsersY$/yzh215/Home/Desktop/GitHub/InteractiveMap/Shiny")
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
    
    , tabsetPanel(#type = "tabs",
        tabPanel("Single-Mean Table", DT::dataTableOutput("onetable")
                 , textOutput("singleTblText")
        )
      , tabPanel("Single-Mean Plot", plotOutput("oneMap"))
      , tabPanel(
                "Two-Mean Table", DT::dataTableOutput("biTable", height = "100%"),
                verbatimTextOutput("biTableText")
      )
       
      , tabPanel("Two-Mean Plot", plotOutput("biMap"))
    )
    
    , position="center"
    #, width= "auto" # THIS MAKES THE "UGLY LOOK" (DETAILS AT THE BOTTOM)
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
  
  ######## TBC -- NEED TO FIX THE ROW NUMBER!! ######################################################################
  output$onetable <- DT::renderDataTable({
    DT::datatable(
      updateoneTable(), selection = "single" #list(target="cell")
    )}
    , include.rownames = FALSE
    , options = list(paging = FALSE, searching = TRUE)
    #, caption = paste("Travel mean: ", tail(input$travelMeans, 1)) ######## NOT WORKING
    , caption.placement = getOption("xtable.caption.placement", "top")
    , caption.width = getOption("xtable.caption.width", NULL)
    
  )
  
  observe({
    if (length(input$travelMeans) > maxGrp)
    {
      updateCheckboxGroupInput(session, 'travelMeans', selected = tail(input$travelMeans,maxGrp))
    }
  })
  
  biTable <- reactive({
    return(retrivingBiTable(input$travelMeans))
  })
    
  ######## TBC -- NEED TO SHOW THE ROW NUMBER!! ######################################################################
  output$biTable <- DT::renderDataTable({
    DT::datatable(
      biTable()
       , extensions = "Scroller"
      , options = list(
          deferRender = TRUE
          , dom = "frtiS"#frtiS
          , scrollY = 200
          , scrollCollapse = TRUE
          , autoWidth = TRUE
         )
    
      # , rownames = TRUE ######## NOT WORKING
   )
  })
  
  ######## TBC -- NOT WORKING!! ######################################################################
  output$biTableText <- renderPrint(input$biTable_rows_selected)
  #geodata[geodata$AreaCode] "x47"
  
  output$text1 <- renderText({paste("Travel mean: ", input$travelMeans, collapse = ',')})
  output$text2 <- renderText({paste("Selected ", input$categories, " categories")})
  
  output$oneMap <- renderPlot(singleMap(input$categories, input$travelMeans, input$classIntMethod))
  output$biMap  <- renderPlot(singleMap(input$categories, input$travelMeans, input$classIntMethod))
  
}

shinyApp(ui = ui, server = server)
