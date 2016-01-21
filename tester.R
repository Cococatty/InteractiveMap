
#TOOLS
remove(shape)
remove(allgeodata)
closeAllConnections()



help(classIntervals)


#Testing the code
numQUan=5; travelMean = c('03'); classIntMethod="pretty";
singleMap(numQUan, travelMean, classIntMethod)


numQUan=5; travelMean = c('03','09'); classIntMethod="pretty";
t <- prepareTwoMeans(travelMean)
head(t)
biMap(travelMean)
legend('bottomright', legend = "x,y", title = 'Legend', fill= pal(fullList$mix), bty = 'o')#, pch= 1


image(t$xpos, t$ypos, t(seq_along(t$xpos)), col=t$mix,axes=FALSE,xlab="",ylab="")

image(x=t$xpos, y=t$ypos, z=0
      , col = t$mix, xlab="x", ylab="y", useRaster = TRUE)

#, xlim=(min(t$xpos), max(t$xpos)), ylim=(min(t$ypos), max(t$ypos))




require(grDevices) # for colours
x <- y <- seq(-4*pi, 4*pi, len = 27)
r <- sqrt(outer(x^2, y^2, "+"))
image(z = z <- cos(r^2)*exp(-r/6), col  = gray((0:32)/32))
image(z, axes = FALSE, main = "Math can be beautiful ...",
      xlab = expression(cos(r^2) * e^{-r/6}))
contour(z, add = TRUE, drawlabels = FALSE)


image(t(volcano)[ncol(volcano):1,])

# A prettier display of the volcano
x <- 10*(1:nrow(volcano))
y <- 10*(1:ncol(volcano))
head(volcano[1:6,1:6])
image(x, y, volcano, col = terrain.colors(100), axes = FALSE)
contour(x, y, volcano, levels = seq(90, 200, by = 5),
        add = TRUE, col = "peru")
axis(1, at = seq(100, 800, by = 100))
axis(2, at = seq(100, 600, by = 100))
box()
title(main = "Maunga Whau Volcano", font.main = 4)


x <- (min(t$xpos) : max(t$xpos))
y <- (min(t$ypos) : max(t$ypos))
as.matrix(t)
image(x,y,z=0,as.matrix(t),col=terrain.colors(67),axes=FALSE)

library(plotrix)
newmat <- matrix(data = 0, nrow=255, ncol =255)
newmat


library("SDMTools")
#define a simple binary matrix
tmat = { matrix(c( 0,0,0,1,0,0,1,1,0,1,
                   0,0,1,0,1,0,0,0,0,0,
                   0,1,NA,1,0,1,0,0,0,1,
                   1,0,1,1,1,0,1,0,0,1,
                   0,1,0,1,0,1,0,0,0,1,
                   0,0,1,0,1,0,0,1,1,0,
                   1,0,0,1,0,0,1,0,0,0,
                   0,1,0,0,0,1,0,NA,NA,NA,
                   0,0,1,1,1,0,0,NA,NA,NA,
                   1,1,1,0,0,0,0,NA,NA,NA),nr=10,byrow=TRUE) }

#do the connected component labeling
tasc = ConnCompLabel(tmat)

# Create a color ramp
colormap=c("grey","yellow","yellowgreen","olivedrab1","lightblue4")

#create an image
image(tasc,col=colormap, axes=FALSE, xlab="", ylab="", ann=FALSE)

#points for the gradient legend
pnts = cbind(x =c(0.8,0.9,0.9,0.8), y =c(1.0,1.0,0.8,0.8))

#create the gradient legend
legend.gradient(pnts,colormap,c("Low","High"))