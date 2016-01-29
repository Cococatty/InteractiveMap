# This script is used for testing new method

# The following is for "selecting the cell and information shall be displayed on the RHS

travelMeans <- c('02', '04')
test <- prepareTwoMeans(travelMeans)
head(test[1:6,])
#attributes(test) 

dat <- expand.grid(blue=seq(255, 0, by=10), red=seq(255, 0, by=10))


# 1. NEED TO FIX THE 0,0 SAME AS 2.
dat <- expand.grid(blue=seq(255, 0, by=-10), red=seq(255, 0, by=-10))
dat <- within(dat, mix <- rgb(green=0, red=red, blue=blue, maxColorValue=255))
library(ggplot2)
ggplot(dat, aes(x=red, y=blue)) + 
  geom_tile(aes(fill=mix)) + 
  scale_fill_identity()

head(dat)

dat(dat[red==0 && blue==0,])

dat[dat$red==1,]


# 2. NEED TO FIX THE 0,0 SAME AS 1.
dat <- expand.grid(blue=seq(0, 255, by=10), red=seq(0, 255, by=10))
dat <- within(dat, mix <- rgb(green=0, red=red, blue=blue, maxColorValue=255))

library(ggplot2)
ggplot(dat, aes(x=red, y=blue)) + 
  geom_tile(aes(fill=mix)) + 
  scale_fill_identity()


# 3. NEED TO FIX THE 0,0 SAME AS 2.
dat <- expand.grid(blue=seq(255, 0, by=-10), red=seq(255, 0, by=-10))
dat <- within(dat, mix <- rgb(green=0, red=rev(red), blue=rev(blue), maxColorValue=255))
library(ggplot2)
ggplot(dat, aes(x=red, y=blue)) + 
  geom_tile(aes(fill=mix)) + 
  scale_fill_identity()
