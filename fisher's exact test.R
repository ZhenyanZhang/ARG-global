data <- read.delim('Figure 2e.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE,na.strings="na")

fisher.test(data,simulate.p.value=TRUE)

