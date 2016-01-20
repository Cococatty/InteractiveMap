# This script is used for testing new method

# The following is for "selecting the cell and information shall be displayed on the RHS

travelMeans <- c('02', '04')
test <- prepareTwoMeans(travelMeans)
head(test[1:6,])
#attributes(test) 


library(scatterD3)
tooltips <- paste("Territory Authority: ", test$AreaName,"</strong><br /> Percentage of x: "
                  , test$Percentage.x, "<br />"
                  , "Percentage of y: ", test$Percentage.y)
scatterD3(x = test$Percentage.x, y = test$Percentage.y
          , xlab = meandata$MeanName[meandata$MeanCode == unique(test$MeanCode.x)]
          , ylab = meandata$MeanName[meandata$MeanCode == unique(test$MeanCode.y)]
          , tooltip_text = tooltips
          )


