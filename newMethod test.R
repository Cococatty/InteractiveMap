# This script is used for testing new method

# The following is for "selecting the cell and information shall be displayed on the RHS
# 
colPal <- findColours(nclass, pal(length(nclass$brks-1)))


names(listx)

library(ggplot2)
ggplot(listx, aes(x=listx$x, y=listx$y)) + 
  geom_tile(aes(fill=mix), color="white") + 
  scale_fill_identity()



dat <- expand.grid(blue=seq(0, 100, by=10), red=seq(0, 100, by=10))
dat <- within(dat, mix <- rgb(green=0, red=red, blue=blue, maxColorValue=100))

library(ggplot2)
ggplot(dat, aes(x=red, y=blue)) + 
  geom_tile(aes(fill=mix), color="white") + 
  scale_fill_identity()










test <- retrivingBiTable(travelMeans)

colnames(test) <- 1:length(test[1,])
rownames(test) <- 1:length(test[1,])
 

filled.contour(x=1:67,y=1:67,z=biMatrix)

a <- expand.grid(1:20, 1:20)
b <- matrix(a[,1] + a[,2], 20)
t <- filled.contour(x = 1:20, y = 1:20, z = b,
               plot.axes = { axis(1); axis(2); points(10, 10) })


# Defining the color data for single table
pal <- colorRampPalette(c("yellow","red"), space= "rgb")

colPal <- findColours(nclass, pal(length(nclass$brks-1)))

#Draw the coloured map and relevant details
plot(shape, legend=FALSE, border = "Black", col= colPal)




temp <- compute.cor(test, 'pearson')
library(graphics)
library("quantmod")
require("quantmod")
require('quantmod') || install.packages('quantmod')

plot.table(test,  highlight=TRUE, colorbar = TRUE)


head(test)
attributes(biMatrix)
head( as.table(test) )
head( as.data.frame (test) )


names(as.data.frame (test) )
attributes(as.data.frame (test) )

head(geodata[geodata$AreaCode=="060",])
totalList[totalList$AreaCode=="060",]



t1 <- data.frame("-", nrow=3,ncol=3)
t2 <- table("-", nrow=3,ncol=3)


dat <- read.csv("http://personal.colby.edu/personal/m/mgimond/R/Data/FAO_grains_NA.csv", header=TRUE)
dat <- dat[1:10,]
attributes(dat)

as.table(dat)
as.data.frame(dat)












# The follownig is for - Coloring the matrix
travelMeans <- c("02","04")
t <- c("02","04")
test <- retrivingBiTable(t)
head(test)
head(geodata[geodata$AreaCode=="060",])
totalList[totalList$AreaCode=="060",]



# POTENTIAL SOLUTIONS

filled.contour(test, color = colorRampPalette(c("red","blue")), asp = 1) # simple

color2D.matplot(test,c(1,0),c(0,0),c(0,1),show.legend=TRUE,
                xlab="Columns",ylab="Rows",main="2D matrix plot")



# Get ready for the two-way table
maxList <- setNames(aggregate(geodata$Percentage, by=list(geodata$MeanCode), max), c('MeanCode', 'Max')) 


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

