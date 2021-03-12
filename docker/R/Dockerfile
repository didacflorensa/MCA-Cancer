# Base image https://hub.docker.com/u/rocker/
FROM rocker/rstudio

#COPY ./r-scripts/requeriments.R /tmp/requeriments.R
#RUN Rscript  /tmp/requeriments.R

# Install the packages needed to run the R code correctly
RUN R -e "install.packages('FactoMineR')"
RUN R -e "install.packages('factoextra')"
RUN R -e "install.packages('ggplot2')"
RUN R -e "install.packages('readr')"
RUN R -e "install.packages('plotly')"

# create an R user
ENV USER rstudio

## Copy your working files over
COPY ./results /home/$USER/Results
COPY ./data /home/$USER/Data
COPY ./r-scripts /home/$USER/r-scripts
