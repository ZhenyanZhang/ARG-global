library(ggplot2)
library(ggmap)
#library(sp)
#library(maptools)
#library(maps)
#library(ggpubr)

data <- read.delim('Figure 3g.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE,na.strings="na")
#datas =read.table("suppressive map.txt",header = T, row.names = 1)
mp<-NULL #null map
mapworld<-borders("world",colour = NA,fill="gray") #basic map
mp<-ggplot()+mapworld+ylim(-90,90)+theme(panel.grid = element_blank(), panel.background = element_rect(color = 'black', fill = 'transparent'), legend.key = element_rect(fill = 'transparent'))
mp2<-mp+geom_point(aes(x=data$Longitude,y=data$Latitude,size=data$risk,color=data$habitat),alpha=0.8)+scale_size(range=c(1,15))
mp2
