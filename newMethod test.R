# This script is used for testing new method

remove(testmat)
remove(listx)
remove(listy)
remove(x)
remove(y)

#Draft to the method
listx <- subset(geodata[geodata$MeanCode=='02',], select = -c( AreaFull,MeanName,MeanFull))
listx <- listx[order(listx$Percentage),] 
#& geodata$AreaCode %in% c("001","002","003","004")

listy <- subset(geodata[geodata$MeanCode=='09',], select = -c( AreaFull,MeanName,MeanFull))
listy <- listy[order(listy$Percentage),] 


listx$xpos <- seq(length=nrow(listx))
listy$ypos <- seq(length=nrow(listy))


listx <- merge(listx, listy, by.x = c("AreaName"), by.y = c("AreaName"), all=TRUE)
#names(listx)

#head(listx)
#head(listy)

len <- length(listy$AreaName)
testmat <- matrix(data = "-", nrow = len, ncol = len)#, dimnames = list("")

for (n in 1:len) {
  #n=1
  x <- listx$xpos[n]
  y <- listx$ypos[n]
  #name <- listx$AreaName[n]
  testmat[x,y] <- as.character(listx$AreaName[n]) 
}
#name
#attributes(name)

head(testmat)

#testmat[10,50]
#listx$AreaName[1]

#colr <- colorRampPalette(c("white", "red"), space= "rgb")
#colb <- colorRampPalette(c("white", "blue"), space= "rgb")

