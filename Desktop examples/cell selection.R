# https://yihui.shinyapps.io/DT-selection/

# Loading the requiring sources
require("shiny") || install.packages("shiny")
require("DT") || install.packages("DT")



#Definte UI for the application
ui <- 
  navbarPage(
    
    title = 'DT Selection',
    
    tabPanel(
      'Row',
      fluidRow(
        column(
          6, h1('Client-side / Single selection'), hr(),
          DT::dataTableOutput('x11'),
          verbatimTextOutput('y11')
        ),
        column(
          6, h1('Client-side / Multiple selection'), hr(),
          DT::dataTableOutput('x12'),
          verbatimTextOutput('y12')
        )
      ),
      fluidRow(
        column(
          6, h1('Server-side / Single selection'), hr(),
          DT::dataTableOutput('x13'),
          verbatimTextOutput('y13')
        ),
        column(
          6, h1('Server-side / Multiple selection'), hr(),
          DT::dataTableOutput('x14'),
          verbatimTextOutput('y14')
        )
      ),
      fluidRow(
        column(
          6, h1('Client-side / Pre-selection'), hr(),
          DT::dataTableOutput('x15'),
          verbatimTextOutput('y15')
        ),
        column(
          6, h1('Server-side / Pre-selection'), hr(),
          DT::dataTableOutput('x16'),
          verbatimTextOutput('y16')
        )
      )
    ),
    
    tabPanel(
      'Column',
      fluidRow(
        column(
          6, h1('Client-side / Single selection'), hr(),
          DT::dataTableOutput('x21'),
          verbatimTextOutput('y21')
        ),
        column(
          6, h1('Client-side / Multiple selection'), hr(),
          DT::dataTableOutput('x22'),
          verbatimTextOutput('y22')
        )
      ),
      fluidRow(
        column(
          6, h1('Server-side / Single selection'), hr(),
          DT::dataTableOutput('x23'),
          verbatimTextOutput('y23')
        ),
        column(
          6, h1('Server-side / Multiple selection'), hr(),
          DT::dataTableOutput('x24'),
          verbatimTextOutput('y24')
        )
      ),
      fluidRow(
        column(
          6, h1('Client-side / Pre-selection'), hr(),
          DT::dataTableOutput('x25'),
          verbatimTextOutput('y25')
        ),
        column(
          6, h1('Server-side / Pre-selection'), hr(),
          DT::dataTableOutput('x26'),
          verbatimTextOutput('y26')
        )
      )
    ),
    
    tabPanel(
      'Cell',
      fluidRow(
        column(
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
        column(
          6, h1('Server-side / Multiple selection'), hr(),
          DT::dataTableOutput('x34'),
          verbatimTextOutput('y34')
        )
      ),
      fluidRow(
        column(
          6, h1('Client-side / Pre-selection'), hr(),
          DT::dataTableOutput('x35'),
          verbatimTextOutput('y35')
        ),
        column(
          6, h1('Server-side / Pre-selection'), hr(),
          DT::dataTableOutput('x36'),
          verbatimTextOutput('y36')
        )
      )
    ),
    
    tabPanel(
      'Row+Column',
      fluidRow(
        column(
          6, h1('Client-side / Single selection'), hr(),
          DT::dataTableOutput('x41'),
          verbatimTextOutput('y41')
        ),
        column(
          6, h1('Client-side / Multiple selection'), hr(),
          DT::dataTableOutput('x42'),
          verbatimTextOutput('y42')
        )
      ),
      fluidRow(
        column(
          6, h1('Server-side / Single selection'), hr(),
          DT::dataTableOutput('x43'),
          verbatimTextOutput('y43')
        ),
        column(
          6, h1('Server-side / Multiple selection'), hr(),
          DT::dataTableOutput('x44'),
          verbatimTextOutput('y44')
        )
      ),
      fluidRow(
        column(
          6, h1('Client-side / Pre-selection'), hr(),
          DT::dataTableOutput('x45'),
          verbatimTextOutput('y45')
        ),
        column(
          6, h1('Server-side / Pre-selection'), hr(),
          DT::dataTableOutput('x46'),
          verbatimTextOutput('y46')
        )
      ),
      fluidRow(
        column(
          6, h1('Client-side / Custom Table Container'), hr(),
          DT::dataTableOutput('x47'),
          verbatimTextOutput('y47')
        ),
        column(
          6, h1('Server-side / Custom Table Container'), hr(),
          DT::dataTableOutput('x48'),
          verbatimTextOutput('y48')
        )
      )
    ),
    
    tabPanel(
      'None',
      fluidRow(
        column(6, h1('Client-side'), hr(), DT::dataTableOutput('x51')),
        column(6, h1('Server-side'), hr(), DT::dataTableOutput('x52'))
      )
    )
    
  )




#Definte server logic required to draw the map
server <- function(input, output, session) {
  
  df = iris[, 1:3]
  options(DT.options = list(pageLength = 5))
  
  # row selection
  output$x11 = DT::renderDataTable(df, server = FALSE, selection = 'single')
  output$y11 = renderPrint(input$x11_rows_selected)
  
  output$x12 = DT::renderDataTable(df, server = FALSE)
  output$y12 = renderPrint(input$x12_rows_selected)
  
  output$x13 = DT::renderDataTable(df, selection = 'single')
  output$y13 = renderPrint(input$x13_rows_selected)
  
  output$x14 = DT::renderDataTable(df)
  output$y14 = renderPrint(input$x14_rows_selected)
  
  output$x15 = DT::renderDataTable(
    df, server = FALSE, selection = list(selected = c(1, 3, 4, 6, 9))
  )
  output$y15 = renderPrint(input$x15_rows_selected)
  
  output$x16 = DT::renderDataTable(
    df, selection = list(selected = c(1, 3, 4, 6, 9))
  )
  output$y16 = renderPrint(input$x16_rows_selected)
  
  # column selection
  output$x21 = DT::renderDataTable(
    df, server = FALSE, selection = list(mode = 'single', target = 'column')
  )
  output$y21 = renderPrint(input$x21_columns_selected)
  
  output$x22 = DT::renderDataTable(
    df, server = FALSE, selection = list(target = 'column')
  )
  output$y22 = renderPrint(input$x22_columns_selected)
  
  output$x23 = DT::renderDataTable(
    df, selection = list(mode = 'single', target = 'column')
  )
  output$y23 = renderPrint(input$x23_columns_selected)
  
  output$x24 = DT::renderDataTable(df, selection = list(target = 'column'))
  output$y24 = renderPrint(input$x24_columns_selected)
  
  output$x25 = DT::renderDataTable(
    df, server = FALSE, selection = list(target = 'column', selected = c(1, 3))
  )
  output$y25 = renderPrint(input$x25_columns_selected)
  
  output$x26 = DT::renderDataTable(
    df, selection = list(target = 'column', selected = c(1, 3))
  )
  output$y26 = renderPrint(input$x26_columns_selected)
  
  # cell selection
  output$x31 = DT::renderDataTable(
    df, server = FALSE, selection = list(mode = 'single', target = 'cell')
  )
  output$y31 = renderPrint(input$x31_cells_selected)
  
  output$x32 = DT::renderDataTable(
    df, server = FALSE, selection = list(target = 'cell')
  )
  output$y32 = renderPrint(input$x32_cells_selected)
  
  output$x33 = DT::renderDataTable(
    df, selection = list(mode = 'single', target = 'cell')
  )
  output$y33 = renderPrint(input$x33_cells_selected)
  
  output$x34 = DT::renderDataTable(df, selection = list(target = 'cell'))
  output$y34 = renderPrint(input$x34_cells_selected)
  
  output$x35 = DT::renderDataTable(
    df,
    server = FALSE,
    selection = list(target = 'cell', selected = cbind(
      c(1, 3, 4, 9), c(3, 2, 1, 2)
    ))
  )
  output$y35 = renderPrint(input$x35_cells_selected)
  
  output$x36 = DT::renderDataTable(
    df,
    selection = list(target = 'cell', selected = cbind(
      c(1, 3, 4, 9), c(3, 2, 1, 2)
    ))
  )
  output$y36 = renderPrint(input$x36_cells_selected)
  
  # row+column selection
  print_rows_cols = function(id) {
    cat('Rows selected:\n')
    print(input[[paste0(id, '_rows_selected')]])
    cat('Columns selected:\n')
    print(input[[paste0(id, '_columns_selected')]])
  }
  output$x41 = DT::renderDataTable(
    df, server = FALSE, selection = list(mode = 'single', target = 'row+column')
  )
  output$y41 = renderPrint(print_rows_cols('x41'))
  
  output$x42 = DT::renderDataTable(
    df, server = FALSE, selection = list(target = 'row+column')
  )
  output$y42 = renderPrint(print_rows_cols('x42'))
  
  output$x43 = DT::renderDataTable(
    df, selection = list(mode = 'single', target = 'row+column')
  )
  output$y43 = renderPrint(print_rows_cols('x43'))
  
  output$x44 = DT::renderDataTable(df, selection = list(target = 'row+column'))
  output$y44 = renderPrint(print_rows_cols('x44'))
  
  output$x45 = DT::renderDataTable(
    df,
    server = FALSE,
    selection = list(target = 'row+column', selected = list(
      rows = c(1, 3, 4, 9), cols = c(3, 2)
    ))
  )
  output$y45 = renderPrint(print_rows_cols('x45'))
  
  output$x46 = DT::renderDataTable(
    df,
    selection = list(target = 'row+column', selected = list(
      rows = c(1, 3, 4, 9), cols = c(3, 2)
    ))
  )
  output$y46 = renderPrint(print_rows_cols('x46'))
  
  sketch = htmltools::withTags(table(
    class = 'display',
    thead(
      tr(
        th(rowspan = 2, ''),
        th(rowspan = 2, 'Species'),
        th(colspan = 2, 'Sepal'),
        th(colspan = 2, 'Petal')
      ),
      tr(
        lapply(rep(c('Length', 'Width'), 2), th)
      )
    ),
    tfoot(
      tr(
        th(rowspan = 2, ''),
        th(rowspan = 2, 'Species'),
        lapply(rep(c('Length', 'Width'), 2), th)
      ),
      tr(
        th(colspan = 2, 'Sepal'),
        th(colspan = 2, 'Petal')
      )
    )
  ))
  output$x47 = DT::renderDataTable(
    iris, container = sketch, server = FALSE,
    selection = list(target = 'row+column')
  )
  output$y47 = renderPrint(print_rows_cols('x47'))
  
  output$x48 = DT::renderDataTable(
    iris, container = sketch,
    selection = list(target = 'row+column')
  )
  output$y48 = renderPrint(print_rows_cols('x48'))
  
  # disable selection
  output$x51 = DT::renderDataTable(df, server = FALSE, selection = 'none')
  output$x52 = DT::renderDataTable(df, selection = 'none')
  
}

shinyApp(ui = ui, server = server)
