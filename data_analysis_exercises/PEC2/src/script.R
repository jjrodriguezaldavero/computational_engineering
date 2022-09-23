"def num_elementos(etiqueta):
	

def rebalancear(datos, clusters):
	for i in (datos):
		etiqueta = datos[i][1]
		si num_elementos(etiqueta) > 15:
			distancias_a_clusters = []
			for j in (clusters):
				etiqueta_cluster = clusters[j][1]
				si num_elementos(etiqueta_cluster) < 10:
					distancias_a_clusters.append(distancia(datos[i], clusters[j])) #hacer que sea diccionario con la etiqueta como clave
			datos[i][1] = #etiqueta del diccionario con menor distancia"

rebalancear_datos <- function(datos, clusters, df_etiquetas, cardinalidad) {
	for (i in 1:nrow(datos)) {
	  tabla <- data.frame(table(df_etiquetas))
	  print(i)
		etiqueta <- datos[i,]$etiquetas
		if (tabla[etiqueta,][2] > cardinalidad) {
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

