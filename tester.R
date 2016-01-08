
#TOOLS
remove(shape)
remove(allgeodata)
closeAllConnections()



help(classIntervals)


#Testing the code
numQUan=5
travelMean = c('03','09')
classIntMethod="pretty"
nz_map(numQUan, travelMean, classIntMethod)

#Testing two-way table

require(stats) # for rpois and xtabs

head(geodata)
meandata

remove(tb)
head(bike)
names(bike)
summary(bike)

input$travelMean
bike <- subset(geodata
               , select=-c(AreaName, AreaFull, MeanFull,MeanName, Percentage)) 


#bike <- bike[order(bike$Percentage), ]
#didnt <- didnt[order(didnt$Percentage), ]
#new <- subset(bike, select=-c(TA2013_NAM, AreaName, AreaFull, MeanFull))


tb <- with(bike, table(MeanCode, AreaCode))
tb <- table(bike$MeanCode[bike$Percentage], didnt$MeanCode[ didnt$Percentage])



head(tb)

summary(bike)

summary(didnt)




head(freeny.y,2)
tail(freeny.y)