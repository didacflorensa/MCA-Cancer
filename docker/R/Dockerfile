# Base image https://hub.docker.com/u/rocker/
FROM rocker/rstudio

COPY ./r-scripts/requeriments.R /tmp/requeriments.R
RUN Rscript  /tmp/requeriments.R

# create an R user
ENV USER rstudio

## Copy your working files over
COPY ./results /home/$USER/Results
COPY ./data /home/$USER/Data
COPY ./r-scripts /home/$USER/r-scripts