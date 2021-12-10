data <- read.delim('Figure S1a.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE,na.strings="na")

# library
library(ggplot2)
library(ggExtra)

# classic plot :
p <- ggplot(data, aes(x=Prevalence, y=Abundance)) +
  geom_point(alpha=0.6) +
  geom_vline(xintercept =0.1, color = 'gray', size = 0.3) +
  geom_vline(xintercept =0.75, color = 'gray', size = 0.3) +
  theme()

# marginal density
p2 <- ggMarginal(p, type="density")
p2
