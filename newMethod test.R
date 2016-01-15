# This script is used for testing new method

bike <- subset(geodata[((geodata$MeanCode %in% c('09', '02'))
                        #, '15')
),] , select=-c(AreaName, AreaFull, MeanFull,MeanName)) 


library(colorRamps)

head(geodata)
head(shape@data)
head(bike)
head(warpbreaks)


test <- xtabs(as.numeric(Ppl) ~ AreaCode + MeanCode, data=geodata)
test <- xtabs(as.numeric(Ppl) ~ MeanCode + AreaCode, data=geodata)
attributes(test) 
test$class
test$call

names(bike)




colnames(biTableDraft)

biTableDraft$MeanCode
biTableDraft[biTableDraft$MeanCode=="01"]
biTableDraft["MeanCode"=="09"]

levels(biTableDraft["MeanCode"])

head(biTableDraft)
x<-as.data.frame(biTableDraft)
head(x)
attributes(x)

biTableDraft[1,2]

biTableDraft[["MeanCode"]]
summary(biTableDraft)
getElement(biTableDraft, "MeanCode")

attributes(biTableDraft)


listx <- subset(geodata[geodata$MeanCode=='02',], select=-c(MeanFull,AreaFull,AreaName, MeanName)) 
head(listx)




colr <- colorRampPalette(c("white", "red"), space= "rgb")
colb <- colorRampPalette(c("white", "blue"), space= "rgb")


#palX <- 
n <- length(levels(bike$AreaCode))
newMatrix <- matrix(nrow = n, ncol = n)

plot(1,col = rgb(1,0,0,alpha =1)) 
# as long as alpha < 1, there is no point in the plot. 

plot(1,col = rgb(0,0,255, alpha=254, 
                 maxColorValue=255)) 

rgb(255,255,0)

rgb(0.4,0.5,0)

  
is.matrix(as.matrix(1:10))
!is.matrix(warpbreaks)  # data.frame, NOT matrix!
warpbreaks[1:10,]
as.matrix(warpbreaks[1:10,])  # using as.matrix.data.frame(.) method

## Example of setting row and column names
mdat <- matrix(c(1,2,3, 11,12,13), nrow = 2, ncol = 3, byrow = TRUE,
               dimnames = list(c("row1", "row2"),
                               c("C.1", "C.2", "C.3")))
mdat



dim(as.array(letters))
array(1:3, c(2,4)) # recycle 1:3 "2 2/3 times"
#     [,1] [,2] [,3] [,4]
#[1,]    1    3    2    1
#[2,]    2    1    3    2


array(2:6, c(68,68))


r <- matrix(runif(9, 0, 1), 3)
g <- matrix(runif(9, 0, 1), 3)
b <- matrix(runif(9, 0, 1), 3)

col <- rgb(r, g, b)
dim(col) <- dim(r)

plot(r)
plot(g)
plot(b)

library(grid)
grid.raster(col, interpolate=FALSE)



bike
head(bike)
#remove(bike)
head(listx)

listx <- bike[bike$MeanCode=='02',]
listx <- listx[order(listx$Percentage),] 

listy <- bike[bike$MeanCode=='09',]
listy <- listy[order(listy$Percentage),] 



colx(length(listx$Percentage))
length(listy$Percentage)

(length(listy$Percentage)/255)*

names(listy)
summary(listy)
attributes(listy)

rownames(listx) <- seq(length=nrow(listx))
rownames(listy) <- seq(length=nrow(listy))



library(classInt)
classx <- classIntervals(xlist$Percentage, n= 5, style = 'quantile', dataPrecision = 2)
classy <- classIntervals(ylist$Percentage, n= 5, style = 'quantile', dataPrecision = 2)

palx <- findColours(classx, redt(length(classx$brks-1)))
paly <- findColours(classy, bluet(length(classy$brks-1)))

listy$row09 <- rownames(listy)
listy$rowOrder <- NULL

bike$row09 <- 0

head(bike)


maxy <- max(listy$Percentage)

meandata
for (n in 1:length(bike$Percentage)) {
  bike$col09 <- 
}
