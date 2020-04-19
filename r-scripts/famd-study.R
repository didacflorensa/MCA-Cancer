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

cancer.data=read_csv("Desktop/MCA-Cancer/data/private/analisis2.csv")
summary(cancer.data)

head(cancer.data)
#' Study 1. Check MFA with AGE_GROUP, POPULATION, CANCER and GENDER
#'
cancer.data.analisi = cancer.data[, 2:5]
res.famd <- FAMD(cancer.data.analisi)
summary(res.famd)
eig.val <- res.famd$eig
barplot(eig.val[, 2], 
        names.arg = 1:nrow(eig.val), 
        main = "Variances Explained by Dimensions (%)",
        xlab = "Principal Dimensions",
        ylab = "Percentage of variances",
        col ="steelblue")
# Add connected line segments to the plot
lines(x = 1:nrow(eig.val), eig.val[, 2], 
      type = "b", pch = 19, col = "red")

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







