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

source("Scripts/famd-study.R")

#' @details 
#' This CSV is cleaned and contains the following columns PATIENT_ID, AGE_GROUP, POPULATION, CANCER and GENDER
#' * POPULATION is a categorical variable with two values Urban or Rural.
#' * CANCER is a categorical variable with includes a set with the names of the most important cancers.
#' * AGE is a quantitative variable with the real age when patient suffered the cancer.
#' * GENDER is a categorical variable with gender information Male or Female.

cancer.data=read_csv("Desktop/MCA-Cancer/data/private/analisis2-famd.csv")
summary(cancer.data)

head(cancer.data)
#' Study 1. Check MFA with AGE_GROUP, POPULATION, CANCER and GENDER
#'
cancer.data.analisi = cancer.data[, 2:4]
res.famd <- FAMD(cancer.data.analisi)
summary(res.famd)

fviz_screeplot(res.famd)


#Correlation between variables
plot(res.famd, choix = "var")

#Graph of individuals
plot(res.famd, choix = "ind")

#Correlation circle of qualitative variables
plot(res.famd, choix = "quali")

#Correlation circle of quantitative variables
plot(res.famd, choix = "quanti")


summary(res.famd)
plot(res.famd, habillage=2)


#Another way to build FAMD study
# Plot of variables
fviz_famd_var(res.famd, repel = TRUE)
# Contribution to the first dimension
fviz_contrib(res.famd, "var", axes = 1)
# Contribution to the second dimension
fviz_contrib(res.famd, "var", axes = 2)

#Contribution of the quantitative variables
fviz_famd_var(res.famd, "quanti.var", col.var = "contrib", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)

# Color by cos2 values: quality on the factor map
fviz_famd_var(res.famd, "quanti.var", col.var = "cos2",
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
              repel = TRUE)

fviz_famd_var(res.famd, "quali.var", col.var = "contrib", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07")
)

fviz_famd_ind(res.famd, col.ind = "cos2", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)


fviz_mfa_ind(res.famd, 
             habillage = "cancer", # color by groups 
             palette = c("#00AFBB", "#E7B800", "#FC4E07", "#008000", "#DA70D6"),
             addEllipses = TRUE, ellipse.type = "confidence", 
             repel = TRUE # Avoid text overlapping
) 

fviz_ellipses(res.famd, c("cancer", "population"), repel = TRUE)
fviz_ellipses(res.famd, 2:3, geom = "point")


