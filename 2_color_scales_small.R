#required function 'val2col' from: http://www.menugget.blogspot.de/2011/09/converting-values-to-color-levels.html

val2col<-function(z, zlim, col = heat.colors(12), breaks){
  if(!missing(breaks)){
    if(length(breaks) != (length(col)+1)){stop("must have one more break than colour")}
  }
  if(missing(breaks) & !missing(zlim)){
    zlim[2] <- zlim[2]+c(zlim[2]-zlim[1])*(1E-3)#adds a bit to the range in both directions
    zlim[1] <- zlim[1]-c(zlim[2]-zlim[1])*(1E-3)
    breaks <- seq(zlim[1], zlim[2], length.out=(length(col)+1)) 
  }
  if(missing(breaks) & missing(zlim)){
    zlim <- range(z, na.rm=TRUE)
    zlim[2] <- zlim[2]+c(zlim[2]-zlim[1])*(1E-3)#adds a bit to the range in both directions
    zlim[1] <- zlim[1]-c(zlim[2]-zlim[1])*(1E-3)
    breaks <- seq(zlim[1], zlim[2], length.out=(length(col)+1))
  }
  colorlevels <- col[((as.vector(z)-breaks[1])/(range(breaks)[2]-range(breaks)[1]))*(length(breaks)-1)+1] # assign colors to heights for each point
  colorlevels
}


#data
x <- seq(255)
y <- seq(255)
grd <- expand.grid(x=x,y=y)

#assign colors to grd levels
pal1 <- colorRampPalette(c("white", "red"), space = "rgb")
col1 <- val2col(x, col=pal1(255))
pal2 <- colorRampPalette(c("white", "blue"), space = "rgb")
col2 <- val2col(y, col=pal2(255))
col3 <- NA*seq(nrow(grd))
for(i in seq(nrow(grd))){
  xpos <- grd$x[i]
  ypos <- grd$y[i]
  cat(paste('xpos-', xpos, '\n') )
  cat(paste('ypos-', ypos, '\n') )
  coltmp <- (col2rgb(col1[xpos])/2) + (col2rgb(col2[ypos])/2)
  cat(paste('coltmp-', coltmp[1], coltmp[2], coltmp[3], '\n', '\n') ) 
  col3[i] <- rgb(coltmp[1], coltmp[2], coltmp[3], maxColorValue = 255)
}
# head(col3)
#plot
# png("//file/UsersY$/yzh215/Home/Desktop/InteractiveMap/2_color_scales_test.png", width=6, height=4, units="in", res=200)
plot.new()
layout(matrix(c(1,2,3), nrow=1, ncol=3), widths=c(4,1,1), heights=4, respect=T)
par(mar=c(4,4,2,2))
plot(grd,col=col3, pch=19)
