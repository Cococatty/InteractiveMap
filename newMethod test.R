# This script is used for testing new method

# The following is for "selecting the cell and information shall be displayed on the RHS

travelMeans <- c('02', '04')
test <- prepareTwoMeans(travelMeans)
head(test[1:6,])
#attributes(test) 


colorList <- list()

pts <- list(x = cars[,1], y = cars[,2])

t <- list(c(0,255,255), c(0,0,255))



df <- data.frame(row.names = 67, col.names = 67)

mat <- matrix(nrow=5, ncol=5, dimnames = list(1:5, 1:5))
mat <- matrix(nrow=6, ncol=6)
mat[1,] <- 1 #row
mat["1","1"]
mat[,] <- colnames(mat)
mat[[1]]
mat[[2]]
attributes(mat)
mat["dim"]
mat[0,0]
mat[1,1]
mat[1,2] <- 3
n <- 1
for (n in 1:mat[1,n]) {
  
}
colnames(mat)[1]
rgb(0, 1, 0)

rgb((0:15)/15, green = 0, blue = 0, names = paste("red", 0:15, sep = "."))

g <- rgb(0, 0:12, 0, max = 15) # integer input

ramp <- colorRamp(c("red", "white"))
plot.new()
rgb( ramp(seq(0, 1, length = 5)), max = 255)
legend('bottomright',legend = 1:5, fill = rgb( ramp(seq(0, 1, length = 5)), max = 255))
legend('bottomright',legend = 1:5, fill = g)


legend('bottomright', legend= legendText, title = 'Legend', fill= pal(len), bty = 'o')#, pch= 1


rgbpal <- rgb(0:255, 0, 0:255, maxColorValue = 255)
legend('bottomright',legend = 0:10, fill = rgbpal)


mat <- matrix(nrow=5, ncol=5)
pal <- rgb(red=)



mix <- rgb(red=255*listx$x/nrow(listx), green=0, blue=255*listx$y/nrow(listx)
           , maxColorValue=255)