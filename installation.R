install.packages('devtools', lib='\\\\file/UsersY$/yzh215/Home/Desktop/InteractiveMap/library')
devtools::install_github('rstudio/shinyapps')
devtools::install_github('rstudio/shinyapps', lib='\\\\file/UsersY$/yzh215/Home/Desktop/InteractiveMap/library')
devtools::install_github('rstudio/rsconnect', lib='\\\\file/UsersY$/yzh215/Home/Desktop/InteractiveMap/library')

library(rsconnect)
library(devtools)
require(devtools)
shinyapps::setAccountInfo(name='cococatty',
                          token='BAA55CC8266D6568314316A22101AEEA',
                          secret='<SECRET>')


####################################################################################################


install.packages('devtools', lib='\\\\file/UsersY$/yzh215/Home/My Documents/R/win-library/3.2')
devtools::install_github('rstudio/shinyapps')



install.packages('shiny', lib='\\\\file/UsersY$/yzh215/Home/My Documents/R/win-library/3.2')
devtools::install_github('rstudio/rsconnect', lib='\\\\file/UsersY$/yzh215/Home/My Documents/R/win-library/3.2')
devtools::install_github('rstudio/shinyapps', lib='\\\\file/UsersY$/yzh215/Home/My Documents/R/win-library/3.2')

shinyapps::setAccountInfo(name='cococatty',
                          token='BAA55CC8266D6568314316A22101AEEA',
                          secret='<SECRET>')

library(rsconnect, lib.loc="\\\\file/UsersY$/yzh215/Home/My Documents/R/win-library/3.2")
library(shinyapps, lib.loc="\\\\file/UsersY$/yzh215/Home/My Documents/R/win-library/3.2")
shinyapps::deployApp('path/to/your/app')

lib.loc
.libPaths()
# [1] "\\\\file/UsersY$/yzh215/Home/My Documents/R/win-library/3.2" "C:/Program Files/R/R-3.2.1/library" 
.libPaths(c("\\\\file/UsersY$/yzh215/Home/Desktop/InteractiveMap/library"))

.libloc <<- "C:/Program Files/rest_of_your_Library_FileName"
