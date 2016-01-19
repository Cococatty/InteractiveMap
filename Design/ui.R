install.packages("shinydashboard")
install.packages("shiny")
install.packages("ggvis")

library(shiny)
library(shinydashboard)
library(ggvis)

sidebar <- dashboardSidebar(
  br(),
  sidebarMenu(id="tabs",
              menuItem("Import Data", tabName = "import", icon=icon("list-alt")),
              menuItem("Bivariate Regression", tabName="bivariate_regression", icon=icon("line-chart")),
              menuItem("Contingency", tabName = "contingency", icon = icon("table"))
  ))

body <- dashboardBody(
  tabItems(      
    tabItem(tabName= "import",
            sidebarLayout(
              sidebarPanel(
                fileInput("file","Upload the file"), 
                tags$hr(),
                h5(helpText("Select the table parameters below")),
                checkboxInput(inputId = 'header', label= 'Header', value= TRUE),
                checkboxInput(inputId = "stringsAsFactors", "stringsAsFactors", FALSE),
                br(),
                radioButtons(inputId = 'sep', label = 'Seperator', choices = c(Comma=',', Semicolon=';', Tab='\t', Space= ' '), selected= ',')
              ),
              mainPanel(
                uiOutput("tb")
              )
            )),
    
    tabItem(tabName= "bivariate_regression",
            sidebarLayout(
              #div(),
              sidebarPanel(
                fileInput('datfile', ''),
                selectInput('x', 'x:' ,'x'),
                selectInput('y', 'y:', 'y'),
                uiOutput("plot_ui")
              ),
              mainPanel(
                titlePanel("Plot Output"),
                ggvisOutput("plot")
              )
            )),
    tabItem(tabName="contingency", h2("Contigency Tab content"))
  ))


dashboardPage(
  dashboardHeader(title = "COBE Dashboard"),
  sidebar,
  body)