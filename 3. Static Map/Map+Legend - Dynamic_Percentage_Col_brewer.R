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


#Read the data
setwd("//file/UsersY$/yzh215/Home/Desktop/Map")

geodata <- read.table('Raw-CODE_M.txt', col.names= c('Mean', 'Area', 'Ppl'), header= FALSE, 
                      numerals = c('no.loss'))

geodata <- geodata[!(geodata$Mean == 'Mean' & geodata$Area == 'Area'), ]


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
shape@data$Percentage[is.na(shape@data$Percentage)] <- 0
shape@data <- shape@data[!(shape@data$TA2013=='999'),]


#Assigning data
library(RColorBrewer)
#palCodes <- brewer.pal(numQuan, "Blues")
#nclass <- classIntervals(shape@data$Percentage[shape@data$Mean==travelMean], n=numQuan, style="pretty", method= "complete")
max <- max(shape@data$Percentage)
min <- min(shape@data$Percentage)
#breaks <- (max - min) / numQuan
#nclass <- classIntervals(shape@data$Percentage[shape@data$Mean==travelMean], n=numQuan, style="pretty", fixedBreaks = seq(min, max, breaks))
nclass <- classIntervals(shape@data$Percentage[shape@data$Mean==travelMean], style="pretty")
colPal <- findColours(nclass, palCodes)
nclass <- nclass$brks
remove(nclass)

#Draw the coloured map and relevant details
#plot(shape, legend=FALSE, border = "Black", col.regions= colPal, col="transparent")
plot(shape, legend=FALSE, border = "Black", col= colPal)
title(paste ("Map of New Zealand by travel mean: ", travelMean, " IN percentage"))
legend('left', legend= names(round(attr(colPal, 'table'),2)), title = 'Legend',
       fill= attr(colPal, 'palette'), bty = 'o')#, pch= 1



str(lab)

plot.new()