library(randomForest)
library(rfPermute)

rm(list = ls())
otu <- read.table("clipboard",header = T,row.names = 1)
colnames(otu)
set.seed(123)
otuforest <- randomForest(TNroot~.,data = otu[,c(2,8:19)],importance = T,ntree = 500)
otuforest
importance_otu.scale <- data.frame(importance(otuforest,scale = T),check.names = F)
importance_otu.scale



##显著性
set.seed(123)
otuforest <- rfPermute(TNroot~.,data = otu[,c(2,8:19)],importance = T,ntree = 500,nrep = 1000,num.cores = 1)


importance_otu.pval <- (otuforest$pval)[,,2]
importance_otu.pval
