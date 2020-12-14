
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
  cancer.data.colonrectum = read_csv("../../MCA-Cancer/data/mock_outliers.csv")
  cancer.data.colonrectum = cancer.data.colonrectum[,2:5]
  colon_filter <- c("Colon and rectum")
  cancer.data.colonrectum %>% filter(cancer %in% colon_filter) -> cancer.data.colonrectum
  boxplot_by_gender(cancer.data.colonrectum, "Colon and Rectum")
  boxplot_by_population(cancer.data.colonrectum, "Colon and Rectum")
  
  cancer.data.lung = read_csv("../../MCA-Cancer/data/mock_outliers.csv")
  cancer.data.lung = cancer.data.lung[,2:5]
  lung_filter <- c("Lung")
  cancer.data.lung %>% filter(cancer %in% lung_filter) -> cancer.data.lung
  boxplot_by_gender(cancer.data.lung, "Lung")
  boxplot_by_population(cancer.data.lung, "Lung")
  
  cancer.data.urinarybladder = read_csv("../../MCA-Cancer/data/mock_outliers.csv")
  cancer.data.urinarybladder = cancer.data.urinarybladder[,2:5]
  bladder_filter <- c("Urinary Bladder")
  cancer.data.urinarybladder %>% filter(cancer %in% bladder_filter) -> cancer.data.urinarybladder
  boxplot_by_gender(cancer.data.urinarybladder, "Urinary Bladder")
  boxplot_by_population(cancer.data.urinarybladder, "Urinary Bladder")
  
  cancer.data.prostate = read_csv("../../MCA-Cancer/data/mock_outliers.csv")
  cancer.data.prostate = cancer.data.prostate[,2:5]
  prostate_filter <- c("Prostate")
  cancer.data.prostate %>% filter(cancer %in% prostate_filter) -> cancer.data.prostate
  boxplot_by_gender(cancer.data.prostate, "Prostate")
  boxplot_by_population(cancer.data.prostate, "Prostate")
  
  cancer.data.breast = read_csv("../../MCA-Cancer/data/mock_outliers.csv")
  cancer.data.breast = cancer.data.breast[,2:5]
  breast_filter <- c("Breast")
  cancer.data.breast %>% filter(cancer %in% breast_filter) -> cancer.data.breast
  boxplot_by_gender(cancer.data.breast, "Breast")
  boxplot_by_population(cancer.data.breast, "Breast")
}


#Calculate the outliers using Box Plot technique
find_outliers()