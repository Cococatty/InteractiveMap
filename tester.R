
#TOOLS
remove(shape)
remove(allgeodata)
closeAllConnections()



help(classIntervals)


#Testing the code
numQUan=5
travelMean = as.character(meandata$MeanCode[1])
classIntMethod="pretty"


#Testing two-way table
head(geodata)
meandata

bike <- meandata[(meandata$MeanCode=='09'),]
didn <- meandata[(meandata$MeanCode=='02'),]

