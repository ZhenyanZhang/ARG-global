data <- read.delim('Figure 2K.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE,na.strings="na")

# library
library(ggplot2)
library(ggExtra)

## classic plot 
p <- ggplot(data, aes(x=proportion, y=MGE)) +
    geom_point(alpha=0.6) +
    theme()

# marginal density
p2 <- ggMarginal(p, type="density")
p2
