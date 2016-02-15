## Plot ozone at each location using colors from rainbow.colors
## and differently-sized points.  Add a legend using function
## vertical.image.legend (included in this package).
library(aqfig)
data(ozone1)
col.rng <- rev(rainbow(n=12, start=0, end=4/6))
plot3d.points(x=ozone1$longitude, y=ozone1$latitude, z=ozone1$daily.max,
              xlab="longitude", ylab="latitude", col=col.rng,
              cex.min=0.5, cex.max=1.5)
## To verify, label the points with their concentrations.
text(ozone1$longitude, ozone1$latitude+0.15, ozone1$daily.max, cex=0.7)
## If maps package is available, put on state lines.
if (require("maps"))  map("state", add=TRUE, col="lightgray")
## Put on legend.
vertical.image.legend(col=col.rng, zlim=range(ozone1$daily.max))


plot.new()
vertical.image.legend(col=col.rng, zlim=range(ozone1$daily.max))

plot.new()
col <- colorRampPalette(c("white", "red", "purple", "blue", "white")(67))
vertical.image.legend(col=col, zlim=range(0,67))

t
