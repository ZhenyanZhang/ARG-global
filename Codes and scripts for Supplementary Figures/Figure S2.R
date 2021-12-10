library(ggplot2)

data <- read.delim('ARG_absolutelatitude.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE)




Aquatic<-subset(data,habitat=="Aquatic")
lmpAquatic <- lm(abundance~poly(absolutelatitude,2),data = Aquatic)
summary(lmpAquatic)
polylmpAquatic <- predict(lmpAquatic,Aquatic)
Aquatic$polylmpAquatic <- polylmpAquatic
plotAquatic<- ggplot(Aquatic,aes(x=absolutelatitude,y = abundance,group = habitat,color=absolutelatitude))+
  scale_color_gradientn(colours = c("red", "yellow", "green", "blue"),limits=c(0,85))+
  geom_point(size=3,alpha=0.6)+
  theme(panel.grid = element_blank(), panel.background = element_rect(color = 'black', fill = 'transparent'), legend.key = element_rect(fill = 'transparent'))+
  scale_x_continuous(limits=c(0,85))+
  geom_line(aes(x = absolutelatitude,y = polylmpAquatic),size =1.2,color='black')+
  annotate('text', label = 'R2=0.0075,P<0.001,n=1630', x = 20, y = 600, size = 5, colour = 'black')+
  annotate('text', label = 'Aquatic', x = 20, y = 610, size = 5, colour = 'black')
plotAquatic

Built <-subset(data,habitat=="Engineered")
lmpBuilt <- lm(abundance~poly(absolutelatitude,2),data = Built)
summary(lmpBuilt)
polylmpBuilt <- predict(lmpBuilt,Built)
Built$polylmpBuilt <- polylmpBuilt
plotBuilt<- ggplot(Built,aes(x=absolutelatitude,y = abundance,group = habitat,color=absolutelatitude))+
  scale_color_gradientn(colours = c("red", "yellow", "green", "blue"),limits=c(0,85))+
  geom_point(size=3,alpha=0.6)+
  scale_x_continuous(limits=c(0,85))+
  theme(panel.grid = element_blank(), panel.background = element_rect(color = 'black', fill = 'transparent'), legend.key = element_rect(fill = 'transparent'))+
  geom_line(aes(x = absolutelatitude,y = polylmpBuilt),size =1.2,color='black')+
  annotate('text', label = 'R2=0.0647,P<0.001,n=1146', x = 20, y = 600, size = 5, colour = 'black')+
  annotate('text', label = 'Engineered', x = 20, y = 610, size = 5, colour = 'black')
plotBuilt

Human <-subset(data,habitat=="Human")
lmpHuman <- lm(abundance~poly(absolutelatitude,2),data = Human)
summary(lmpHuman)
polylmpHuman <- predict(lmpHuman,Human)
Human$polylmpHuman <- polylmpHuman
plotHuman<- ggplot(Human,aes(x=absolutelatitude,y = abundance,group = habitat,color=absolutelatitude))+
  scale_color_gradientn(colours = c("red", "yellow", "green", "blue"),limits=c(0,85))+
  geom_point(size=3,alpha=0.6)+
  scale_x_continuous(limits=c(0,85))+
  theme(panel.grid = element_blank(), panel.background = element_rect(color = 'black', fill = 'transparent'), legend.key = element_rect(fill = 'transparent'))+
  geom_line(aes(x = absolutelatitude,y = polylmpHuman),size =1.2,color='black')+
  annotate('text', label = 'R2=0.0169,P<0.001,n=814', x = 20, y = 600, size = 5, colour = 'black')+
  annotate('text', label = 'Human', x = 20, y = 610, size = 5, colour = 'black')
plotHuman

Terrestrial <-subset(data,habitat=="Terrestrial")
lmpTerrestrial <- lm(abundance~poly(absolutelatitude,2),data = Terrestrial)
summary(lmpTerrestrial)
polylmpTerrestrial <- predict(lmpTerrestrial,Terrestrial)
Terrestrial$polylmpTerrestrial <- polylmpTerrestrial
plotTerrestrial<- ggplot(Terrestrial,aes(x=absolutelatitude,y = abundance,group = habitat,color=absolutelatitude))+
  scale_color_gradientn(colours = c("red", "yellow", "green", "blue"),limits=c(0,85))+
  geom_point(size=3,alpha=0.6)+
  scale_x_continuous(limits=c(0,85))+
  theme(panel.grid = element_blank(), panel.background = element_rect(color = 'black', fill = 'transparent'), legend.key = element_rect(fill = 'transparent'))+
  geom_line(aes(x = absolutelatitude,y = polylmpTerrestrial),size =1.2,color='black')+
  annotate('text', label = 'R2=0.0195,P=0.011,n=362', x = 20, y = 600, size = 5, colour = 'black')+
  annotate('text', label = 'Terrestrial', x = 20, y = 610, size = 5, colour = 'black')
plotTerrestrial

p <- ggpubr::ggarrange(plotAquatic, plotTerrestrial, plotBuilt, plotHuman, nrow = 2, ncol = 2)

p

