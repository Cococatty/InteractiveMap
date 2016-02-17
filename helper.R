# LAST UPDATED AT 10/2, 12pm
# 

# Clearing up the data
rm(list=ls())

# Loading the requiring sources
require("classInt") || install.packages("classInt")
require("colorRamps") || install.packages("colorRamps")
require("maptools") || install.packages("maptools")
require("stringr") || install.packages("stringr")
require("ggplot2") || install.packages("ggplot2")
require("png") || install.packages("png")

# Initializing the variables
travelMean <- c()

# Set the working directory and read the required data
# setwd("//file/UsersY$/yzh215/Home/Desktop/InteractiveMap")
# setwd("/home/cococatty/Desktop/InteractiveMap")
# setwd("C:/Users/User/Desktop/InteractiveMap")
setwd("C:/Users/Josh/Desktop/InteractiveMap")


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

# Calculate the percentages within Areas
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
  
  # Draw the coloured map and relevant details
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

# Function to plot color bar
colorbar <- function(colourlist, travelMeans, min, max=-min, nticks=5, ticks=seq(min, max, len=nticks)) {#, travelMeans
  lut <- colorRampPalette(colourlist)(100)
  scale = (length(lut)-1)/(max-min)
  plot(c(0,10), c(min,max), type='n', bty='n', xaxt='n', yaxt='n', ylab= NA, xlab=NA
       , main='Legend')#, border = 'black'
  axis(2, ticks, labels = c('Neutral', as.character(meandata$MeanName[meandata$MeanCode == travelMeans[1]])
                            , 'Both', as.character(meandata$MeanName[meandata$MeanCode == travelMeans[2]]), 'Neutral'), las=1)
  for (i in 1:(length(lut)-1)) {
    y = (i-1)/scale + min
    rect(0,y,10,y+1/scale, col=lut[i], border= NA)#, border= "solid"
  }
}


# This function plots the colored map of two travel means
biMap <- function(travelMeans)
{
  fullList <- prepareTwoMeans(travelMeans)
  par(mfrow=c(1,2))
  plot(shape, legend=FALSE, border = "Black", col= fullList$mix)
  colorbar(c("black", "red", "purple", "blue", "black"), travelMeans, -10)
}



#required function 'val2col' from: http://www.menugget.blogspot.de/2011/09/converting-values-to-color-levels.html

val2col<-function(z, zlim, col = heat.colors(12), breaks){
  if(!missing(breaks)){
    if(length(breaks) != (length(col)+1)){stop("must have one more break than colour")}
  }
  if(missing(breaks) & !missing(zlim)){
    zlim[2] <- zlim[2]+c(zlim[2]-zlim[1])*(1E-3)#adds a bit to the range in both directions
    zlim[1] <- zlim[1]-c(zlim[2]-zlim[1])*(1E-3)
    breaks <- seq(zlim[1], zlim[2], length.out=(length(col)+1)) 
  }
  if(missing(breaks) & missing(zlim)){
    zlim <- range(z, na.rm=TRUE)
    zlim[2] <- zlim[2]+c(zlim[2]-zlim[1])*(1E-3)#adds a bit to the range in both directions
    zlim[1] <- zlim[1]-c(zlim[2]-zlim[1])*(1E-3)
    breaks <- seq(zlim[1], zlim[2], length.out=(length(col)+1))
  }
  colorlevels <- col[((as.vector(z)-breaks[1])/(range(breaks)[2]-range(breaks)[1]))*(length(breaks)-1)+1] # assign colors to heights for each point
  colorlevels
}

plotLegend <- function() {
  library(png)
  #data
  x <- seq(255)
  y <- seq(255)
  grd <- expand.grid(x=x,y=y)
  
  #assign colors to grd levels
  pal1 <- colorRampPalette(c("white", "red"), space = "rgb")
  col1 <- val2col(x, col=pal1(255))
  pal2 <- colorRampPalette(c("white", "blue"), space = "rgb")
  col2 <- val2col(y, col=pal2(255))
  col3 <- NA*seq(nrow(grd))
  for(i in seq(nrow(grd))){
    xpos <- grd$x[i]
    ypos <- grd$y[i]
    coltmp <- (col2rgb(col1[xpos])/2) + (col2rgb(col2[ypos])/2)
    col3[i] <- rgb(coltmp[1], coltmp[2], coltmp[3], maxColorValue = 255)
  }
  
  #plot
  png("./test.png", width=6, height=4, units="in", res=200)
  layout(matrix(c(1,2,3), nrow=1, ncol=3), widths=c(4,1,1), heights=4, respect=T)
  par(mar=c(4,4,2,2))
  plot(grd,col=col3, pch=19, xaxt='n', yaxt='n') # axes=FALSE, 
  dev.off()
}

plotLegend()
#singleMap(5, travelMean = as.character(meandata$MeanCode[1]), "pretty")
#title(paste ("Map of New Zealand \n Travel mean: ", meandata$MeanName[meandata$MeanCode == travelMean]))