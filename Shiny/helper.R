
#Clearing up the data
rm(list=ls())

#Loading the requiring sources
#
# pck <- c("maptools", "classInt", "stringr", "colorRamps")
# require(pck) || install.packages(pck)

# library(maptools)
# library(classInt)
# library(stringr)
# library(colorRamps)

require("classInt") || install.packages("classInt")
require("colorRamps") || install.packages("colorRamps")
require("maptools") || install.packages("maptools")
require("stringr") || install.packages("stringr")




#Initializing the variables

travelMean <- c()

#Set the working directory and read the required data
#setwd("//file/UsersY$/yzh215/Home/Desktop/GitHub/InteractiveMap")
setwd("/home/cococatty/Desktop/InteractiveMap")

geodata <- read.csv('geodata.csv'
                      , col.names= c('AreaCode','AreaName','AreaFull','MeanCode','MeanName','MeanFull','Ppl')
                      , header= FALSE
                      , sep = ','
                      , numerals = c('no.loss'))
# Remove 
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


#head(geodata)

#Calculate the percentages within Areas
for (i in 1:length(geodata$Percentage))
{
  rowPpl <- as.numeric(levels(geodata$Ppl[i])[geodata$Ppl[i]])
  rowTotal <- ((totalList[totalList$AreaCode == geodata$AreaCode[i],]) $Total)
  geodata$Percentage[i] <- (rowPpl / rowTotal)
}


# Get ready for the two-way table
maxList <- setNames(aggregate(geodata$Percentage, by=list(geodata$MeanCode), max), c('MeanCode', 'Max')) 


#Reading and merging the shapefiles
shape <- readShapeSpatial("./Shapefiles/TA2013_GV_Clipped.shp")
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

singleMap <- function(numQUan, travelMean, classIntMethod)
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
  
#  attributes(colPal)
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
}

biMap <- function(numQUan, travelMean, classIntMethod)
{
  redpal <-
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
}

#singleMap(5, travelMean = as.character(meandata$MeanCode[1]), "pretty")