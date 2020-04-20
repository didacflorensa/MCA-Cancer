library("FactoMineR")
library("factoextra")
library('ggplot2')
library(dendextend) 
library(cluster)
library(readr)

source("Scripts/mca-study.R")

#' @details 
#' This CSV is cleaned and contains the following columns PATIENT_ID, AGE_GROUP, POPULATION, CANCER and GENDER
#' * POPULATION is a categorical variable with two values Urban or Rural.
#' * CANCER is a categorical variable with includes a set with the names of the most important cancers.
#' * AGE_GROUP is a categorical variable with ithe a set of age segmentation groups.
#' * GENDER is a categorical variable with gender information Male or Female.

cancer.data=read_csv("../data/private/analisisENG.csv")

cancer.data.analisi = cancer.data[, 3:5]
res.mca3 <- MCA(cancer.data.analisi, graph = FALSE)
fviz_screeplot(res.mca3, addlabels = TRUE)

fviz_mca_ind(res.mca3,label = "none", labelsaddEllipses = TRUE, ellipse.level = 0.9,ggtheme = theme_minimal())

fviz_mca_var(res.mca3, choice = "mca.cor", 
             repel = TRUE, 
             ggtheme = theme_minimal())

fviz_mca_var(res.mca3, col.var = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE, ggtheme = theme_minimal())


#' @details 
#' Here we define the clusters by hand

cancer.data.analisi$group3=as.factor(
  ifelse((cancer.data.analisi$cancer=='Urinary bladder')&(cancer.data.analisi$population=='Urban'),'cloud4',
         ifelse((cancer.data.analisi$population=='Rural') & ((cancer.data.analisi$cancer=='Colon and rectum') | (cancer.data.analisi$cancer=='Prostate')),'cloud3',
                ifelse((cancer.data.analisi$cancer=='Breast')|(cancer.data.analisi$gender=='Female'),'cloud1','cloud2'))))


fviz_mca_ind(res.mca3,
             label = "none",
             habillage =cancer.data.analisi$group3,
             addEllipses = TRUE,ellipse.level = 0.9,
             ggtheme = theme_minimal())


# Compute and visualize the distance matrix


cancer.data.analisi <- na.omit(cancer.data.analisi)
distance <- get_dist(cancer.data.analisi)
fviz_dist(distance, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))

# Compute k-means with k = 5
set.seed(123)
km=data.frame(res.mca3$ind$coord)

k2 <- kmeans(km, centers = 2, nstart = 25)
k3 <- kmeans(km, centers = 3, nstart = 25)
k4 <- kmeans(km, centers = 4, nstart = 25)
k5 <- kmeans(km, centers = 5, nstart = 25)

# plots to compare
p1 <- fviz_cluster(k2, geom = "point", data = km) + ggtitle("k = 2")
p2 <- fviz_cluster(k3, geom = "point",  data = km) + ggtitle("k = 3")
p3 <- fviz_cluster(k4, geom = "point",  data = km) + ggtitle("k = 4")
p4 <- fviz_cluster(k5, geom = "point",  data = km) + ggtitle("k = 5")

library(gridExtra)
grid.arrange(p1, p2, p3, p4, nrow = 2)

# Optimal cluster

set.seed(123)

fviz_nbclust(km, kmeans, method = "wss")

# The best k is the one that maximizes the average silhouette

fviz_nbclust(km, kmeans, method = "silhouette")

# Compute statistic GAP
# compute gap statistic
set.seed(123)
gap_stat <- clusGap(km, FUN = kmeans, nstart = 25,
                    K.max = 10, B = 50)
# Print the result
print(gap_stat, method = "firstmax")




groupes.kmeans <- kmeans(km, centers = 5, nstart = 5)

# Print the results
print(groupes.kmeans)
print(km)

fviz_gap_stat(gap_stat)


# Final

set.seed(123)
final <- kmeans(km, 10, nstart = 25)
print(final)
fviz_cluster(final, data = km)


# Hierarchical Clustering with R
df = data.frame(res.mca3$ind$coord)

df

# Dissimilarity matrix
d <- dist(df, method = "euclidean")

# Hierarchical clustering using Complete Linkage
hc1 <- hclust(d, method = "complete" )

# Plot the obtained dendrogram
plot(hc1, cex = 0.6, hang = -1)



