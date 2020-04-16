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

cancer.data=read_csv("../data/analisisENG.csv")

head(cancer.data)

#' Study 1. Check MCA with AGE_GROUP, POPULATION, CANCER and GENDER
#'
cancer.data.analisi = cancer.data[, 2:5]
res.mca1 <- MCA(cancer.data.analisi, graph = FALSE)
fviz_screeplot(res.mca1, addlabels = TRUE)

fviz_mca_var(res.mca1, choice = "mca.cor", 
             repel = TRUE, 
             ggtheme = theme_minimal())

#' Study 2. Check MCA with AGE_GROUP, POPULATION, CANCER
#'
cancer.data.analisi = cancer.data[, 2:4]
res.mca2 <- MCA(cancer.data.analisi, graph = FALSE)
fviz_screeplot(res.mca2, addlabels = TRUE)

fviz_mca_var(res.mca2, choice = "mca.cor", 
             repel = TRUE, 
             ggtheme = theme_minimal())

#' Study 3. Check MCA with POPULATION, CANCER and GENDER
#'
cancer.data.analisi = cancer.data[, 3:5]
res.mca3 <- MCA(cancer.data.analisi, graph = FALSE)
fviz_screeplot(res.mca1, addlabels = TRUE)

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


fviz_mca_ind(res.mca3
             label = "none", # hide individual labels
             habillage =cancer.data.analisi$group3, # color by groups 
             #palette = c("#00AFBB", "#E7B800"),
             addEllipses = TRUE,ellipse.level = 0.9,
             ggtheme = theme_minimal())
