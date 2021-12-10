# Libraries
library(tidyverse)
library(hrbrthemes)
library(viridisLite)
library(viridis)
library(ggplot2)
library(dplyr)
library(tidyr)


# create a dataset
data <- read.delim('Figure S6b.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE,na.strings="na")

# Plot
  ggplot(data, aes(x=group, y=HA,group=group)) +
  geom_jitter(size=1, alpha=0.6,width =0.3) +
    theme(panel.grid = element_blank(), panel.background = element_rect(color = 'black', fill = 'transparent'), legend.key = element_rect(fill = 'transparent'))+
    geom_hline(yintercept = 15, color = 'gray', size = 0.3)+
  xlab("")
