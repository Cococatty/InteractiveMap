
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

