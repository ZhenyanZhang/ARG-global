
sample<- read.table("P.txt",head = T,row.names=1,sep="\t", quote = "")
p<-sample[,1]

padj<-p.adjust(p,"fdr",n=length(p))
write.csv(p, 'p.csv', quote = F)

