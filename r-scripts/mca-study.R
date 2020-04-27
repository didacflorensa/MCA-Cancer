#' MCA Study
#' 
#' Study to understand the relations between rural and urban 
#' areas with the cancer.
#'
#' The Multiple correspondence analysis (MCA) is an extension of the simple correspondence analysis (chapter @ref(correspondence-analysis)) 
# for summarizing and visualizing a data table containing more than two categorical variables. It can also be seen as a generalization of 
# principal component analysis when the variables to be analyzed are categorical instead of quantitative (Abdi and Williams 2010).
#'


library("FactoMineR")
library("factoextra")
library('ggplot2')
library(readr)

source("Scripts/mca-study.R")

#' @details 
#' This CSV is cleaned and contains the following columns PATIENT_ID, AGE_GROUP, POPULATION, CANCER and GENDER
#' * POPULATION is a categorical variable with two values Urban or Rural.
#' * CANCER is a categorical variable with includes a set with the names of the most important cancers.
#' * AGE_GROUP is a categorical variable with ithe a set of age segmentation groups.
#' * GENDER is a categorical variable with gender information Male or Female.

cancer.data=read_csv("Desktop/MCA-Cancer/data/private/analisisENG.csv")
summary(cancer.data)

head(cancer.data)


#' Study 1. Check MCA with AGE_GROUP, POPULATION, CANCER and GENDER
#'
cancer.data.analisi = cancer.data[, 2:5]
res.mca1 <- MCA(cancer.data.analisi, graph = FALSE)
fviz_screeplot(res.mca1, addlabels = TRUE)
fviz_mca_var(res.mca1, choice = "mca.cor", 
             repel = TRUE, 
             ggtheme = theme_minimal())


fviz_mca_var(res.mca1, choice = "mca.cor", 
             repel = TRUE, # Avoid text overlapping (slow)
             ggtheme = theme_minimal())

fviz_mca_var(res.mca1, 
             repel = TRUE, # Avoid text overlapping (slow)
             ggtheme = theme_minimal())

fviz_mca_var(res.mca1, col.var="black", shape.var = 15,
             repel = TRUE)

fviz_cos2(res.mca1, choice = "var", axes = 1:2)

fviz_mca_var(res.mca1, col.var = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE, # Avoid text overlapping
             ggtheme = theme_minimal())

fviz_mca_var(res.mca1, alpha.var="cos2",
             repel = TRUE,
             ggtheme = theme_minimal())

# Total contribution to dimension 1 and 2
fviz_contrib(res.mca1, choice = "var", axes = 1:2, top = 15)

fviz_mca_var(res.mca1, col.var = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE, # avoid text overlapping (slow)
             ggtheme = theme_minimal())

# Change the transparency by contrib values
fviz_mca_var(res.mca1, alpha.var="contrib",
             repel = TRUE,
             ggtheme = theme_minimal())


fviz_mca_ind(res.mca1, col.ind = "cos2", 
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE, # Avoid text overlapping (slow if many points)
             ggtheme = theme_minimal())

fviz_mca_ind(res.mca1, 
             label = "none", # hide individual labels
             habillage = "cancer", # color by groups 
             palette = c("#00AFBB", "#E7B800", "#FC4E07", "#008000", "#DA70D6"),
             addEllipses = TRUE, ellipse.type = "confidence",
             ggtheme = theme_minimal()) 

# habillage = index of the column to be used as grouping variable
fviz_mca_ind(res.mca1, habillage = 2, addEllipses = TRUE)

fviz_ellipses(res.mca1, c("cancer", "population"),
              geom = "point")

fviz_ellipses(res.mca1, 1:4, geom = "point")
# head(eig.val)

#' Study 2. Check MCA with AGE_GROUP, POPULATION, CANCER
#'
cancer.data.analisi = cancer.data[, 2:4]
res.mca2 <- MCA(cancer.data.analisi, graph = FALSE)
fviz_screeplot(res.mca2, addlabels = TRUE)

fviz_mca_var(res.mca2, choice = "mca.cor", 
             repel = TRUE, 
             ggtheme = theme_minimal())

fviz_mca_var(res.mca2, choice = "mca.cor", 
             repel = TRUE, # Avoid text overlapping (slow)
             ggtheme = theme_minimal())

fviz_mca_var(res.mca2, 
             repel = TRUE, # Avoid text overlapping (slow)
             ggtheme = theme_minimal())

fviz_mca_var(res.mca2, col.var="black", shape.var = 15,
             repel = TRUE)

fviz_cos2(res.mca2, choice = "var", axes = 1:2)

fviz_mca_var(res.mca2, col.var = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE, # Avoid text overlapping
             ggtheme = theme_minimal())

fviz_mca_var(res.mca2, alpha.var="cos2",
             repel = TRUE,
             ggtheme = theme_minimal())

# Total contribution to dimension 1 and 2
fviz_contrib(res.mca2, choice = "var", axes = 1:2, top = 15)

fviz_mca_var(res.mca2, col.var = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE, # avoid text overlapping (slow)
             ggtheme = theme_minimal())

# Change the transparency by contrib values
fviz_mca_var(res.mca2, alpha.var="contrib",
             repel = TRUE,
             ggtheme = theme_minimal())


fviz_mca_ind(res.mca2, col.ind = "cos2", 
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE, # Avoid text overlapping (slow if many points)
             ggtheme = theme_minimal())

fviz_mca_ind(res.mca2, 
             label = "none", # hide individual labels
             habillage = "cancer", # color by groups 
             palette = c("#00AFBB", "#E7B800", "#FC4E07", "#008000", "#DA70D6"),
             addEllipses = TRUE, ellipse.type = "confidence",
             ggtheme = theme_minimal()) 

# habillage = index of the column to be used as grouping variable
fviz_mca_ind(res.mca2, habillage = 2, addEllipses = TRUE)

fviz_ellipses(res.mca2, c("cancer", "population"),
              geom = "point")

fviz_ellipses(res.mca2, 1:4, geom = "point")
# head(eig.val)

#' Study 3. Check MCA with POPULATION, CANCER and GENDER
#'
cancer.data.analisi = cancer.data[, 3:5]
res.mca3 <- MCA(cancer.data.analisi, graph = FALSE)
fviz_screeplot(res.mca3, addlabels = TRUE)
summary(res.mca3)

fviz_mca_ind(res.mca3,label = "none", labelsaddEllipses = TRUE, ellipse.level = 0.9,ggtheme = theme_minimal())

fviz_mca_var(res.mca3, choice = "mca.cor", 
             repel = TRUE, 
             ggtheme = theme_minimal())

fviz_mca_var(res.mca3, col.var = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE, ggtheme = theme_minimal())

#The contribution of every category in the dimension 1
fviz_contrib(res.mca3, choice = "var", axes = 1, top = 20,
             palette = "jco")

#The contribution of every category in the dimension 2
fviz_contrib(res.mca3, choice = "var", axes = 2, top = 20,
             palette = "jco")


fviz_mca_var(res.mca3, 
             repel = TRUE, # Avoid text overlapping (slow)
             ggtheme = theme_minimal())

fviz_mca_var(res.mca3, col.var="black", shape.var = 15,
             repel = TRUE)

fviz_cos2(res.mca3, choice = "var", axes = 1:2)

fviz_mca_var(res.mca3, col.var = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE, # Avoid text overlapping
             ggtheme = theme_minimal())

fviz_mca_var(res.mca3, alpha.var="cos2",
             repel = TRUE,
             ggtheme = theme_minimal())

# Total contribution to dimension 1 and 2
fviz_contrib(res.mca3, choice = "var", axes = 1:2, top = 15)

fviz_mca_var(res.mca3, col.var = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE, # avoid text overlapping (slow)
             ggtheme = theme_minimal())

# Change the transparency by contrib values
fviz_mca_var(res.mca3, alpha.var="contrib",
             repel = TRUE,
             ggtheme = theme_minimal())


fviz_mca_ind(res.mca3, col.ind = "cos2", 
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE, # Avoid text overlapping (slow if many points)
             ggtheme = theme_minimal())

fviz_mca_ind(res.mca3, 
             label = "none", # hide individual labels
             habillage = "cancer", # color by groups 
             palette = c("#00AFBB", "#E7B800", "#FC4E07", "#008000", "#DA70D6"),
             addEllipses = TRUE, ellipse.type = "confidence",
             ggtheme = theme_minimal()) 

# habillage = index of the column to be used as grouping variable
fviz_mca_ind(res.mca3, habillage = 2, addEllipses = TRUE)

fviz_ellipses(res.mca3, c("cancer", "population"),
              geom = "point")

fviz_ellipses(res.mca3, 1:4, geom = "point")
# head(eig.val)

# Here we calculare the distances between points
calculateDistance <- function(x1, y1, x2, y2) {
  result <- sqrt( ((x2-x1)^2) + ((y2-y1))^2)
  return(result)
}

categories <- c("Rural", "Urban", "Breast", "Colon and rectum", "Lung", 
              "Prostate", "Urinary bladder", "Female", "Male")
i_dim2 = 10
initial = 1

distance_vector <- c()

for (i in 1:8) {
  initial = initial + 1
  dim2_j = 9 + initial
  
  for (j in initial:9) {
    distance <- calculateDistance(res.mca3$var$coord[i], res.mca3$var$coord[i_dim2], 
                res.mca3$var$coord[j], res.mca3$var$coord[dim2_j])
    dim2_j = dim2_j + 1
    distance_vector <- c(distance_vector, distance)
  }
}

print(distance_vector)
# var <- get_mca_var(res.mca3)
# print(var)
# head(var$coord) # coordinates of variables
# head(var$cos2) # cos2 of variables
# head(var$contrib) # contributions of variables
# get_mca_ind(res.mca3, "Urban")

#' @details 
#' Here we define the clusters by hand

cancer.data.analisi$group3=as.factor(
         ifelse((cancer.data.analisi$cancer=='Urinary bladder')&(cancer.data.analisi$population=='Urban'),'cloud4',
         ifelse((cancer.data.analisi$population=='Rural') & ((cancer.data.analisi$cancer=='Colon and rectum') | (cancer.data.analisi$cancer=='Prostate')),'cloud3',
         ifelse((cancer.data.analisi$cancer=='Breast')|(cancer.data.analisi$gender=='Female'),'cloud1','cloud2'))))


fviz_mca_ind(res.mca3,
             label = "none", # hide individual labels
             habillage =cancer.data.analisi$group3, # color by groups 
             #palette = c("#00AFBB", "#E7B800"),
             addEllipses = TRUE,ellipse.level = 0.9,
             ggtheme = theme_minimal())




#'-----------------------------------------------Study 1 - Colon and rectum ---------------------------------------------------------------------#
#' Study 5. Check MFA with AGE_GROUP(categorical variable) and GENDER are a group, POPULATION as categorical group, and CANCER as categorical group
#' 
#' +
#'

cancer.data=read_csv("Desktop/MCA-Cancer/data/private/analisi-colonrecte.csv")
summary(cancer.data)

head(cancer.data)
cancer.data.analisi = cancer.data[, 2:5]
res.mca.colon <- MCA(cancer.data.analisi, graph = FALSE)
fviz_screeplot(res.mca.colon, addlabels = TRUE)

fviz_mca_ind(res.mca.colon,label = "none", labelsaddEllipses = TRUE, ellipse.level = 0.9,ggtheme = theme_minimal())

fviz_mca_var(res.mca.colon, choice = "mca.cor", 
             repel = TRUE, 
             ggtheme = theme_minimal())

fviz_mca_var(res.mca.colon, col.var = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE, ggtheme = theme_minimal())





#'-----------------------------------------------Study 5 - Colon and rectum ---------------------------------------------------------------------#
#' Study 5. Check MFA with AGE_GROUP(categorical variable) and GENDER are a group, POPULATION as categorical group, and CANCER as categorical group
#' 
#' +
#'

cancer.data=read_csv("Desktop/MCA-Cancer/data/private/analisi-colonrecte2.csv")
summary(cancer.data)

head(cancer.data)
cancer.data.analisi = cancer.data[, 2:4]
res.mca.colon <- MCA(cancer.data.analisi, graph = FALSE)

fviz_screeplot(res.mca.colon, addlabels = TRUE)

fviz_mca_var(res.mca.colon, choice = "mca.cor", 
             repel = TRUE, 
             ggtheme = theme_minimal())

#Correlation between variables
fviz_famd_var(res.mca.colon, repel = TRUE)

#Percentage of explained variances - dimensions
fviz_screeplot(res.mca.colon, addlabels = TRUE)

# Contribution to the first dimension
fviz_contrib(res.mca.colon, "var", axes = 1)

# Contribution to the second dimension
fviz_contrib(res.mca.colon, "var", axes = 2)

fviz_mca_var(res.mca.colon, col.var = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE, ggtheme = theme_minimal())


#The contribution of every category in the dimension 1
fviz_contrib(res.mca.colon, choice = "quali.var", axes = 1, top = 20,
             palette = "jco")

#'-----------------------------------------------End Study 5 - Colon and rectum ---------------------------------------------------------------------#

#Graph of individuals
#plot(res.famd, choix = "ind")



#'-----------------------------------------------Study 6 - Lung ---------------------------------------------------------------------#
#' Study 5. Check MCA with AGE_GROUP(categorical variable) and GENDER and POPULATION
#' 
#' +
#'

cancer.data=read_csv("Desktop/MCA-Cancer/data/private/analisi-pulmo2.csv")
summary(cancer.data)

head(cancer.data)
cancer.data.analisi = cancer.data[, 2:4]
res.mca.pulmo <- MCA(cancer.data.analisi, graph = FALSE)

#Percentage of explained variances - dimensions
fviz_screeplot(res.mca.pulmo, addlabels = TRUE)

fviz_mca_var(res.mca.pulmo, choice = "mca.cor", 
             repel = TRUE, 
             ggtheme = theme_minimal())

#Correlation between variables
fviz_famd_var(res.mca.pulmo, repel = TRUE)

# Contribution to the first dimension
fviz_contrib(res.mca.pulmo, "var", axes = 1)

# Contribution to the second dimension
fviz_contrib(res.mca.pulmo, "var", axes = 2)

fviz_mca_var(res.mca.pulmo, col.var = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE, ggtheme = theme_minimal())


#'-----------------------------------------------End Study 6 - Lung ---------------------------------------------------------------------#


#'-----------------------------------------------Study 7 - Urinary Bladder ---------------------------------------------------------------------#
#' Study 7. Check MCA with AGE_GROUP(categorical variable) and GENDER and POPULATION
#' 
#' +
#'

cancer.data=read_csv("Desktop/MCA-Cancer/data/private/analisi-bufeta2.csv")
summary(cancer.data)

head(cancer.data)
cancer.data.analisi = cancer.data[, 2:4]
res.mca.bufeta <- MCA(cancer.data.analisi, graph = FALSE)

#Percentage of explained variances - dimensions
fviz_screeplot(res.mca.bufeta, addlabels = TRUE)

fviz_mca_var(res.mca.bufeta, choice = "mca.cor", 
             repel = TRUE, 
             ggtheme = theme_minimal())

#Correlation between variables
fviz_famd_var(res.mca.bufeta, repel = TRUE)

# Contribution to the first dimension
fviz_contrib(res.mca.bufeta, "var", axes = 1)

# Contribution to the second dimension
fviz_contrib(res.mca.bufeta, "var", axes = 2)

fviz_mca_var(res.mca.bufeta, col.var = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE, ggtheme = theme_minimal())


#'-----------------------------------------------End Study 7 - Urinary Bladder ---------------------------------------------------------------------#



#'-----------------------------------------------Study 8 - Prostate ---------------------------------------------------------------------#
#' Study 8. Check MCA with AGE_GROUP(categorical variable) and GENDER and POPULATION
#' 
#' +
#'

cancer.data=read_csv("Desktop/MCA-Cancer/data/private/analisi-prostata2.csv")
summary(cancer.data)

head(cancer.data)
cancer.data.analisi = cancer.data[, 2:4]
res.mca.prostata <- MCA(cancer.data.analisi, graph = FALSE)

#Percentage of explained variances - dimensions
fviz_screeplot(res.mca.prostata, addlabels = TRUE)

fviz_mca_var(res.mca.prostata, choice = "mca.cor", 
             repel = TRUE, 
             ggtheme = theme_minimal())

#Correlation between variables
fviz_famd_var(res.mca.prostata, repel = TRUE)

# Contribution to the first dimension
fviz_contrib(res.mca.prostata, "var", axes = 1)

# Contribution to the second dimension
fviz_contrib(res.mca.prostata, "var", axes = 2)

fviz_mca_var(res.mca.prostata, col.var = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE, ggtheme = theme_minimal())


#'-----------------------------------------------End Study 8 - Urinary Bladder ---------------------------------------------------------------------#




#'-----------------------------------------------Study 9 - Prostate ---------------------------------------------------------------------#
#' Study 9. Check MCA with AGE_GROUP(categorical variable) and GENDER and POPULATION
#' 
#' +
#'

cancer.data=read_csv("Desktop/MCA-Cancer/data/private/analisi-mama2.csv")
summary(cancer.data)

head(cancer.data)
cancer.data.analisi = cancer.data[, 2:4]
res.mca.mama <- MCA(cancer.data.analisi, graph = FALSE)

#Percentage of explained variances - dimensions
fviz_screeplot(res.mca.mama, addlabels = TRUE)

fviz_mca_var(res.mca.prostata, choice = "mca.cor", 
             repel = TRUE, 
             ggtheme = theme_minimal())

#Correlation between variables
fviz_famd_var(res.mca.mama, repel = TRUE)

# Contribution to the first dimension
fviz_contrib(res.mca.prostata, "var", axes = 1)

# Contribution to the second dimension
fviz_contrib(res.mca.mama, "var", axes = 2)

fviz_mca_var(res.mca.mama, col.var = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE, ggtheme = theme_minimal())


#'-----------------------------------------------End Study 9 - Urinary Bladder ---------------------------------------------------------------------#
