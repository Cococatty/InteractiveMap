#TOOLS
remove(shape)
remove(geodata)
remove(joined)

#closeAllConnections()

library(maptools)
library(classInt)

#Read the data
setwd("//file/UsersY$/yzh215/Home/Desktop/Map")
geodata <- read.table('Mean 3.txt', col.names= c('Mean', 'Area', 'Ppl'), header= FALSE, 
                      numerals = c('no.loss') )
#geodata <- geodata[-1,]

shape <- readShapeSpatial("./Shapefiles/2 ESRI/TA2013_GV_Clipped.shp")
shape@data <- merge(shape@data,geodata,by.x="TA2013",by.y="Area", all.x= TRUE )#, replace = TRUE 
shape@data$Ppl <- as.numeric(levels(shape@data$Ppl)[shape@data$Ppl])


#Checking the data types
#str(geodata)
#str(shape@data)

#shape@data
#help(is.na)
#length(shape@data$Ppl)
#length(levels(shape@data$Ppl))


nclass <- classIntervals(shape@data$Ppl, n=5, style="quantile")

#geoPal <- c("#BFEFFF","#42C0FB","#0198E1","#53868B","#236B8E", "#000000")
#geoPal <- c("white","","darkgreen","blue","black", "yellow")
geoPal <- c("#ffffff","#80b3ff","#1a75ff","#0047b3","#001f4d", "#ffff00")
geoCol <- c()


x1 <- 0
x2 <- 0
x3 <- 0
x4 <- 0
x5 <- 0
x6 <- 0

for (i in 1:length(shape@data$Ppl))
{
  if (!is.na(shape@data$Ppl[i]))
  {
    x <- shape@data$Ppl[i]
    if (x < 2854.2) {
      #print("First")
      currCol <- geoPal[1]
      x1 <- x1+1
    } else if (2854.2 <= x && x <6681.6) {
      #print("Second")
      currCol <- geoPal[2]
      x2 <- x2+1
    } else if (6681.6 <= x && x < 11764.2) {
      #print("Third")					
      currCol <- geoPal[3]
      x3 <- x3+1
    } else if (11764.2 <= x && x < 16923) {
      #print("Fourth")
      currCol <- geoPal[4]
      x4 <- x4+1
    } else if (x >= 16923) {
      #print("Fifth")
      currCol <- geoPal[5]
      x5 <- x5+1
    }
  }
  else {
    #print("Weird")
    currCol <- geoPal[6]
    x6 <- x6+1
  }
  geoCol <- c(geoCol, currCol)
}

#geoCol
#length(geoCol)
#length(shape@data$Ppl)

#Draw the coloured map

plot(shape, legend=FALSE, border = "Black", col= geoCol)
title(paste ("Map of New Zealand"))

#nclass <- nclass$nclass
#round(nclass)
#legend(x='bottomright', legend=c('2854', '6681', '11764', '16923', '32402', 'yellow'), fill= geoCol )
legend('bottomright', legend= c('2854', '6681', '11764', '16923', '32402', 'yellow'), title = 'Legend', 
       fill= geoPal, bty = 'o')#, pch= 1
#legend(x = 4.5, y = 7, legend = levels(iris$Species), col = c(1:3), pch = 16)


#help(legend)
x1
x2
x3
x4
x5
x6

x1+x2+x3+x4+x5+x6

#help(plot)
#     plot.default
warnings()
