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
travelMean <- '03'
numQuan <- 5

#Read the data
setwd("//file/UsersY$/yzh215/Home/Desktop/Map")

geodata <- read.table('Raw-CODE_M.txt', col.names= c('Mean', 'Area', 'Ppl'), header= FALSE, 
                      numerals = c('no.loss'))

geodata <- geodata[!(geodata$Mean == 'Mean' & geodata$Area == 'Area'), ]

if (travelMean != 60) {
  geodata <- subset(geodata, geodata$Mean == travelMean)
}


shape <- readShapeSpatial("./Shapefiles/2 ESRI/TA2013_GV_Clipped.shp")
shape@data <- merge(shape@data,geodata,by.x="TA2013",by.y="Area", all.x= TRUE )#, replace = TRUE 
shape@data$Ppl <- as.numeric(levels(shape@data$Ppl)[shape@data$Ppl])

#Assigning data and colours
nclass <- classIntervals(shape@data$Ppl, n=numQuan, style="quantile")

colorPal <- colorRampPalette(c("green", "red"), 5, space = c("rgb"))

geoPal <- c("#ffffff","#80b3ff","#1a75ff","#0047b3","#001f4d", "#ffff00")
geoCol <- c()

help(colorRampPalette)

#Assigning the colours to TAs by the number of people
for (i in 1:length(shape@data$Ppl))
{
  if (!is.na(shape@data$Ppl[i]))
  {
    x <- shape@data$Ppl[i]
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
title(paste ("Map of New Zealand by travel mean: ", travelMean))
legend('bottomright', legend= c(nclass$brks), title = 'Legend',
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
warnings()

