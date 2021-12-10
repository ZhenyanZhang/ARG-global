library(infotheo)
nbins <- 6
data <- read.delim('riskÔ¤´¦Àí.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE,na.strings="na")
k_means <- kmeans(data$risk, nbins)
table(k_means$cluster)
k_means$cluster
k=data.frame(rank=k_means$cluster,sample=rownames(data),risk=data$risk)
write.csv(as.matrix(k),'k.csv')

equalwidth <- discretize(data$risk,"equalwidth",nbins)
table(equalwidth)
write.csv(as.matrix(equalwidth),'equalwidth.csv')

equalfreq <- discretize(data$risk,"equalfreq",nbins)
table(equalfreq)
write.csv(as.matrix(equalfreq),'equalfreq.csv')
