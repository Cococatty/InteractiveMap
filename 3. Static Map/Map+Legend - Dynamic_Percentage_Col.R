#Clearing up the data
rm(list=ls())


#Loading the requiring sources
library(maptools)
library(classInt)
library(stringr)
library(colorRamps)



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


meandata <- read.table('MeansDetails.txt', col.names= c('MeanCode', 'MeanName', 'MeanFull'), header= F, sep="\t")
meandata <- meandata[!(meandata$MeanCode == 'MeanCode' & meandata$MeanName == 'MeanName'), ]


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
shape <- shape[!shape@data$TA2013_NAM == 'Chatham Islands Territory',]
shape@data <- merge(shape@data,geodata,by.x="TA2013",by.y="Area", all.x= TRUE )#, replace = TRUE 
shape@data$Ppl <- as.numeric(levels(shape@data$Ppl)[shape@data$Ppl])
shape@data$Percentage[is.na(shape@data$Percentage)] <- 0
shape@data <- shape@data[!(shape@data$TA2013=='999'),]
shape@data$Percentage <- round(shape@data$Percentage*100,2)


#Assigning data
pal <- colorRampPalette(c("yellow","red"), space= "rgb")
nclass <- classIntervals(shape@data$Percentage[shape@data$Mean==travelMean], style="pretty")

colPal <- findColours(nclass, pal(length(nclass$brks-1)))


#Draw the coloured map and relevant details
plot(shape, legend=FALSE, border = "Black", col= colPal)
title(paste ("Map of New Zealand \n Travel mean: ", meandata$MeanName[meandata$MeanCode == travelMean]))


#Setting up the legend text in the proper percentages format
legendT <- c()
legendText <- c()
newText <- c()

for (i in 1:length(nclass$brks))
{
  newText <- str_trim(paste(nclass$brks[i], '%'))
  legendT <- c(legendT, newText)
}

for (i in 1:(length(nclass$brks)-1))
{
  newText <- c()
  if (i == 1) {
    newText <- paste('0 % -', legendT[i])  
  }
  else {
    newText <- paste(legendT[i], '-', legendT[i+1])
  }
  legendText <- c(legendText, newText)
}


legend('bottomright', legend= legendText, title = 'Legend', fill= pal(length(nclass$brks)-1), bty = 'o')#, pch= 1
