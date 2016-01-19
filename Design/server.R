library(shiny)
library(dplyr)
library(ggvis)
shinyServer(function(input, output,session){   
  #read the data and give import prefrences  
  data <- reactive({
    file1 <- input$file
    if(is.null(file1)){return()}
    read.table(file=file1$datapath, sep= input$sep, header= input$header, stringsAsFactors= input$stringsAsFactors)
  })
  
  # display summary of table output
  output$filledf <-renderTable({
    if(is.null(data())){return ()}
    input$file
  })
  
  output$sum <- renderTable({
    if(is.null(data())){return ()}
    summary(data())
    
  })
  output$table <- renderTable({
    if(is.null(data())){return ()}
    data()
    
  })
  
  #generate tabsets when the file is loaded. 
  output$tb <- renderUI({
    if(is.null(data()))
      h2("App powered by", tags$img(src='Blue.png', height= 100, width=250))
    else
      tabsetPanel(tabPanel("About file", tableOutput("filledf")), tabPanel("Data", tableOutput("table")), tabPanel("Summary", tableOutput("sum")))
  })
  ########## Data import end #########
  
  ########## Bivariate regression begin ###########
  #load the data when the user inputs a file
  theData <- reactive({
    infile <- input$datfile        
    if(is.null(infile))
      return(NULL)        
    d <- read.csv(infile$datapath, header = T)
    d        
  })
  
  # dynamic variable names
  observe({
    data<-theData()
    updateSelectInput(session, 'x', choices = names(data))
    updateSelectInput(session, 'y', choices = names(data))
    
  }) # end observe
  
  #gets the y variable name, will be used to change the plot legends
  yVarName<-reactive({
    input$y
  })
  
  #gets the x variable name, will be used to change the plot legends
  xVarName<-reactive({
    input$x
  })
  
  #make the filteredData frame
  
  filteredData<-reactive({
    data<-isolate(theData())
    #if there is no input, make a dummy dataframe
    if(input$x=="x" && input$y=="y"){
      if(is.null(data)){
        data<-data.frame(x=0,y=0)
      }
    }else{
      data<-data[,c(input$x,input$y)]
      names(data)<-c("x","y")
    }
    data
  })
  
  #plot the ggvis plot in a reactive block so that it changes with filteredData
  vis<-reactive({
    plotData<-filteredData()
    plotData %>%
      ggvis(~x, ~y) %>%
      layer_points() %>%
      add_axis("y", title = yVarName()) %>%
      add_axis("x", title = xVarName()) %>%
      add_tooltip(function(df) format(sqrt(df$x),digits=2))
  })
  vis%>%bind_shiny("plot", "plot_ui")
  
  ##### add contingency table ########
  # display contingcy table output
  output$foo <- renderTable({
    if(is.null(data())){return ()}
    as.data.frame.matrix(table((data())))
  })
  
})