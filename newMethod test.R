# This script is used for testing new method

# The following is for "selecting the cell and information shall be displayed on the RHS

travelMeans <- c('02', '04')
test <- biTableMatrix(travelMeans)
head(test[1:6, 1:6])
attributes(test) 

t <- iris[1:3,1:3]
attributes(t)

t[3,3]

tt <- data.frame("", row.names = seq(67), col.names=seq(67))



output$x31 = DT::renderDataTable(
  df, server = FALSE, selection = list(mode = 'single', target = 'cell')
)
output$y31 = renderPrint(input$x31_cells_selected)


output$x33 = DT::renderDataTable(
  df, selection = list(mode = 'single', target = 'cell')
)
output$y33 = renderPrint(input$x33_cells_selected)



6, h1('Client-side / Single selection'), hr(),
DT::dataTableOutput('x31'),
verbatimTextOutput('y31')
),
column(
  6, h1('Client-side / Multiple selection'), hr(),
  DT::dataTableOutput('x32'),
  verbatimTextOutput('y32')
)
),
fluidRow(
  column(
    6, h1('Server-side / Single selection'), hr(),
    DT::dataTableOutput('x33'),
    verbatimTextOutput('y33')
  ),