## Install necessary packages
install.packages("devtools")
library("devtools")
install.packages("ggvis")
install.packages("googleVis")
install_github("ramnathv/rCharts")
install_github("ropensci/plotly")
install.packages("dplyr")
install.packages("tidyr")
install.packages("knitr")
# Load packages
library("ggvis")
library("googleVis")
library("rCharts")
library("plotly")
library("dplyr")
library("tidyr")
library("knitr")
# Define image sizes
img.width <- 450
img.height <- 300
options(RCHART_HEIGHT = img.height, RCHART_WIDTH = img.width)
opts_chunk$set(fig.width=6, fig.height=4)


# Plotly requires authentication
py <- plotly("RgraphingAPI", "ektgzomjbx")


# Use mtcars data
data(mtcars)
mtcars$cyl <- factor(mtcars$cyl)
mtcars$am <- factor(mtcars$am)
# Compute mean mpg per cyl and am
mtcars.mean <- mtcars %>% group_by(cyl, am) %>% 
  summarise(mpg_mean=mean(mpg)) %>% 
  select(cyl, am, mpg_mean) %>% ungroup()


scatter.ggplot <- ggplot(mtcars, aes(x=wt, y=mpg, colour=cyl)) + geom_point()
scatter.ggplot



scatter.ggvis <- mtcars %>% ggvis(x = ~wt, y = ~mpg, fill = ~cyl) %>% 
  layer_points() %>% set_options(width = img.width, height = img.height)
scatter.ggvis



#scatter.rcharts <- rPlot(mpg ~ wt, data = mtcars, color = 'cyl', type = 'point')
# WTF, legend shows 4-7, while the levels are 4,6,8???
# very tight limits, parts of points missing on the edge
# Use this with 'Knit HTML' button
# scatter.rcharts$print(include_assets=TRUE)
# Use this with jekyll blog
#scatter.rcharts$show('iframesrc', cdn=TRUE)



# This works, but is not evaluated now. Instead the iframe is embedded manually.
#py$ggplotly(scatter.ggplot, session="knitr")




# Spread data to show the wanted scatter plot (unique id required for unique rows)
mtcars$id <- as.character(1:nrow(mtcars))
mtcars.temp <- tidyr::spread(mtcars[c("wt", "mpg", "cyl", "id")], key=cyl, value=mpg)
gvis.options <- list(hAxis="{title:'wt'}", vAxis="{title:'mpg'}",
                     width=img.width, height=img.height)
scatter.gvis <- gvisScatterChart(select(mtcars.temp, -id), options=gvis.options)
print(scatter.gvis, tag="chart")