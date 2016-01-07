#Colors selection
library(RColorBrewer)
palCodes <- brewer.pal(numQuan, "Blues")
colPal <- findColours(nclass, palCodes)
legend('bottomright', legend= legendText, title = 'Legend', fill= attr(colPal, 'palette'), bty = 'o')#, pch= 1