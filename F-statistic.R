# create a dataset
data <- read.delim('MGE-ARG.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE,na.strings="na")

model<-lm(MGE~ARG,data=data)
summary(model)
