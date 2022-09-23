cardinalidad <- 25
n_grupos <- round(1080 / cardinalidad) 

rebalancear_datos <- function(datos, clusters, df_etiquetas, cardinalidad) {
  for (i in 1:nrow(datos)) {
    tabla <- data.frame(table(df_etiquetas))
    etiqueta <- datos[i,]$etiquetas
    if (tabla[etiqueta,][2] > cardinalidad + 5) {
      distancias_a_clusters <- data.frame(distancia=double(nrow(clusters)), etiqueta=integer(nrow(clusters)))
      for (j in 1:nrow(clusters)) {
        etiqueta_cluster <- clusters[j,]$etiquetas				
        if (tabla[etiqueta_cluster,][2] < cardinalidad) {
          distancias_a_clusters$distancia[j] <- sqrt(sum((datos[i,] - clusters[j,])^2))
          distancias_a_clusters$etiqueta[j] <- etiqueta_cluster
        }
      }
      distancias_a_clusters <- distancias_a_clusters[distancias_a_clusters$etiqueta != 0,]
      datos[i,]$etiquetas <- distancias_a_clusters[which.min(distancias_a_clusters$distancia),]$etiqueta
      df_etiquetas[i,] <- distancias_a_clusters[which.min(distancias_a_clusters$distancia),]$etiqueta
      
    } 
  }
  return(datos)
}


AM20 <- scale(AM20)

library(dplyr)
kmeans.modelo <- kmeans(AM20, n_grupos)
kmeans.etiquetas <- data.frame(kmeans.modelo$cluster)
names(kmeans.etiquetas)[1] <- "etiquetas"
kmeans.centroides <- data.frame(kmeans.modelo$centers) %>% mutate(etiquetas = row_number())
kmeans.AM20 <- left_join(kmeans.etiquetas, kmeans.centroides, by="etiquetas")
kmeans.AM20.balanced <- rebalancear_datos(kmeans.AM20, kmeans.centroides, kmeans.etiquetas, cardinalidad)
kmeans.IL<- sum((AM20 - subset(kmeans.AM20.balanced, select = -c(etiquetas)))^2)

library(stats)
D <- dist(AM20, method="euclidean")
jerarq.modelo <- hclust(D, method = "ward.D")
jerarq.etiquetas <- data.frame(cutree(jerarq.modelo, k=n_grupos))
names(jerarq.etiquetas)[1] <- "etiquetas"
jerarq.centroides <- data.frame(apply(AM20, 2, function (x) tapply (x, jerarq.etiquetas, mean)))%>% mutate(etiquetas = row_number())
jerarq.AM20 <- left_join(jerarq.etiquetas, jerarq.centroides, by="etiquetas")
jerarq.AM20.balanced <- rebalancear_datos(jerarq.AM20, jerarq.centroides, jerarq.etiquetas, cardinalidad)
jerarq.IL <- sum((AM20 - subset(jerarq.AM20.balanced, select = -c(etiquetas)))^2)

library(mclust)
gauss.modelo <- Mclust(AM20, G=n_grupos)
gauss.etiquetas <- data.frame(gauss.modelo$classification)
names(gauss.etiquetas)[1] <- "etiquetas"
gauss.centroides <-  data.frame(apply(AM20, 2, function (x) tapply (x, gauss.etiquetas, mean)))%>% mutate(etiquetas = row_number())
gauss.AM20 <- left_join(gauss.etiquetas, gauss.centroides, by="etiquetas")
gauss.AM20.balanced <- rebalancear_datos(gauss.AM20, gauss.centroides, gauss.etiquetas, cardinalidad)
gauss.IL <- sum((AM20 - subset(gauss.AM20.balanced, select = -c(etiquetas)))^2)

values = c(kmeans.IL, jerarq.IL, gauss.IL)
print(values)
