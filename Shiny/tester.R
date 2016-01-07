

str(as.character(meandata$MeanName[1]))
str("Public Bus")





sou <- c("Public Bus" = "06",
         "Drove a company car, truck or van" = "04")

str(sou)
attributes(sou)

data(jenks71)
min(jenks71$jenks71)
max(jenks71$jenks71)
classIntervals(jenks71$jenks71, n=5, style="fixed")


nclass <- classIntervals(shape@data$Percentage[shape@data$Mean=="03"], n= 5, style = "fixed",
                         fixedBreaks=c(15.57, 25, 50, 75, 100, 155.30), dataPrecision = 2 )

nclass <- classIntervals(shape@data$Percentage[shape@data$Mean=="03"], n= 5, style = "equal",
                          dataPrecision = 2 )

nclass <- classIntervals(shape@data$Percentage[shape@data$Mean=="03"], n= 5, style = "quantile"
                         )


str(c(15.57, 25, 50, 75, 100, 155.30))
str(test)


test <- c()
single <- 100/5
test <- c(test, single*2)

numQUan<-7
breakList <- c()
unit <- round(max(shape@data$Percentage)/numQUan, digits = 2)
for (i in 1:numQUan) {
  breakList <- c(breakList, unit*i)
}
breakList <- c(breakList, unit*numQUan)

min(shape@data$Percentage)
max(shape@data$Percentage)




#SOURCE TESTING
numQUan = 5
travelMean = "03"
classIntMethod = "quantile"
#nz_map(numQUan, travelMean, classIntMethod)




names(shape@data)

geodata
?renderDataTable

test$by <- c(2,3,5)
test$row <- c(4,8,9)




head(geodata)
head(shape@data)

shape@data[shape@data$Mean == '03',]
plot(shape@data[shape@data$Mean == '03'])



test <- table(geodata$Mean, geodata$Ppl, geodata$Percentage)




totalMeanList <- aggregate(as.numeric(levels(shape@data$Ppl)[shape@data$Ppl]), by=list(shape@data$Mean), FUN = sum)
#setNames(     , c('Mean', 'Total'))

#Calculate the percentages within Areas
for (i in 1:length(geodata$Percentage))
{
  rowPpl <- as.numeric(levels(geodata$Ppl[i])[geodata$Ppl[i]])
  rowTotal <- ((totalList[totalList$Area == geodata$Area[i],]) $Total)
  geodata$Percentage[i] <- (rowPpl / rowTotal)
  
}



