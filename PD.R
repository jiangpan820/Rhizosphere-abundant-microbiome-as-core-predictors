rm(list = ls())
library(treeio)
library(picante)
library(dplyr)

#读取树文件
tree= read.tree("D:/fastTree/16s.nwk")

#读取OTU表格
abunOTU <- read.delim("C:/Users/Acer/Desktop/ex/Abun_BcteriaOTU.txt",row.names = 1)
abunOTU <- as.data.frame(t(abunOTU))
rareOTU <- read.delim("C:/Users/Acer/Desktop/ex/Rare_BcteriaOTU.txt",row.names = 1)
rareOTU <- as.data.frame(t(rareOTU))

#裁剪发育树
phy.tree = prune.sample(abunOTU, tree)
rare.tree <- prune.sample(rareOTU,tree)

#计算PD
abunPD = pd(abunOTU, phy.tree, include.root=F)
rarePD = pd(rareOTU, rare.tree, include.root=F)

#保存文件
abunPD <- abunPD %>% 
  mutate(samples = rownames(abunPD)) %>% 
  write.table(file = "AbunPD.txt", row.names = F, sep = '\t', quote = F)
rarePD <- rarePD %>% 
  mutate(samples = rownames(rarePD)) %>% 
  write.table(file = "RarePD.txt", row.names = F, sep = '\t', quote = F)
  

