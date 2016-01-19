#Some sample data
x <- runif(100)
dat <- data.frame(x = x,y = x^2 + 1)

#Create a function to generate a continuous color palette
rbPal <- colorRampPalette(c('red','blue'))

#This adds a column of color values
# based on the y values
dat$Col <- rbPal(10)[as.numeric(cut(dat$y,breaks = 10))]

head(dat)
plot(dat$x,dat$y,pch = 20,col = dat$Col)

Z <- stats::rnorm(10000)
table(cut(Z, breaks = -6:6))