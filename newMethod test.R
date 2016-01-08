# This script is used for testing new method

bike <- subset(geodata[(geodata$MeanCode %in% c('09')#, '02', '15')
                        #  & geodata$AreaCode %in% c('001', '002', '003')
),]
, select=-c(AreaName, AreaFull, MeanFull,MeanName, Percentage)) 


remove(tb)
head(bike)
names(bike)
summary(bike)

