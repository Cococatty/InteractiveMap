
#Clearing up the data
rm(list=ls())


#Loading the requiring sources
library(maptools)
library(classInt)
library(stringr)
library(colorRamps)



#Initializing the variables

travelMean <- c()

#Read the data
setwd("//file/UsersY$/yzh215/Home/Desktop/Map")

geodata <- read.csv('./NewDoc/geodata.csv'
                      , col.names= c('AreaCode','AreaDesc','AreaFull','MeanCode','MeanName','MeanFull','Ppl')
                      , header= FALSE
                      , sep = ','
                      , numerals = c('no.loss'))


geodata <- geodata[!(geodata$MeanCode == 'MeanCode' & geodata$AreaCode == 'AreaCode'), ]
#head(geodata)

meandata <- unique(geodata[c('MeanCode', 'MeanName', 'MeanFull') ] )
meandata <- meandata[order(meandata$MeanName),]


meanChoices <- as.character(meandata$MeanCode)
names(meanChoices) <- meandata$MeanName

#Create a new column "Percentage" in geodata
geodata$Percentage <- c(0)

#Create a list with the Areas and the total numbers of ppl
totalList <- setNames(aggregate(as.numeric(levels(geodata$Ppl)[geodata$Ppl]), by=list(Area=geodata$AreaCode), FUN = sum)
                      , c('AreaCode', 'Total')
)

#Calculate the percentages within Areas
for (i in 1:length(geodata$Percentage))
{
  rowPpl <- as.numeric(levels(geodata$Ppl[i])[geodata$Ppl[i]])
  rowTotal <- ((totalList[totalList$AreaCode == geodata$AreaCode[i],]) $Total)
  geodata$Percentage[i] <- (rowPpl / rowTotal)
  
}

#head(geodata)
#head(shape@data)

#Reading and merging the shapefiles
shape <- readShapeSpatial("./Shapefiles/2 ESRI/TA2013_GV_Clipped.shp")
shape <- shape[!(shape@data$TA2013_NAM == 'Chatham Islands Territory' | shape@data$TA2013_NAM == 'Area Outside Territorial Authority'),]
shape@data <- merge(shape@data,geodata,by.x="TA2013",by.y="AreaCode", all.x= TRUE )#, replace = TRUE 
shape@data$Ppl <- as.numeric(levels(shape@data$Ppl)[shape@data$Ppl])
shape@data$Percentage[is.na(shape@data$Percentage)] <- 0
shape@data$Percentage <- round(shape@data$Percentage*100,2)

newtable <- subset(shape@data)
newtable <- subset(newtable, select = -c(TA2013, TA2013_NAM, MeanFull, AreaFull))


#head(newtable)
#remove(newtable)


#Assigning data
pal <- colorRampPalette(c("yellow","red"), space= "rgb")

nz_map <- function(numQUan, travelMean = as.character(meandata$MeanCode[1]), classIntMethod)
{
  
  if (classIntMethod == "fixed") {
    breakList <- c(min(shape@data$Percentage[shape@data$Mean==travelMean]))
    unit <- round(max(shape@data$Percentage[shape@data$Mean==travelMean])/numQUan, digits = 2)
    for (i in 1:numQUan) {
      breakList <- c(breakList, unit*i)
    }
    
    nclass <- classIntervals(shape@data$Percentage[shape@data$MeanCode==travelMean], n= numQUan, style = classIntMethod
                             , fixedBreaks = breakList, dataPrecision = 2)
  } else {
    nclass <- classIntervals(shape@data$Percentage[shape@data$MeanCode==travelMean], n= numQUan, style = classIntMethod
                             , dataPrecision = 2)  
  }

  colPal <- findColours(nclass, pal(length(nclass$brks-1)))
  #head(shape@data)
  
  #Draw the coloured map and relevant details
  plot(shape, legend=FALSE, border = "Black", col= colPal)
  #title(paste ("Map of New Zealand \n Travel mean: ", meandata$MeanName[meandata$MeanCode == travelMean]))
  
  
  #Setting up the legend text in the proper percentages format
  legendT <- c()
  legendText <- c()
  newText <- c()
  
  for (i in 1:length(nclass$brks))
  {
    newText <- str_trim(paste(round(nclass$brks[i], digits = 2), '%'))
    legendT <- c(legendT, newText)
  }
  
  for (i in 1:(length(nclass$brks)-1))
  {
    newText <- c()
    if (i == 1 && classIntMethod != "fixed") {
      newText <- paste('0 % -', legendT[i])
    }
    else {
      newText <- paste(legendT[i], '-', legendT[i+1])
    }
    legendText <- c(legendText, newText)
  }

  legend('bottomright', legend= legendText, title = 'Legend', fill= pal(length(nclass$brks)-1), bty = 'o')#, pch= 1
#  leafdat<-paste("/", "test", ".geojson", sep="") 
}



#nz_map(5, travelMean = as.character(meandata$MeanCode[1]), "pretty")