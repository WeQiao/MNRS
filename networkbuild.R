library(SpiecEasi)
library(igraph)
library(Matrix)
library(doParallel)
library(foreach)
setwd("D:/MNRS")
data1<-read.table("D:/MNRS/control.txt",header=T,row.names = 1)
data1_matrix<-as.matrix(data1)
se.mb.amgut <- spiec.easi(data1_matrix ,method = 'mb', lambda.min.ratio = 0.01,
                          nlambda = 20, pulsar.params = list(rep.num=50))

adjacency_unweight <- data.frame(as.matrix(se.mb.amgut$refit$stars))
rownames(adjacency_unweight) <- colnames( data1_matrix)
colnames(adjacency_unweight) <- colnames( data1_matrix)
ig.mb <- adj2igraph(getRefit(se.mb.amgut), vertex.attr = list(label = colnames(data1_matrix)))
ig.mb
sebeta <- symBeta(getOptBeta(se.mb.amgut), mode = 'maxabs')
elist.mb <- summary(sebeta)
head(elist.mb)
elist.mb <- data.frame(elist.mb)
class(elist.mb)
names(elist.mb) <- c('source', 'target', 'weight')
elist.mb <- elist.mb[order(elist.mb$source, elist.mb$target), ]
E(ig.mb)
E(ig.mb)$weight <- elist.mb$weight
adjacency_weight <- as.matrix(get.adjacency(ig.mb, attr = 'weight'))
rownames(adjacency_weight) <- colnames(data1_matrix)
colnames(adjacency_weight) <- colnames(data1_matrix)
write.table(data.frame(adjacency_weight), 'adjacency_weight.control.txt', col.names = NA, sep = '\t', quote = FALSE)
edge.mb <- data.frame(as_edgelist(ig.mb))
edge.mb <- data.frame(source = edge.mb[[1]], target = edge.mb[[2]], weight = E(ig.mb)$weight)


data12<-read.table("D:/MNRS/adjacency_weight.control.txt",header=T,row.names = 1)
data12_matrix<-as.matrix(data12)
adjacency_weight<-data12_matrix

for (i in 1:25) {
  file_name <- paste("E003989_data", i, ".txt", sep = "")

  data2 <- read.table(file_name, header = T, row.names = 1)
  results <- list()
  data2_matrix <- as.matrix(data2)
  
  se.mb.amgut2 <- spiec.easi(data2_matrix ,method = 'mb', lambda.min.ratio = 0.01,
                             nlambda = 20, pulsar.params = list(rep.num=50))
  adjacency_unweight2 <- data.frame(as.matrix(se.mb.amgut2$refit$stars))
  rownames(adjacency_unweight2) <- colnames( data2_matrix)
  colnames(adjacency_unweight2) <- colnames( data2_matrix)
  ig.mb2 <- adj2igraph(getRefit(se.mb.amgut2), vertex.attr = list(label = colnames(data2_matrix)))
  ig.mb2
  sebeta2 <- symBeta(getOptBeta(se.mb.amgut2), mode = 'maxabs')
  elist.mb2 <- summary(sebeta2)
  head(elist.mb2)
  elist.mb2 <- data.frame(elist.mb2)
  names(elist.mb2) <- c('source', 'target', 'weight')
  elist.mb2 <- elist.mb2[order(elist.mb2$source, elist.mb2$target), ]
  E(ig.mb2)
  E(ig.mb2)$weight <- elist.mb2$weight
  adjacency_weight2 <- as.matrix(get.adjacency(ig.mb2, attr = 'weight'))
  rownames(adjacency_weight2) <- colnames(data2_matrix)
  colnames(adjacency_weight2) <- colnames(data2_matrix)
  changedata<-abs(adjacency_weight2-adjacency_weight)  
  rownames(adjacency_unweight2) <- colnames( data2_matrix)
  colnames(adjacency_unweight2) <- colnames( data2_matrix)
  file_prefix<-"adjacency_weight.mb"
  file_prefix2<-"changedata.mb"
  write.table(data.frame(adjacency_weight), 'adjacency_weight.mb.txt', col.names = NA, sep = '\t', quote = FALSE)
  file_name <- paste0(file_prefix, i, ".txt")
  file_name2 <- paste0(file_prefix2, i, ".txt")
 # write.table(data.frame(adjacency_weight2),  file_name , col.names = NA, sep = '\t', quote = FALSE)
  write.table(data.frame(changedata),  file_name2 , col.names = NA, sep = '\t', quote = FALSE)
}


