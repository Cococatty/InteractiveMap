# This script is used for testing new method

# LINKS
# http://stackoverflow.com/questions/11773295/how-can-one-mix-2-or-more-color-palettes-to-show-a-combined-color-value
# http://stackoverflow.com/questions/9314658/colorbar-from-custom-colorramppalette


# The following is for "selecting the cell and information shall be displayed on the RHS

test <- prepareTwoMeans(travelMeans)
head(test[1:6,])
#attributes(test) 

travelMeans <- c('02', '04')
biMap(travelMeans)
legendBox(c('02', '06'))


dat <- expand.grid(blue=seq(255, 0, by=10), red=seq(255, 0, by=10))


# 1. NEED TO FIX THE 0,0 SAME AS 2.
dat <- expand.grid(blue=seq(255, 0, by=-10), red=seq(255, 0, by=-10))
dat <- within(dat, mix <- rgb(green=0, red=red, blue=blue, maxColorValue=255))
dat[dat$red==5 & dat$blue==5 & dat$green==255, ]
dat[dat$red==255 & dat$blue==255 & dat$green==5, ]
names(dat)

library(ggplot2)
ggplot(dat, aes(x=red, y=blue)) + 
  geom_tile(aes(fill=mix)) + 
  scale_fill_identity()

head(dat)


legendBox(travelMeans)


# 2. NEED TO FIX THE 0,0 SAME AS 1.
dat <- expand.grid(blue=seq(255, 0, by=-10), red=seq(255, 0, by=-10),green=seq(0, 255, by=10))
dat$green <- (dat$red + dat$blue)/2
dat <- within(dat, mix <- rgb(green=green, red=red, blue=blue, maxColorValue=255))

=======
    dat <- expand.grid(blue=seq(0, 255, by=10), red=seq(0, 255, by=10))
    dat <- within(dat, mix <- rgb(green=0, red=red, blue=blue, maxColorValue=255))
    
    library(ggplot2)
    ggplot(dat, aes(x=red, y=blue)) + 
      geom_tile(aes(fill=mix)) + 
      scale_fill_identity()


    # green=seq(255, 0, by = -10) -- R, P, B & BLACK
    
    
    dat <- expand.grid(red=seq(255, 0, by=-10), blue=seq(255, 0, by=-10), green = 175)
    dat <- within(dat, mix <- rgb(green=green, red=rev(red), blue=rev(blue), maxColorValue=255))
    
    library(ggplot2)
    ggplot(dat, aes(x=red, y=blue)) + 
      geom_tile(aes(fill=mix)) + 
      scale_fill_identity()
    
    
# 4. WHITE AT 0,0 BUT YELLOW, BLUE & GREEN
dat <- expand.grid(blue=seq(255, 0, by=-10), red=seq(255, 0, by=-10), green=seq(0,255, by = 10))
dat <- within(dat, mix <- rgb(green=green, red=rev(red), blue=rev(blue), maxColorValue=255))
>>>>>>> 215189ae35c3e120492924b938f248c567668ad2
library(ggplot2)
ggplot(dat, aes(x=red, y=blue)) + 
  geom_tile(aes(fill=mix)) + 
  scale_fill_identity()




dat <- expand.grid(blue=seq(255, 0, by=-10), red=seq(255, 0, by=-10), green=seq(255,0, by = -5))
dat <- within(dat, mix <- rgb(green=green, red=rev(red), blue=rev(blue), maxColorValue=255))
library(ggplot2)
ggplot(dat, aes(x=red, y=blue)) + 
  geom_tile(aes(fill=mix)) + 
  scale_fill_identity()



# UGLY!!
image(matrix(1:400, 20), col = blue2red(400))
matrix(1:400, 20)
image(matrix(1:400, 20), col = blue2green(400))
image(matrix(1:400, 20), col = green2red(400))






# Function to plot color bar
colorbar <- function(lut, min, max=-min, nticks=5, ticks=seq(min, max, len=nticks), travelMeans) {
  scale = (length(lut)-1)/(max-min)
  
  dev.new(width=1.75, height=5)
  plot(c(0,10), c(min,max), type='n', bty='n', xaxt='n', xlab=travelMeans[1], yaxt='n', ylab=travelMeans[2], main='Legend', border = 'black')
  axis(2, ticks, las=1)
  for (i in 1:(length(lut)-1)) {
    y = (i-1)/scale + min
    rect(0,y,10,y+1/scale, col=lut[i], border= NA)#, border= "solid"
  }
}

colorbar(colorRampPalette(c("white", "red", "purple", "blue", "white"))(100), -10)



my.colors = colorRampPalette(c("white", "red", "purple", "blue", "white"))
z=matrix(1:100,nrow=1)
x=1
y=seq(3,2345,len=100) # supposing 3 and 2345 are the range of your data
image(x,y,z,col=my.colors(100),axes=FALSE,xlab="",ylab="")
axis(side = 1, at = 1, lty = "solid", labels = "Mean 1")
axis(side = 2, at = 1, lty = "solid",labels = "Mean 2")

?axis
?image






mat = matrix(rnorm(400,1,1), ncol=20)
grad = rev(rainbow(1000, start=rgb2hsv(col2rgb('green'))[1], 
                   end=rgb2hsv(col2rgb('blue'))[1]))
require(lattice)
library(lattice)
levelplot(mat, col.regions=grad, colorkey = list(at=seq(0,max(mat),length.out=400)))