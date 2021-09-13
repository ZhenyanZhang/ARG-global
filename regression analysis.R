wd<- "D:/onedrive/Data"
setwd(wd)

library(ggplot2)

data <- read.delim('lat.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE)

Aquatic<-subset(data,group=="Aquatic")
lmpAquatic <- lm(abundance~poly(absolutelatitude,2),data = Aquatic)#2 for Binomial regression and 1 for linear regression
summary(lmpAquatic)
polylmpAquatic <- predict(lmpAquatic,Aquatic)
Aquatic$polylmpAquatic <- polylmpAquatic
plotAquatic<- ggplot(Aquatic,aes(x=absolutelatitude,y = abundance,group = group,color=absolutelatitude))+
  scale_color_gradientn(colours = c("red", "yellow", "green", "blue"),limits=c(0,85))+
  geom_point(size=3,alpha=0.6)+
  theme(panel.grid = element_blank(), panel.background = element_rect(color = 'black', fill = 'transparent'), legend.key = element_rect(fill = 'transparent'))+
  scale_x_continuous(limits=c(0,85))+
  geom_line(aes(x = absolutelatitude,y = polylmpAquatic),size =1.2,color='black')+
  annotate('text', label = 'R2=0.0002,P=0.849,n=1808,df=1805', x = 20, y = 600, size = 5, colour = 'black')+#Results of regression calculated as "summary(lmpAquatic)"
  annotate('text', label = 'Aquatic', x = 20, y = 610, size = 5, colour = 'black')
plotAquatic

Built <-subset(data,group=="Built environment")
lmpBuilt <- lm(abundance~poly(absolutelatitude,2),data = Built)
summary(lmpBuilt)
polylmpBuilt <- predict(lmpBuilt,Built)
Built$polylmpBuilt <- polylmpBuilt
plotBuilt<- ggplot(Built,aes(x=absolutelatitude,y = abundance,group = group,color=absolutelatitude))+
  scale_color_gradientn(colours = c("red", "yellow", "green", "blue"),limits=c(0,85))+
  geom_point(size=3,alpha=0.6)+
  scale_x_continuous(limits=c(0,85))+
  theme(panel.grid = element_blank(), panel.background = element_rect(color = 'black', fill = 'transparent'), legend.key = element_rect(fill = 'transparent'))+
  geom_line(aes(x = absolutelatitude,y = polylmpBuilt),size =1.2,color='black')+
  annotate('text', label = 'R2=0.0047,P=0.119,n=899,df=896', x = 20, y = 600, size = 5, colour = 'black')+
  annotate('text', label = 'Built', x = 20, y = 610, size = 5, colour = 'black')
plotBuilt

Human <-subset(data,group=="Human")
lmpHuman <- lm(abundance~poly(absolutelatitude,2),data = Human)
summary(lmpHuman)
polylmpHuman <- predict(lmpHuman,Human)
Human$polylmpHuman <- polylmpHuman
plotHuman<- ggplot(Human,aes(x=absolutelatitude,y = abundance,group = group,color=absolutelatitude))+
  scale_color_gradientn(colours = c("red", "yellow", "green", "blue"),limits=c(0,85))+
  geom_point(size=3,alpha=0.6)+
  scale_x_continuous(limits=c(0,85))+
  theme(panel.grid = element_blank(), panel.background = element_rect(color = 'black', fill = 'transparent'), legend.key = element_rect(fill = 'transparent'))+
  geom_line(aes(x = absolutelatitude,y = polylmpHuman),size =1.2,color='black')+
  annotate('text', label = 'R2=0.0417,P=4.025e-10,n=1020,df=1017', x = 20, y = 600, size = 5, colour = 'black')+
  annotate('text', label = 'Human', x = 20, y = 610, size = 5, colour = 'black')
plotHuman

Terrestrial <-subset(data,group=="Terrestrial")
lmpTerrestrial <- lm(abundance~poly(absolutelatitude,2),data = Terrestrial)
summary(lmpTerrestrial)
polylmpTerrestrial <- predict(lmpTerrestrial,Terrestrial)
Terrestrial$polylmpTerrestrial <- polylmpTerrestrial
plotTerrestrial<- ggplot(Terrestrial,aes(x=absolutelatitude,y = abundance,group = group,color=absolutelatitude))+
  scale_color_gradientn(colours = c("red", "yellow", "green", "blue"),limits=c(0,85))+
  geom_point(size=3,alpha=0.6)+
  scale_x_continuous(limits=c(0,85))+
  theme(panel.grid = element_blank(), panel.background = element_rect(color = 'black', fill = 'transparent'), legend.key = element_rect(fill = 'transparent'))+
  geom_line(aes(x = absolutelatitude,y = polylmpTerrestrial),size =1.2,color='black')+
  annotate('text', label = 'R2=0.0243,P=0.001,n=552,df=549', x = 20, y = 600, size = 5, colour = 'black')+
  annotate('text', label = 'Terrestrial', x = 20, y = 610, size = 5, colour = 'black')
plotTerrestrial

pmerge <- ggpubr::ggarrange(plotAquatic, plotTerrestrial, plotBuilt, plotHuman, nrow = 2, ncol = 2, labels = c('A', 'B', 'C', 'D'), font.label = list(color = 'red'))

pmerge

