library(SpiecEasi)
library(igraph)
library(Matrix)
setwd("D:/MNRS")
Dmax<- matrix(0, nrow = 44, ncol = 25)
Dmax_indices<-matrix(0, nrow =44, ncol = 25)
allDmax<-matrix(0, nrow =873, ncol = 25)
data1 <- read.table("D:/MNRS/control.txt", header = TRUE, row.names = 1)
data1_matrix <- as.matrix(data1)
std_control <- apply(data1_matrix, 2, sd)
Dk <- numeric(0)
for (k in 1:25) {
  file_name <- paste("changedata.mb", k, ".txt", sep = "")
  data <- read.table(file_name)
  file_name2 <- paste("E003989_data", k, ".txt", sep = "")
  
  data2 <- read.table(file_name2, header = TRUE)    
  #删除首行
  data2 <- data2[,-1 ]
  
  node_ids <- rownames(data)
  data <- data.frame(apply(data, 2, as.numeric))
  data_matrix <- as.matrix(data)
  
  std_control2 <- apply(data2, 2, sd)
  
  g <- graph_from_adjacency_matrix(1 / data_matrix, weighted=TRUE, mode="undirected")
  
  shortest_paths_matrix <- shortest.paths(g, v=V(g), to=V(g))
  
  result_matrix <- matrix(0, nrow=nrow(data_matrix), ncol=ncol(data_matrix))
  result_matrix[lower.tri(result_matrix)] <- shortest_paths_matrix[lower.tri(shortest_paths_matrix)]
  result_matrix[upper.tri(result_matrix)] <- t(result_matrix)[upper.tri(result_matrix)]
  
  E <- matrix(0, nrow = nrow(result_matrix), ncol = ncol(result_matrix))
  
  for (i in 1:nrow(result_matrix)) {
    for (j in 1:ncol(result_matrix)) {
      if (result_matrix[i, j] != 0) {
        E[i, j] <- 1 / result_matrix[i, j]
      }
    }
  }

  S <- rowSums(data)
  n <- nrow(data)
 
  I<-abs(std_control2-std_control)
  n_rows <- length(I)
  n_cols <- ncol(E)
  
  P <- matrix(0, nrow = n_rows, ncol = n_cols)
  
  for (i in 1:n_rows) {
    P[i, ] <- I[i] * E[i, ]
  }
  col_sums <- colSums(P)
  
  D <- S * col_sums
  
  n <- 873
  index <- 1:n
  
  D_df <- data.frame(Index = index, D = D)
  
  D_df_sorted <- D_df[order(D_df$D, decreasing = TRUE), ]
  percentile_95 <- quantile(D, probs = 0.95)

  selected_values <- D[D >= percentile_95]

  sorted_values <- sort(selected_values, decreasing = TRUE)

  Dm<-mean(D)
  Dk <- c(Dk, Dm)

}
Dkmean<-mean(Dk)


for (k in 1:25) {
  file_name <- paste("changedata.mb", k, ".txt", sep = "")
 
  data <- read.table(file_name)
  #data <- read.table("changedata.mb2.txt", header=TRUE, row.names=1)
  file_name2 <- paste("E003989_data", k, ".txt", sep = "")
  data2 <- read.table(file_name2, header = TRUE)    
 
  data2 <- data2[,-1 ]
  
  node_ids <- rownames(data)
  data <- data.frame(apply(data, 2, as.numeric))
  data_matrix <- as.matrix(data)
 
  
  std_control2 <- apply(data2, 2, sd)
  
  
  g <- graph_from_adjacency_matrix(1 / data_matrix, weighted=TRUE, mode="undirected")
  
  
  shortest_paths_matrix <- shortest.paths(g, v=V(g), to=V(g))
  
  result_matrix <- matrix(0, nrow=nrow(data_matrix), ncol=ncol(data_matrix))
  result_matrix[lower.tri(result_matrix)] <- shortest_paths_matrix[lower.tri(shortest_paths_matrix)]
  result_matrix[upper.tri(result_matrix)] <- t(result_matrix)[upper.tri(result_matrix)]
  E <- matrix(0, nrow = nrow(result_matrix), ncol = ncol(result_matrix))
  
  for (i in 1:nrow(result_matrix)) {
    for (j in 1:ncol(result_matrix)) {
      if (result_matrix[i, j] != 0) {
        E[i, j] <- 1 / result_matrix[i, j]
      }
    }
  }
  
  S <- rowSums(data)
  n <- nrow(data)

  I<-abs(std_control2-std_control)
  
  
  n_rows <- length(I)
  n_cols <- ncol(E)
  P <- matrix(0, nrow = n_rows, ncol = n_cols)
  
  
  for (i in 1:n_rows) {
    P[i, ] <- I[i] * E[i, ]
  }
  col_sums <- colSums(P)
  
  
  D <- S * col_sums
  
  n <- 873
  index <- 1:n
  D
  D_df <- data.frame(Index = index, D = D)
  
  D_df_sorted <- D_df[order(D_df$D, decreasing = TRUE), ]
  sorted_D_desc1<- D_df_sorted[[1]][1:44]
  Dmax_indices[, k] <- sorted_D_desc1
 
  sorted_D_desc2<- D_df_sorted[[2]][1:44]
  
  
  percentile_95 <- quantile(D, probs = 0.95)
  
  selected_values <- D[D >= percentile_95]
  
  sorted_values <- sort(selected_values, decreasing = TRUE)
  
  
  Dm<-mean(D)
  Dk <- c(Dk, Dm)
  
  sorted_values <-sorted_values/Dkmean  
  sorted_D_desc2<-sorted_D_desc2/Dkmean
  allDmax[, k]<-D/Dkmean
  
   
  Dmax_column <- numeric(length(Dmax[, k]))
  
  
  Dmax_column[1:44] <- sorted_D_desc2
  
  
  Dmax_column <- numeric(length(Dmax[, k]))
  
  
  Dmax_column[1:length(sorted_values)] <- sorted_values
  
  
  Dmax[, k] <- Dmax_column
}
Dkmean<-mean(Dk)
Dmean <- colMeans(Dmax)
print(Dmean)
write.table(data.frame(Dmean), 'Dmean.txt', col.names = NA, sep = '\t', quote = FALSE)

