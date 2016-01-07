geoCol <- c()



#Assigning the colours to TAs by the number of people
for (i in 1:length(shape@data$Percentage[shape@data$Mean == travelMean]))
{
  x <- shape@data$Percentage[shape@data$Mean == travelMean][i]
  if (!is.na(x))
  {
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
