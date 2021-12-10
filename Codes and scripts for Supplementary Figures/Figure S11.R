# Libraries
library(ggplot2)


# create a dataset
data <- read.delim('各风险等级箱图.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE,na.strings="na")


# Plot
kmeansplot<-ggplot(data, aes(x=kmeans, y=risk,group=kmeans,color=kmeans)) +
  geom_boxplot(notch=F,notchwidth=0,width =0.6,outlier.color="black") +
  theme(panel.grid = element_blank(), panel.background = element_rect(color = 'black', fill = 'transparent'), legend.key = element_rect(fill = 'transparent'))+
  scale_color_gradient(low = "lightcoral", high = "darkred")+
  xlab("")

equalwidthplot<-ggplot(data, aes(x=equalwidth, y=risk,group=equalwidth,color=equalwidth)) +
  geom_boxplot(notch=F,notchwidth=0,width =0.6,outlier.color="black") +
  theme(panel.grid = element_blank(), panel.background = element_rect(color = 'black', fill = 'transparent'), legend.key = element_rect(fill = 'transparent'))+
  scale_color_gradient(low = "lightcoral", high = "darkred")+
  xlab("")

equalfrequencyplot<-ggplot(data, aes(x=equalfrequency, y=risk,group=equalfrequency,color=equalfrequency)) +
  geom_boxplot(notch=F,notchwidth=0,width =0.6,outlier.color="black") +
  theme(panel.grid = element_blank(), panel.background = element_rect(color = 'black', fill = 'transparent'), legend.key = element_rect(fill = 'transparent'))+
  scale_color_gradient(low = "lightcoral", high = "darkred")+
  xlab("")

merge <- ggpubr::ggarrange(kmeansplot, equalwidthplot, equalfrequencyplot, nrow = 1, ncol = 3, labels = c('a', 'b', 'c'), font.label = list(color = 'black'))

merge
