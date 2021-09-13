library(ggplot2)
library(ggmap)

wd<- "D:/OneDrive/Global"
setwd(wd)

data <- read.delim('riskmap.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE,na.strings="na")

mpc<-NULL #map without data
mapworld<-borders("world",colour = NA,fill="gray") #basical map
mpc<-ggplot()+mapworld+ylim(-90,90)+theme(panel.grid = element_blank(), panel.background = element_rect(color = 'black', fill = 'transparent'), legend.key = element_rect(fill = 'transparent'))
mpc2<-mpc+geom_point(aes(x=datac$LONGITUDE,y=datac$LATITUDE,size=datac$risk,color=datac$ecosystem),alpha=0.8)+scale_size(range=c(1,15))
mpc2
