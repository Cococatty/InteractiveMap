
#verify the means and sum up the ppl
for (i in 1:length(geodata$Percentage))
{
  if (geodata$Mean[i] == '03')
  {
    numOfPpl <- as.numeric(levels(geodata$Ppl)[geodata$Ppl])[i]
    testsum <- testsum + numOfPpl
  }
}


#warnings()
testsum

#Create a list with the means and the total numbers of ppl
totalList <- setNames(aggregate(as.numeric(levels(geodata$Ppl)[geodata$Ppl]), by=list(Mean=geodata$Mean), FUN = sum)
                      , c('MeanCode', 'Total')
)



#converting the type
geodata$Ppl <- as.numeric(levels(geodata$Ppl)[geodata$Ppl])

#remove the row
geodata <- geodata[!(geodata$Mean == 'Mean' & geodata$Area == 'Area'), ]
geodata <- geodata[!(geodata$Mean == 'Mean' & geodata$Area == 'Area'), ]


#printing the data

for (i in 1:length(nclass$brks))
{
  cat(paste(nclass$brks[i], '%'))
  
}

#shape@data$Percentage <- paste(round(shape@data$Percentage*100,0), "%", sep="")


min(shape@data$Percentage)
max(shape@data$Percentage)


#Removing not-required data
shape@data <- shape@data[!shape@data$TA2013_NAM == 'Chatham Islands Territory',]

#Colouring the legend
pal <- colorRampPalette(c("red", "blue"))
pal <- colorRampPalette(c("red", "yellow", "blue"))
legend('bottomright', legend= legendText, title = 'Legend',
       fill= pal(8)
       , bty = 'o')#, pch= 1


#Selecting unique rows by columns
geodata[!duplicated(geodata[, c('MeanCode', 'MeanDesc', 'MeanFull') ]), ]

geodata[row.names( unique(geodata[, c('MeanCode', 'MeanDesc', 'MeanFull') ]) ),]

unique(geodata[c('MeanCode', 'MeanDesc', 'MeanFull') ] )



# Retriving the biTable
listx <- subset(geodata[geodata$MeanCode=='02',], select = -c( AreaFull,MeanName,MeanFull))
listx <- listx[order(listx$Percentage),] 
#& geodata$AreaCode %in% c("001","002","003","004")

listy <- subset(geodata[geodata$MeanCode=='09',], select = -c( AreaFull,MeanName,MeanFull))
listy <- listy[order(listy$Percentage),] 


listx$xpos <- seq(length=nrow(listx))
listy$ypos <- seq(length=nrow(listy))

listx <- merge(listx, listy, by.x = c("AreaName"), by.y = c("AreaName"), all=TRUE)

len <- length(listy$AreaName)
testmat <- matrix(data = "-", nrow = len, ncol = len)#, dimnames = list("")

for (n in 1:len) {
  x <- listx$xpos[n]
  y <- listx$ypos[n]
  testmat[x,y] <- as.character(listx$AreaName[n]) 
}

head(testmat)



# The method to mix two colours together by xpos and ypos from the two-mean table
travelMeans <- c("02","04")
biMatrix <- retrivingBiTable(travelMeans)

len <- length(biMatrix[1,])
listx <- within(listx, mix <- rgb(red=listx$x, green=0, blue=listx$y, maxColorValue=len))

for (n in 1:67) {
  listx$r[n] <- col2rgb(listx$mix[n])[,1][1]
  listx$g[n] <- col2rgb(listx$mix[n])[,1][2]
  listx$b[n] <- col2rgb(listx$mix[n])[,1][3]
}

listx[order(listx$xpos,listx$ypos),] 
plot(shape, legend=FALSE, border = "Black", col= listx$mix)

# rpal <- colorRampPalette(c("white", "red"))
# bpal <- colorRampPalette(c("white", "Blue"))
# rcolors <- rpal(len)
# bcolors <- bpal(len)

