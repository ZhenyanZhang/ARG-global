library(statnet)
library(circlize)

data <- read.delim('FigureS4.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE)
my.data<-as.matrix(data) 
grid.col = NULL
circos.par(gap.degree = c(rep(2, nrow(my.data)-1), 10, rep(2, ncol(my.data)-1), 10),start.degree = 90)
chordDiagram(my.data,directional = TRUE,diffHeight = 0.006,grid.col = grid.col,transparency = 0.6) 
legend("right",pch=20,legend=colnames(my.data),col=grid.col[colnames(my.data)],bty="n",cex=1,pt.cex=3,border="black") 
