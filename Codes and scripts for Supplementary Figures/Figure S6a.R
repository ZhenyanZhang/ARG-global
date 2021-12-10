data <- read.delim('Figure S6a.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE,na.strings="na")

# library
library(ggplot2)
library(ggExtra)

# classic plot :
p <- ggplot(data, aes(x=Average_abundance, y=Prevalence)) +
  geom_point(alpha=0.6) +
  geom_hline(yintercept =0.1, color = 'gray', size = 0.3) +
  geom_hline(yintercept =0.75, color = 'gray', size = 0.3) +
  theme()

p
