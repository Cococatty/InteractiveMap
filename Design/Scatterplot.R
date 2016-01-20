# Scatterplot methods

travelMeans <- c('02', '04')
test <- prepareTwoMeans(travelMeans)
head(test[1:6,])
#attributes(test) 







##########################################
install.packages("plotly")

library(plotly)
plot_ly(test
        , x = test$Percentage.x, y = test$Percentage.y
        , text = paste("City:", test$AreaName)
        , mode="markers"
        #, color = test$Percentage.x
        #, size = test$Percentage.x
        , colors = test$mix
)


##########################################
library(scatterD3)
tooltips <- paste("Territory Authority: ", test$AreaName,"</strong><br /> Percentage of x: "
                  , test$Percentage.x, "<br />"
                  , "Percentage of y: ", test$Percentage.y)
scatterD3(x = test$Percentage.x, y = test$Percentage.y
          , xlab = meandata$MeanName[meandata$MeanCode == unique(test$MeanCode.x)]
          , ylab = meandata$MeanName[meandata$MeanCode == unique(test$MeanCode.y)]
          , tooltip_text = tooltips
)

