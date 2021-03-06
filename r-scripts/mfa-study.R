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

cancer.data=read_csv("Desktop/MCA-Cancer/data/private/analisi-colonrecte.csv")
summary(cancer.data)

head(cancer.data)
#'-----------------------------------------------Study 1---------------------------------------------------------------------#
#' Study 1. Check MFA with AGE_GROUP, POPULATION, CANCER and GENDER
#' 
cancer.data.analisi = cancer.data[, 2:5]
res.mfa1 <- MFA(cancer.data.analisi, group = c(1, 1, 1, 1), type = c("c", "n", "n", "n"), name.group = c("age", "population", "cancer", "gender"), 
                graph = FALSE)
fviz_screeplot(res.mfa1, addlabels = TRUE) #Dimensions
fviz_mfa_var(res.mfa1, "group")

# Contribution to the first dimension of Study 2
fviz_contrib(res.mfa1, "group", axes = 1)
# Contribution to the second dimension of Study 2
fviz_contrib(res.mfa1, "group", axes = 2)

#The contribution of every category in the dimension 1
fviz_contrib(res.mfa2, choice = "quali.var", axes = 1, top = 20,
             palette = "jco")

#The contribution of every category in the dimension 2
fviz_contrib(res.mfa1, choice = "quali.var", axes = 2, top = 20,
             palette = "jco")

#Plot of categorical variables in the Dimensions
fviz_mfa_var(res.mfa1, "quali.var", palette = "jco", 
             col.var.sup = "violet", repel = TRUE)

#Contribution of all the categorical categories
fviz_mfa_var(res.mfa1, "quali.var", col.var = "contrib", 
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07", "#008000"), 
             col.var.sup = "violet", repel = TRUE,
             geom = c("point", "text"))

#' Conclusion: The population (0.24, 0) variable is close to (0, 0) in both dimension, so it is not a way to extract results.
#'-----------------------------------------------End Study 1-----------------------------------------------------------------#



#'-----------------------------------------------Study 2---------------------------------------------------------------------#
#' Study 2. Check MFA with AGE, POPULATION and CANCER
#'
cancer.data.analisi = cancer.data[, 2:4]
res.mfa2 <- MFA(cancer.data.analisi, group = c(1, 1, 1), type = c("c", "n", "n"), name.group = c("age", "population", "cancer"), 
                graph = FALSE)
fviz_screeplot(res.mfa2, addlabels = TRUE) #Dimensions
fviz_mfa_var(res.mfa2, "group")

# Contribution to the first dimension of Study 2
fviz_contrib(res.mfa2, "group", axes = 1)
# Contribution to the second dimension of Study 2
fviz_contrib(res.mfa2, "group", axes = 2)

#The contribution of every category in the dimension 1
fviz_contrib(res.mfa2, choice = "quali.var", axes = 1, top = 20,
             palette = "jco")

#The contribution of every category in the dimension 2
fviz_contrib(res.mfa1, choice = "quali.var", axes = 2, top = 20,
             palette = "jco")

#Plot of categorical variables in the Dimensions
fviz_mfa_var(res.mfa2, "quali.var", palette = "jco", 
             col.var.sup = "violet", repel = TRUE)

#Contribution of all the categorical categories
fviz_mfa_var(res.mfa2, "quali.var", col.var = "contrib", 
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07", "#008000"), 
             col.var.sup = "violet", repel = TRUE,
             geom = c("point", "text"))

fviz_mfa_ind(res.mfa2,
             habillage = "population", # color by groups
             palette = c("#00AFBB", "#E7B800", "#FC4E07", "#008000", "#DA70D6"),
             addEllipses = TRUE, ellipse.type = "confidence",
             repel = TRUE # Avoid text overlapping
)

#' Conclusion: The population (0.39, 0.1) is a bit far from (0,0) compared with the previous study, but it has to study if it is a 
#' good candidate case to be studied. The contribution of the population variable in the Dimensions is not strong enough.

#'-----------------------------------------------Study 3---------------------------------------------------------------------#
#' Study 3. Check MFA with AGE_GROUP as quantitative group, and POPULATION, CANCER and GENDER as categorical group
#' 
cancer.data.analisi = cancer.data[, 2:5]
res.mfa3 <- MFA(cancer.data.analisi, group = c(1, 3), type = c("c", "n"), name.group = c("age", "population-cancer-gender"), 
                graph = FALSE)
fviz_screeplot(res.mfa3, addlabels = TRUE) #Dimensions
fviz_mfa_var(res.mfa3, "group")

# Contribution to the first dimension of Study 2
fviz_contrib(res.mfa3, "group", axes = 1)
# Contribution to the second dimension of Study 2
fviz_contrib(res.mfa3, "group", axes = 2)

#The contribution of every category in the dimension 1
fviz_contrib(res.mfa3, choice = "quali.var", axes = 1, top = 20,
             palette = "jco")

#The contribution of every category in the dimension 2
fviz_contrib(res.mfa3, choice = "quali.var", axes = 2, top = 20,
             palette = "jco")

#Plot of categorical variables in the Dimensions
fviz_mfa_var(res.mfa3, "quali.var", palette = "jco", 
             col.var.sup = "violet", repel = TRUE)

#Contribution of all the categorical categories
fviz_mfa_var(res.mfa1, "quali.var", col.var = "contrib", 
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07", "#008000"), 
             col.var.sup = "violet", repel = TRUE,
             geom = c("point", "text"))

#' Conclusion: The population is insignificantly
#'-----------------------------------------------End Study 3-----------------------------------------------------------------#




#'-----------------------------------------------Study 4---------------------------------------------------------------------#
#' Study 4. Check MFA with AGE_GROUP as quantitative group, and POPULATION and CANCER as categorical group
#' 
cancer.data.analisi = cancer.data[, 2:4]
res.mfa4 <- MFA(cancer.data.analisi, group = c(1, 2), type = c("c", "n"), name.group = c("age", "population-cancer"), 
                graph = FALSE)
fviz_screeplot(res.mfa4, addlabels = TRUE) #Dimensions
fviz_mfa_var(res.mfa4, "group")

# Contribution to the first dimension of Study 2
fviz_contrib(res.mfa4, "group", axes = 1)
# Contribution to the second dimension of Study 2
fviz_contrib(res.mfa4, "group", axes = 2)

#The contribution of every category in the dimension 1
fviz_contrib(res.mfa4, choice = "quali.var", axes = 1, top = 20,
             palette = "jco")

#The contribution of every category in the dimension 2
fviz_contrib(res.mfa4, choice = "quali.var", axes = 2, top = 20,
             palette = "jco")

#Plot of categorical variables in the Dimensions
fviz_mfa_var(res.mfa4, "quali.var", palette = "jco", 
             col.var.sup = "violet", repel = TRUE)

#Contribution of all the categorical categories
fviz_mfa_var(res.mfa4, "quali.var", col.var = "contrib", 
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07", "#008000"), 
             col.var.sup = "violet", repel = TRUE,
             geom = c("point", "text"))

fviz_mfa_ind(res.mfa4, col.ind = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07", "#008000"),
             repel = TRUE)

#' Conclusion: The population is insignificantly
#'-----------------------------------------------End Study 3-----------------------------------------------------------------#



#'-----------------------------------------------Study 5---------------------------------------------------------------------#
#' Study 5. Check MFA with AGE_GROUP as quantitative group, POPULATION as categorical group, and CANCER and GENDER as categorical group
#' 
cancer.data.analisi = cancer.data[, 2:4]
res.mfa5 <- MFA(cancer.data.analisi, group = c(1, 2), type = c("c", "n"), name.group = c("age", "population-gender"), 
                graph = FALSE)
fviz_screeplot(res.mfa5, addlabels = TRUE) #Dimensions
fviz_mfa_var(res.mfa5, "group")

# Contribution to the first dimension of Study 5
fviz_contrib(res.mfa5, "group", axes = 1, addlabels = TRUE)
# Contribution to the second dimension of Study 5
fviz_contrib(res.mfa5, "group", axes = 2, addlabels = TRUE)

#The contribution of every category in the dimension 1
fviz_contrib(res.mfa5, choice = "quali.var", axes = 1, top = 20,
             palette = "jco")

#The contribution of every category in the dimension 2
fviz_contrib(res.mfa5, choice = "quali.var", axes = 2, top = 20,
             palette = "jco")

#Plot of categorical variables in the Dimensions
fviz_mfa_var(res.mfa5, "quali.var", palette = "jco", 
             col.var.sup = "violet", repel = TRUE)

#Contribution of all the categorical categories
fviz_mfa_var(res.mfa5, "quali.var", col.var = "contrib", 
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07", "#008000"), 
             col.var.sup = "violet", repel = TRUE,
             geom = c("point", "text"))

fviz_mfa_ind(res.mfa5,
             habillage = "population", # color by groups
             palette = c("#00AFBB", "#E7B800", "#FC4E07", "#FFFFFF"),
             addEllipses = TRUE, ellipse.type = "confidence",
             repel = TRUE # Avoid text overlapping
)
#' Conclusion: The population is insignificantly
#'-----------------------------------------------End Study 5-----------------------------------------------------------------#


#'-----------------------------------------------Study 6---------------------------------------------------------------------#
#' Study 5. Check MFA with AGE_GROUP(categorical variable) and GENDER are a group, POPULATION as categorical group, and CANCER as categorical group
#' 
#' +
cancer.data.categorical=read_csv("Desktop/MCA-Cancer/data/private/analisi3.csv")
cancer.data.analisi = cancer.data.categorical[, 2:5]
res.mfa6 <- MFA(cancer.data.analisi, group = c(2, 1, 1), type = c("n", "n", "n"), name.group = c("age-gender", "population","cancer"), 
                graph = FALSE)
fviz_screeplot(res.mfa6, addlabels = TRUE) #Dimensions
fviz_mfa_var(res.mfa6, "group")

# Contribution to the first dimension of Study 5
fviz_contrib(res.mfa6, "group", axes = 1, addlabels = TRUE)
# Contribution to the second dimension of Study 5
fviz_contrib(res.mfa6, "group", axes = 2, addlabels = TRUE)

#The contribution of every category in the dimension 1
fviz_contrib(res.mfa6, choice = "quali.var", axes = 1, top = 20,
             palette = "jco")

#The contribution of every category in the dimension 2
fviz_contrib(res.mfa6, choice = "quali.var", axes = 2, top = 20,
             palette = "jco")

#Plot of categorical variables in the Dimensions
fviz_mfa_var(res.mfa6, "quali.var", palette = "jco", 
             col.var.sup = "violet", repel = TRUE)

#Contribution of all the categorical categories
fviz_mfa_var(res.mfa6, "quali.var", col.var = "contrib", 
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07", "#008000"), 
             col.var.sup = "violet", repel = TRUE,
             geom = c("point", "text"))

fviz_mfa_ind(res.mfa6,
             habillage = "population", # color by groups
             palette = c("#00AFBB", "#E7B800", "#FC4E07", "#FFFFFF"),
             addEllipses = TRUE, ellipse.type = "confidence",
             repel = TRUE # Avoid text overlapping
)
#' Conclusion: The population is insignificantly
#'-----------------------------------------------End Study 6-----------------------------------------------------------------#




#---------------------- Auxiliar function and plots ----------------------------------#
# 
# eig.val <- get_eigenvalue(res.mfa2)
# head(eig.val)
# 
# group <- get_mfa_var(res.mfa2, "group")
# group


# # Coordinates of groups
# head(group$coord)

# # Cos2: quality of representation on the factore map
# head(group$cos2)

# # Contributions to the  dimensions
# head(group$contrib)



# fviz_mfa_ind(res.mfa1, col.ind = "cos2", 
#              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
#              repel = TRUE)
# 
# 
# 
# fviz_mfa_ind(res.mfa1, 
#              habillage = "population", # color by groups 
#              palette = c("#00AFBB", "#E7B800", "#FC4E07", "#FFFFFF"),
#              addEllipses = TRUE, ellipse.type = "confidence", 
#              repel = TRUE # Avoid text overlapping
# )