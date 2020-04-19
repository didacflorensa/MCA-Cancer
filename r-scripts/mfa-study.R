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

cancer.data=read_csv("Desktop/MCA-Cancer/data/private/analisis2.csv")
summary(cancer.data)

head(cancer.data)
#' Study 1. Check MFA with AGE_GROUP, POPULATION, CANCER and GENDER
#'
cancer.data.analisi = cancer.data[, 2:5]
res.mfa1 <- MFA(cancer.data.analisi, group = c(1, 1, 1, 1), type = c("c", "n", "n", "n"), name.group = c("age", "population", "cancer", "gender"), 
                graph = FALSE)
fviz_screeplot(res.mfa1, addlabels = TRUE)
eig.val <- get_eigenvalue(res.mfa1)
head(eig.val)

group <- get_mfa_var(res.mfa1, "group")
group
# Coordinates of groups
head(group$coord)
# Cos2: quality of representation on the factore map
head(group$cos2)
# Contributions to the  dimensions
head(group$contrib)
fviz_mfa_var(res.mfa1, "group")

# Contribution to the first dimension
fviz_contrib(res.mfa1, "group", axes = 1)
# Contribution to the second dimension
fviz_contrib(res.mfa1, "group", axes = 2)

fviz_mfa_var(res.mfa1, "quali.var", palette = "jco", 
             col.var.sup = "violet", repel = TRUE)

fviz_mfa_var(res.mfa1, "quali.var", palette = "jco", 
             col.var.sup = "violet", repel = TRUE,
             geom = c("point", "text"), legend = "bottom")

fviz_contrib(res.mfa1, choice = "quali.var", axes = 1, top = 20,
             palette = "jco")

fviz_contrib(res.mfa1, choice = "quali.var", axes = 2, top = 20,
             palette = "jco")

fviz_mfa_var(res.mfa1, "quali.var", col.var = "contrib", 
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             col.var.sup = "violet", repel = TRUE,
             geom = c("point", "text"))

fviz_mfa_ind(res.mfa1, col.ind = "cos2", 
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE)

fviz_mfa_var(res.mfa1, "quali.var", palette = "jco", 
             col.var.sup = "violet", repel = TRUE)

fviz_mfa_var(res.mfa1, "quali.var", palette = "jco", 
             col.var.sup = "violet", repel = TRUE,
             geom = c("point", "text"), legend = "bottom")

fviz_contrib(res.mfa1, choice = "quali.var", axes = 1, top = 20,
             palette = "jco")

fviz_mfa_var(res.mfa1, "quali.var", col.var = "contrib", 
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07", "#FFFFFF"), 
             col.var.sup = "violet", repel = TRUE,
             geom = c("point", "text"))

fviz_mfa_ind(res.mfa1, 
             habillage = "Label", # color by groups 
             palette = c("#00AFBB", "#E7B800", "#FC4E07", "#FFFFFF"),
             addEllipses = TRUE, ellipse.type = "confidence", 
             repel = TRUE # Avoid text overlapping
)