dat <- expand.grid(blue=seq(0, 100, by=10), red=seq(0, 100, by=10))
dat <- within(dat, mix <- rgb(green=0, red=red, blue=blue, maxColorValue=100))

library(ggplot2)
ggplot(dat, aes(x=red, y=blue)) + 
  geom_tile(aes(fill=mix), color="white") + 
  scale_fill_identity()


