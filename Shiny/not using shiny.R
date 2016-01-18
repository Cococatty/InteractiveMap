

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