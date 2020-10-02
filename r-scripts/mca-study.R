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
library(plotly)
library(ggthemes)
source("Scripts/mca-study.R")

# ----------------------------- Auxiliar Functions ------------------------------- #
boxplot_by_gender <- function(cancer.data, cancer) {
  head(cancer.data)
  df1 <- filter(cancer.data, gender == "Male")
  df2 <- filter(cancer.data, gender == "Female")
  
  y_title <- list(
    title = "Age"
  )
  x_title <- list(
    title = "Gender"
  )
  
  p <- plot_ly(df1, x = df1[["gender"]], y = df1[["age"]], type  = "box", name = 'Male')%>%
    add_trace(df2, x = df2[["gender"]], y = df2[["age"]], name = 'Female') %>%
    layout(yaxis = y_title) %>%
    layout(xaxis = x_title)
    #layout(title = paste("Cancer by gender -", cancer))
  p
}

boxplot_by_population <- function(cancer.data, cancer) {
  df1 <- filter(cancer.data, population == "Urban")
  df2 <- filter(cancer.data, population == "Rural")
  
  y_title <- list(
    title = "Age"
  )
  x_title <- list(
    title = "Population"
  )
  
  p <- plot_ly(df1, x = df1[["population"]], y = df1[["age"]], type  = "box", name = 'Urban')%>%
    add_trace(df2, x = df2[["population"]], y = df2[["age"]], name = 'Rural') %>%
    layout(yaxis = y_title, xaxis = x_title, grid = 'rgba(0,0,0,0)')
    #layout(title = paste("Cancer by population - ", cancer))
  p
  p
  
}

find_outliers <- function () {
  cancer.data.colonrectum = read_csv("/Users/Didac/OneDrive - Generalitat de Catalunya/CANCER/MCA-Cancer/data/private/analisi-colonrecte.csv")
  boxplot_by_gender(cancer.data.colonrectum, "Colon and Rectum")
  boxplot_by_population(cancer.data.colonrectum, "Colon and Rectum")
  
  cancer.data.lung = read_csv("/Users/Didac/OneDrive - Generalitat de Catalunya/CANCER/MCA-Cancer/data/private/analisi-pulmo.csv")
  boxplot_by_gender(cancer.data.lung, "Lung")
  boxplot_by_population(cancer.data.lung, "Lung")
  
  cancer.data.urinarybladder = read_csv("/Users/Didac/OneDrive - Generalitat de Catalunya/CANCER/MCA-Cancer/data/private/analisi-bufeta.csv")
  boxplot_by_gender(cancer.data.urinarybladder, "Urinary Bladder")
  boxplot_by_population(cancer.data.urinarybladder, "Urinary Bladder")
  
  cancer.data.prostate = read_csv("/Users/Didac/OneDrive - Generalitat de Catalunya/CANCER/MCA-Cancer/data/private/analisi-prostata.csv")
  boxplot_by_gender(cancer.data.prostate, "Prostate")
  boxplot_by_population(cancer.data.prostate, "Prostate")
  
  cancer.data.breast = read_csv("/Users/Didac/OneDrive - Generalitat de Catalunya/CANCER/MCA-Cancer/data/private/analisi-mama.csv")
  boxplot_by_gender(cancer.data.breast, "Breast")
  boxplot_by_population(cancer.data.breast, "Breast")
}


#Calculate the outliers using Box Plot technique
find_outliers()

#' @details 
#' This CSV is cleaned and contains the following columns PATIENT_ID, AGE_GROUP, POPULATION, CANCER and GENDER
#' * POPULATION is a categorical variable with two values Urban or Rural.
#' * CANCER is a categorical variable with includes a set with the names of the most important cancers.
#' * AGE_GROUP is a categorical variable with ithe a set of age segmentation groups.
#' * GENDER is a categorical variable with gender information Male or Female.

cancer.data=read_csv("/Users/Didac/OneDrive - Generalitat de Catalunya/CANCER/MCA-Cancer/data/private/analisisENG.csv")
summary(cancer.data)
table(cancer.data$gender)
table(cancer.data$edat)
table(cancer.data$poblacio)

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

#The contribution of every category in the dimension 1
fviz_contrib(res.mca1, choice = "var", axes = 1, top = 20,
             palette = "jco")

res.mca1$var
res.mca1$eig

#The contribution of every category in the dimension 2
fviz_contrib(res.mca1, choice = "var", axes = 2, top = 20,
             palette = "jco")

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

res.mca2$var
res.mca2$eig

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

fviz_screeplot(res.mca3, addlabels = TRUE, labelsize = 30) +
  labs(title = "")+
  theme(text = element_text(size = 20),
        axis.title = element_text(size = 20),
        axis.text = element_text(size = 20)) + theme_classic()

fviz_mca_var(res.mca3, choice = "mca.cor", 
             repel = TRUE, 
             ggtheme = theme_minimal())
summary(res.mca3)

res.mca3$eig
res.mca3$var

fviz_mca_ind(res.mca3,label = "none", labelsaddEllipses = TRUE, ellipse.level = 0.9,ggtheme = theme_minimal())


fviz_mca_var(res.mca3, choice = "mca.cor", 
             repel = TRUE, 
             ggtheme = theme_minimal())

fviz_mca_var(res.mca3, 
             repel = TRUE, # Avoid text overlapping (slow)
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
             repel = TRUE, ggtheme = theme_minimal(), labelsize = 6) +
  theme_classic() +
  labs(title = " ", x= paste("Dimension 1 (", round(res.mca3$eig[7], 1),"%)", " "), 
       y = paste("Dimension 2 (", round(res.mca3$eig[8], 1),"%)", " "))+
  theme(text = element_text(size = 16),
        axis.title = element_text(size = 16),
        axis.text = element_text(size = 16), 
        legend.position = c(0.92, 0.85))


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

res.mca3$var

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

#'----------------------------------------------- Study 9 - Urban ---------------------------------------------------------------------#

cancer.data=read_csv("Desktop/MCA-Cancer/data/private/analisi-urba.csv")

cancer.data.analisi = cancer.data[, 2:4]
res.mca.urban <- MCA(cancer.data.analisi, graph = FALSE)
head(cancer.data)

#Percentage of explained variances - dimensions
fviz_screeplot(res.mca.urban, addlabels = TRUE)

#Representation the variables in the dimensions
fviz_mca_var(res.mca.urban, choice = "mca.cor", 
             repel = TRUE, 
             ggtheme = theme_minimal())

#Represent the categories contribution 
fviz_mca_var(res.mca.urban, col.var = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE, ggtheme = theme_minimal(), labelsize = 7) +
  labs(title = " ", x= paste("Dimension 1 (", round(res.mca.urban$eig[9], 1),"%)", " "), 
       y = paste("Dimension 2 (", round(res.mca.urban$eig[10], 1),"%)", " "))+
  theme(text = element_text(size = 20),
        axis.title = element_text(size = 20),
        axis.text = element_text(size = 20), 
        legend.position = c(0.95, 0.85))


#'----------------------------------------------- Study 9 - Rural ---------------------------------------------------------------------#

cancer.data=read_csv("Desktop/MCA-Cancer/data/private/analisi-rural.csv")

cancer.data.analisi = cancer.data[, 2:4]
res.mca.rural <- MCA(cancer.data.analisi, graph = FALSE)
head(cancer.data)

#Percentage of explained variances - dimensions
fviz_screeplot(res.mca.rural, addlabels = TRUE)

fviz_mca_var(res.mca.rural, choice = "mca.cor", 
             repel = TRUE, 
             ggtheme = theme_minimal())

res.mca.rural$eig

fviz_mca_var(res.mca.rural, col.var = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE, ggtheme = theme_minimal(), labelsize = 7) +
  labs(title = " ", x= paste("Dimension 1 (", round(res.mca.rural$eig[9], 1),"%)", " "), 
       y = paste("Dimension 2 (", round(res.mca.rural$eig[10], 1),"%)", " "))+
  theme(text = element_text(size = 20),
        axis.title = element_text(size = 20),
        axis.text = element_text(size = 20), 
        legend.position = c(0.95, 0.85))


