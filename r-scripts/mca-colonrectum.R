#' MCA Study for Colon and rectum cancer
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
library(plotly)

#' @details 
#' This CSV is cleaned and contains the following columns PATIENT_ID, AGE_GROUP, POPULATION, CANCER and GENDER
#' * POPULATION is a categorical variable with two values Urban or Rural.
#' * CANCER is a categorical variable with includes a set with the names of the most important cancers.
#' * AGE_GROUP is a categorical variable with ithe a set of age segmentation groups.
#' * GENDER is a categorical variable with gender information Male or Female.

#Read csv file with information about colon and rectum file without outliers
cancer.data=read_csv("../../../MCA-Cancer/data/private/analisi-colonrecte2-outliers.csv")

summary(cancer.data)
head(cancer.data)

#Split information and save it into a variable without the Cancer column
cancer.data.analisi = cancer.data[, 2:4]

#Apply the MCA technique and save the results into a variable
res.mca.colon <- MCA(cancer.data.analisi, graph = FALSE)

#Show the results in the consle
res.mca.colon$eig
res.mca.colon$var

#This function create the plot which represents the percentage of explained variances by dimensions
fviz_screeplot(res.mca.colon, addlabels = TRUE)

#This function create the plot which represent the variable into the dimensions
fviz_mca_var(res.mca.colon, choice = "mca.cor", 
             repel = TRUE, 
             ggtheme = theme_minimal())

#Correlation between variables
fviz_famd_var(res.mca.colon, 
              repel = TRUE, # Avoid text overlapping (slow)
              ggtheme = theme_minimal())

# Contribution to the first dimension
fviz_contrib(res.mca.colon, "var", axes = 1)

# Contribution to the second dimension
fviz_contrib(res.mca.colon, "var", axes = 2)

#Contribution and correlation in the biplot
fviz_mca_var(res.mca.colon, col.var = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE, ggtheme = theme_minimal(), labelsize = 7) +
  labs(title = " ", x= paste("Dimension 1 (", round(res.mca.colon$eig[6], 1),"%)", " "), 
       y = paste("Dimension 2 (", round(res.mca.colon$eig[7], 1),"%)", " "))+
  theme(text = element_text(size = 20),
        axis.title = element_text(size = 20),
        axis.text = element_text(size = 20), 
        legend.position = c(0.95, 0.85))
