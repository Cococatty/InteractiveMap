library(shiny)


#Definte UI for the application
shinyUI((fluidPage(
  
    sidebarPanel(
      #fluidRow(
        sliderInput("categories", "Number of Categories", min = 1, max = 10, value = 5
        ),
            
        selectInput("classIntMethod"#, "Division Method"
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
        ),
        
        br(),
        selectInput("travelMean", "Travel Mean"
                      , label = "Select the mean below:"
                      , choices = meanChoices
                      , multiple = TRUE
                      , width = "100%"
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

        ,tabsetPanel(#type = "tabs",
            tabPanel("Single-Mean Table", tableOutput("table")  )
          , tabPanel("Single-Mean Plot", plotOutput("map"))
          , tabPanel("Two-Mean Table", tableOutput("biTable")  )
          , tabPanel("Two-Mean Plot", plotOutput("biMap"))
        )
        
        , position="center"
        , width= "auto"
        , height= "auto"
      )
))
)
    

#selectInput("keyVar", "Key Variable"
#            , choices = c("var1", "var2")
#),