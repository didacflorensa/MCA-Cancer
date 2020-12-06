
library("FactoMineR")
library("factoextra")
library('ggplot2')
library(readr)
library(plotly)
library(ggthemes)
source("Scripts/mca-study.R")

#IMPORTANT: In this case, the variable age has to be numerical!

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
  cancer.data.colonrectum = read_csv("MCA-Cancer/data/private/analisi-colonrecte.csv")
  boxplot_by_gender(cancer.data.colonrectum, "Colon and Rectum")
  boxplot_by_population(cancer.data.colonrectum, "Colon and Rectum")
  
  cancer.data.lung = read_csv("MCA-Cancer/data/private/analisi-pulmo.csv")
  boxplot_by_gender(cancer.data.lung, "Lung")
  boxplot_by_population(cancer.data.lung, "Lung")
  
  cancer.data.urinarybladder = read_csv("MCA-Cancer/data/private/analisi-bufeta.csv")
  boxplot_by_gender(cancer.data.urinarybladder, "Urinary Bladder")
  boxplot_by_population(cancer.data.urinarybladder, "Urinary Bladder")
  
  cancer.data.prostate = read_csv("MCA-Cancer/data/private/analisi-prostata.csv")
  boxplot_by_gender(cancer.data.prostate, "Prostate")
  boxplot_by_population(cancer.data.prostate, "Prostate")
  
  cancer.data.breast = read_csv("MCA-Cancer/data/private/analisi-mama.csv")
  boxplot_by_gender(cancer.data.breast, "Breast")
  boxplot_by_population(cancer.data.breast, "Breast")
}


#Calculate the outliers using Box Plot technique
find_outliers()