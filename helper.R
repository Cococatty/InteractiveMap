# LAST UPDATED AT 21/1, 13.00
# 
# NEXT TO DO: LINE 


# Clearing up the data
# rm(list=ls())

# Loading the requiring sources
require("classInt") || install.packages("classInt")
require("colorRamps") || install.packages("colorRamps")
require("maptools") || install.packages("maptools")
require("stringr") || install.packages("stringr")


# Initializing the variables
travelMean <- c()

# Set the working directory and read the required data
# setwd("//file/UsersY$/yzh215/Home/Desktop/InteractiveMap")
# setwd("/home/cococatty/Desktop/InteractiveMap")
 setwd("C:/Users/User/Desktop/InteractiveMap")


# Reading required data
# geodata contains various travel means and the number of people travel in the means
geodata <- read.csv('geodata.csv'
                    , col.names= c('AreaCode','AreaName','AreaFull','MeanCode','MeanName','MeanFull','Ppl')
                    , header= FALSE
                    , sep = ','
                    , numerals = c('no.loss'))

# Remove the header from the data - cannot set "header = TRUE" in previous section because it
# would trim the 0s away from Mean codes and Area codes.
geodata <- geodata[!(geodata$MeanCode == 'MeanCode' & geodata$AreaCode == 'AreaCode'), ]

# Generating the details of travel means
meandata <- unique(geodata[c('MeanCode', 'MeanName', 'MeanFull') ] )
meandata <- meandata[order(meandata$MeanName),]

# Generating the list of choices for the Travel means input in UI
meanChoices <- as.character(meandata$MeanCode)
names(meanChoices) <- meandata$MeanName

# Create a new column "Percentage" in geodata
geodata$Percentage <- c(0)

# Create a list with the Areas and the total numbers of ppl
totalList <- setNames(aggregate(as.numeric(levels(geodata$Ppl)[geodata$Ppl]), by=list(Area=geodata$AreaCode), FUN = sum)
                      , c('AreaCode', 'Total')
)

#Calculate the percentages within Areas
for (i in 1:nrow(geodata))
{
  rowPpl <- as.numeric(levels(geodata$Ppl[i])[geodata$Ppl[i]])
  rowTotal <- ((totalList[totalList$AreaCode == geodata$AreaCode[i],]) $Total)
  geodata$Percentage[i] <- (rowPpl / rowTotal)
}

# Reading and merging the shapefiles
shape <- readShapeSpatial("./Shapefiles/TA2013_GV_Clipped.shp")
shape <- shape[!(shape@data$TA2013_NAM == 'Chatham Islands Territory' | shape@data$TA2013_NAM == 'Area Outside Territorial Authority'),]
shape@data <- merge(shape@data,geodata,by.x="TA2013",by.y="AreaCode", all.x= TRUE )#, replace = TRUE 
shape@data$Ppl <- as.numeric(levels(shape@data$Ppl)[shape@data$Ppl])
shape@data$Percentage[is.na(shape@data$Percentage)] <- 0
shape@data$Percentage <- round(shape@data$Percentage*100,1)

# Generating the base of the singleTable (table for single travel mean) in UI
newtable <- subset(shape@data)
newtable <- subset(newtable, select = -c(TA2013, TA2013_NAM, MeanFull, AreaFull))


# This function plots the colored map of single travel mean
singleMap <- function(numQUan, travelMean, classIntMethod)
{
  # Defining the color data for single table
  pal <- colorRampPalette(c("yellow","red"), space= "rgb")
  
  if (classIntMethod == "fixed") {
    breakList <- c(min(shape@data$Percentage[shape@data$Mean==travelMean]))
    unit <- round(max(shape@data$Percentage[shape@data$Mean==travelMean])/numQUan, digits = 1)
    for (i in 1:numQUan) {
      breakList <- c(breakList, unit*i)
    }
    
    nclass <- classIntervals(shape@data$Percentage[shape@data$MeanCode==travelMean], n= numQUan, style = classIntMethod
                             , fixedBreaks = breakList, dataPrecision = 1)
  } else {
    nclass <- classIntervals(shape@data$Percentage[shape@data$MeanCode==travelMean], n= numQUan, style = classIntMethod
                             , dataPrecision = 1)  
  }
  
  len <- length(nclass$brks)
  colPal <- findColours(nclass, pal(len))
  
  #Draw the coloured map and relevant details
  plot(shape, legend=FALSE, border = "Black", col= colPal)
  
  #Setting up the legend text in the proper percentages format
  legendT <- c()
  legendText <- c()
  newText <- c()
  
  for (i in 1:len)
  {
    newText <- str_trim(paste(round(nclass$brks[i], digits = 1), '%'))
    legendT <- c(legendT, newText)
  }
  
  for (i in 1:(len-1))
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
  
  legend('bottomright', legend= legendText, title = 'Legend', fill= pal(len), bty = 'o')#, pch= 1
}



prepareTwoMeans <- function(travelMeans) {
  listx <- subset(newtable[newtable$MeanCode==travelMeans[1],])
  listx <- listx[order(listx$Percentage),] 
  
  listy <- subset(newtable[newtable$MeanCode==travelMeans[2],], select = -c(MeanName))
  listy <- listy[order(listy$Percentage),] 
  
  listx$xpos <- seq(nrow(listx))
  listy$ypos <- seq(nrow(listy))
  
  listx <- merge(listx, listy, by.x = c("AreaName"), by.y = c("AreaName"), all=TRUE)
  listx <- within(listx, mix <- rgb(red=255*listx$x/nrow(listx), green=0, blue=255*listx$y/nrow(listx)
                                    , maxColorValue=255))
  
  return(listx)  
}



# This function plots the colored map of two travel means
biMap <- function(travelMeans)
{
  fullList <- prepareTwoMeans(travelMeans)
  plot(shape, legend=FALSE, border = "Black", col= fullList$mix)
  #legend('bottomright', legend = "x,y", title = 'Legend', fill= pal(fullList$mix), bty = 'o')#, pch= 1
}

#singleMap(5, travelMean = as.character(meandata$MeanCode[1]), "pretty")
#title(paste ("Map of New Zealand \n Travel mean: ", meandata$MeanName[meandata$MeanCode == travelMean]))