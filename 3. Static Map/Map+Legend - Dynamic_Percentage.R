#Clearing up the data
rm(list=ls())


#Loading the requiring sources
library(maptools)
library(classInt)


#Initializing the variables
x1 <- 0
x2 <- 0
x3 <- 0
x4 <- 0
x5 <- 0
x6 <- 0
travelMean <- '09'
numQuan <- 5

#Read the data
setwd("//file/UsersY$/yzh215/Home/Desktop/Map")

geodata <- read.table('Raw-CODE_M.txt', col.names= c('Mean', 'Area', 'Ppl'), header= FALSE, 
                      numerals = c('no.loss'))

geodata <- geodata[!(geodata$Mean == 'Mean' & geodata$Area == 'Area'), ]

#
#if (travelMean != 60) {
# geodata <- subset(geodata, geodata$Mean == travelMean)
#}

#Create a new column "Percentage" in geodata
geodata$Percentage <- c(0)

#Create a list with the Areas and the total numbers of ppl
totalList <- setNames(aggregate(as.numeric(levels(geodata$Ppl)[geodata$Ppl]), by=list(Area=geodata$Area), FUN = sum)
                      , c('AreaCode', 'Total')
)

#Calculate the percentages within Areas
for (i in 1:length(geodata$Percentage))
{
  rowPpl <- as.numeric(levels(geodata$Ppl[i])[geodata$Ppl[i]])
  rowTotal <- ((totalList[totalList$Area == geodata$Area[i],]) $Total)
  geodata$Percentage[i] <- (rowPpl / rowTotal)
 
}


#Reading and merging the shapefiles
shape <- readShapeSpatial("./Shapefiles/2 ESRI/TA2013_GV_Clipped.shp")
shape@data <- merge(shape@data,geodata,by.x="TA2013",by.y="Area", all.x= TRUE )#, replace = TRUE 
shape@data$Ppl <- as.numeric(levels(shape@data$Ppl)[shape@data$Ppl])
#shape@data$Percentage <- as.numeric(levels(shape@data$Percentage)[shape@data$Percentage])
shape@data$Percentage[is.na(shape@data$Percentage)] <- 0
shape@data <- shape@data[!(shape@data$TA2013=='999'),]



#Assigning data
nclass <- classIntervals(shape@data$Percentage[shape@data$Mean==travelMean], n=numQuan, style="quantile")
geoPal <- c("#ffffff","#80b3ff","#1a75ff","#0047b3","#001f4d", "#ffff00")
geoCol <- c()



#Assigning the colours to TAs by the number of people
for (i in 1:length(shape@data$Percentage[shape@data$Mean == travelMean]))
{
  x <- shape@data$Percentage[shape@data$Mean == travelMean][i]
  if (!is.na(x))
  {
    if (x < nclass$brks[2]) {
      currCol <- geoPal[1]
      x1 <- x1+1
    } else if (nclass$brks[2] <= x && x < nclass$brks[3]) {
      currCol <- geoPal[2]
      x2 <- x2+1
    } else if (nclass$brks[3] <= x && x < nclass$brks[4]) {
      currCol <- geoPal[3]
      x3 <- x3+1
    } else if (nclass$brks[4] <= x && x < nclass$brks[5]) {
      currCol <- geoPal[4]
      x4 <- x4+1
    } else if (x >= nclass$brks[5]) {
      currCol <- geoPal[5]
      x5 <- x5+1
    }
  }
  else {
    currCol <- geoPal[6]
    x6 <- x6+1
  }
  geoCol <- c(geoCol, currCol)
}

#Draw the coloured map and relevant details
plot(shape, legend=FALSE, border = "Black", col= geoCol)
title(paste ("Map of New Zealand by travel mean: ", travelMean, " IN percentage"))
legend('left', legend= paste('from ', round((nclass$brks*100), 2), '%'), title = 'Legend',
       fill= geoPal, bty = 'o')#, pch= 1


#Review testing data
x1
x2
x3
x4
x5
x6

x1+x2+x3+x4+x5+x6


#Checking the warnings
#warnings()



