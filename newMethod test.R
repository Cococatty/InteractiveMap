# This script is used for testing new method

#remove(testmat)

travelMeans <- c("02","04")
t <- c("02","04")
test <- retrivingBiTable(t)
head(test)

filled.contour(test, color = colorRampPalette(c("red","blue")), asp = 1) # simple


colors()[c(552,254,26)]

maxx <- maxList[maxList$MeanCode == t[1],]$Max
maxy <- maxList[maxList$MeanCode == t[2],]$Max

listx
head(listx)

xpos <- 4
ypos <- 2
rgb(xpos*maxx, 0, ypos*maxy, maxColorValue=1)

rgb(xpos*maxx/255, 0, ypos*maxy/255)


maxx <- length(geodata[geodata$MeanCode == travelMeans[1],]$AreaCode)
maxy <- length(geodata[geodata$MeanCode == travelMeans[2],]$AreaCode)
rgb(xpos*255/maxx, 0, ypos*255/maxy, maxColorValue=255)
#rgb(xpos*255/maxx, 0, ypos*(255/maxy), maxColorValue=1) #  not working

rgb(255, 255, 0, maxColorValue=255)

biTableMat



retrivingBiTable(travelMeans)
  biTableMat

  require("plotrix")
  color.gradient(c(0,1),c(1,0.6,0.4,0.3,0),c(0.1,0.6))
  
#testmat[10,50]
#listx$AreaName[1]

#colr <- colorRampPalette(c("white", "red"), space= "rgb")
#colb <- colorRampPalette(c("white", "blue"), space= "rgb")

