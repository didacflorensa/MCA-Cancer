#' MCA Study for Prostate cancer
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
#' * GENDER is a categorical variable with gender information Male or Female.
#' * AGE_GROUP is a categorical variable with ithe a set of age segmentation groups.
#' * EXITUS is a categorical variable with with a two values Yes or No.
#' * POPULATION is a categorical variable with two values Urban or Rural.
#' * INCOME is a categorical variable with three values R1, R2 or R3.
#' * POPULATION is a categorical variable with three values Urban, Rural or Semi-Urban.
#' * IMC is a categorical variable with the categories <=18.4, 18.5-24.9, 25-25.9, 30-34.9, 35-39.9, >=40
#' * SURGERY is a categorical variable with with a two values Yes or No.
#' * SMOKER is a categorical variable with three values No-smoker, Ex smoker or Smoker.
#' * SURGERY is a categorical variable with with a two values Yes or No.


#Read csv file with information about colon and rectum file without outliers
cancer.data.analisi=read_csv("/Users/Didac/Projects/artificial-neural-network-cancer/Data/private/colon_double_comma_v2.csv")
cancer.data.analisi$surgery <- NULL
#cancer.data.analisi$smoker <- NULL
#cancer.data.analisi$exitus <- NULL
#cancer.data.analisi$group_age <- NULL
#cancer.data.analisi$surgery <- NULL
#cancer.data.analisi$population <- NULL
#cancer.data.analisi$gender <- NULL
#cancer.data.analisi$smoker <- NULL
summary(cancer.data.analisi)
head(cancer.data.analisi)


age_filter <- c("age_>=75", "age_65-74", "age_50-64")
income_filter <- c("R2")
#smoker_filter <- c("No smoker")
#bmi_filter <- c("bmi_<=24.9")
cancer.data.analisi %>% filter(smoker %in% smoker_filter) %>% filter(group_age %in% age_filter) %>% filter(income %in% income_filter) -> cancer.data.analisi
#cancer.data.analisi %>% filter(smoker %in% smoker_filter) %>% filter(group_age %in% age_filter) -> cancer.data.analisi
#cancer.data.analisi %>% filter(group_age %in% age_filter) %>% filter(income %in% income_filter) -> cancer.data.analisi
#cancer.data.analisi %>% filter(income %in% income_filter)-> cancer.data.analisi
cancer.data.analisi %>% filter(group_age %in% age_filter)-> cancer.data.analisi
#cancer.data.analisi %>% filter(bmi %in% bmi_filter)-> cancer.data.analisi
#cancer.data.analisi$group_age <- NULL
#cancer.data.analisi$income <- NULL
#cancer.data.analisi$smoker <- NULL
#cancer.data.analisi$bmi <- NULL

#-------------------------Frequencies----------------------#
gender_table <- table(cancer.data.analisi$gender)
prop.table(gender_table)

age_table <- table(cancer.data.analisi$group_age)
prop.table(age_table)

exitus_table <- table(cancer.data.analisi$exitus)
exitus_table
prop.table(exitus_table)

income_table <- table(cancer.data.analisi$income)
income_table
prop.table(income_table)

population_table <- table(cancer.data.analisi$population)
population_table
prop.table(population_table)

bmi_table <- table(cancer.data.analisi$bmi)
bmi_table
prop.table(bmi_table)

smoker_table <- table(cancer.data.analisi$smoker)
smoker_table
prop.table(smoker_table)


#-----------------------MCA-------------------------#
#Split information and save it into a variable without the Cancer column
#cancer.data.analisi = cancer.data.analisi[, 1:8]

#Apply the MCA technique and save the results into a variable
res.mca <- MCA(cancer.data.analisi, graph = FALSE)

#Show the results in the console (contrib, eta2, cos2, eigenvalue, variance, inertia...)
res.mca$eig
res.mca$var

#This function create the plot which represents the percentage of explained variances by dimensions
fviz_screeplot(res.mca, addlabels = TRUE)


#This function create the plot which represent the variable into the dimensions
fviz_mca_var(res.mca, choice = "mca.cor", 
             repel = TRUE, 
             ggtheme = theme_minimal()) 


#Correlation between variables
fviz_famd_var(res.mca, 
              repel = TRUE, # Avoid text overlapping (slow)
              ggtheme = theme_minimal())


# Contribution to the first dimension
fviz_contrib(res.mca, "var", axes = 1)

# Contribution to the second dimension
fviz_contrib(res.mca, "var", axes = 2)

#Contribution and correlation in the biplot
fviz_mca_var(res.mca, col.var = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE, ggtheme = theme_minimal(), labelsize = 5) +
  theme_classic() +
  labs(title = " ", x= paste("Dimension 1 (", round(res.mca$eig[6], 1),"%)", " "), 
       y = paste("Dimension 2 (", round(res.mca$eig[7], 1),"%)", " "))+
  theme(text = element_text(size = 11),
        axis.title = element_text(size = 15),
        axis.text = element_text(size = 15), 
        legend.position = c(0.95, 0.76))
