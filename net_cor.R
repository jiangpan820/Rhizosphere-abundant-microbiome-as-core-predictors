library(igraph)
library(psych)
library(WGCNA)

rm(list = ls())
otu <- read.delim("c:/Documents and Settings/Acer/Desktop/11.13微生物数据/Protists(18S)/Abun_ProtistsOTU.txt",row.names = 1)
CorrDF <- function(cormat, pmat) {
  ut <- upper.tri(cormat) # 由于相关性矩阵是对称的，取上三角矩阵计算即可
  data.frame(
    from = rownames(cormat)[col(cormat)[ut]],
    to = rownames(cormat)[row(cormat)[ut]],
    cor = (cormat)[ut],
    p = pmat[ut]
  )
}
occor <- corAndPvalue(t(otu), use='pairwise', method='spearman') # 计算ASV/OTU之间的spearman相关性
cor_df <- CorrDF(occor$cor , occor$p) # 整理ASV之间的连接关系
cor_df <- cor_df[which(abs(cor_df$cor) >= 0.6),] # 保留spearman相关性绝对值>0.6的边
cor_df <- cor_df[which(cor_df$p < 0.05),]
write.table(cor_df,"protists_abun_cor.txt",quote = F,sep = "\t")

