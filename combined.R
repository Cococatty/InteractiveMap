# LAST UPDATED AT 10/2, 12pm
# 
# NEXT TO DO: CHANGE THE "MIX" TO A MEANINGFUL NAME


if (!require("devtools"))
  install.packages("devtools")
devtools::install_github("rstudio/shiny")

# Loading the requiring sources
require("devtools") || install.packages("devtools")
require("shiny") || install.packages("shiny")
require("DT") || install.packages("DT")

# require("scatterD3") || install.packages("scatterD3")
devtools::install_github("juba/scatterD3")
library(scatterD3)
library(shiny)



# Set the working directory and read the required data
# setwd("//file/UsersY$/yzh215/Home/Desktop/InteractiveMap")
# setwd("/home/cococatty/Desktop/InteractiveMap")
# setwd("C:/Users/User/Desktop/InteractiveMap")
 setwd("C:/Users/Josh/Desktop/InteractiveMap")


source("helper.R")

# Initializing the variables
minGrp <- 1
maxGrp <- 2


#Definte UI for the application
ui <- shinyUI(fluidPage(
  titlePanel(title = "Interactive Map of New Zealand", windowTitle = "Interactive Map of New Zealand"),
  
  sidebarPanel(
    sliderInput("categories", "Number of Categories", min = 1, max = 10, value = 5
    )
    , br()
    , selectInput(
      "classIntMethod"#, "Division Method"
      , label = "Select the intervals"
      , choices = list("Equal" = "equal"
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
      , tabPanel("Single-Mean Plot", #textOutput("oneMapText"),  
                 plotOutput("oneMap", width = "800px", height = "800px"))
      , tabPanel("Scatterplot", scatterD3Output("biScatter", width = "100%", height = "600px"))
      , tabPanel("Two-Mean Plot", plotOutput("biMap", width = "800px", height = "800px")
                 #,br(), imageOutput("boxLegend") #, width = "auto", height = "auto"
                 , verbatimTextOutput("biMapText"))
      , tabPanel("ggplot Legend", imageOutput("boxLegend"))
      , tabPanel("Ideal Legend", imageOutput("biMapLegend"))
    )
    
    , position="center"
    , height= "auto"
  )
)
)



#Definte server logic required to draw the map
server <- function(input, output, session) {
  
  updateoneTable <- reactive({
    onetable <- subset(newtable, newtable$MeanCode == tail(input$travelMeans, 1), select = -c(MeanCode)
                       , colnames = c('Territory', 'Mean Name', 'Number of People', 'Overall weight'))
    onetable <- onetable[order(onetable$Percentage),]
    rownames(onetable) <- seq(length=nrow(onetable))
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
#  output$oneMapText <- renderText({ paste("Selected travel mean: ", meandata$MeanName[meandata$MeanCode == input$travelMeans[2]] )})
  output$biMap  <- renderPlot(biMap(input$travelMeans))
  
  biList <- reactive({
    prepareTwoMeans(input$travelMeans)
  })
  
  output$biScatter <- renderScatterD3({
    tooltips <- paste("<strong>Territory Authority: ", biList()$AreaName,"</strong><br /> Percentage of x: "
                      , biList()$Percentage.x, "<br />"
                      , "Percentage of y: ", biList()$Percentage.y)

    plot <- scatterD3(x = biList()$Percentage.x, y = biList()$Percentage.y
              , xlab = meandata$MeanName[meandata$MeanCode == unique(biList()$MeanCode.x)]
              , ylab = meandata$MeanName[meandata$MeanCode == unique(biList()$MeanCode.y)]
              , tooltip_text = tooltips
    )
    return (plot)
  })
  
  #img <- reactive({legendBox(input$travelMeans)})  
  #reactive({legendBox(input$travelMeans)})  
  
  output$boxLegend <- renderImage(
    #renderPlot(
    {
      library(png)
      dat <- expand.grid(blue=seq(255, 0, by=-10), red=seq(255, 0, by=-10))
      dat <- within(dat, mix <- rgb(green=0, red=red, blue=blue, maxColorValue=255))

      outfile <- tempfile(fileext='.png')
      png(outfile, width = 600, height = 600)
      print(
        ggplot(dat, aes(x=red, y=blue)) +
          geom_tile(aes(fill=mix)) +
          scale_fill_identity() +
          xlab(as.character(meandata$MeanName[meandata$MeanCode == input$travelMeans[1]])) +
          ylab(as.character(meandata$MeanName[meandata$MeanCode == input$travelMeans[2]]))
      )
      dev.off()

      list(src = outfile
           , alt = 'alt')
    }
    , deleteFile = TRUE)
  

  output$biMapLegend <- renderImage(
                {return(list(src="./test.png"
                            , contentType = "image/png"
                            , height = 600
                            , width = 900
                            , alt = "Image"))
                }, deleteFile = FALSE)
}

shinyApp(ui = ui, server = server)