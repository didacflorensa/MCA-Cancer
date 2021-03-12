# The Use of Multiple Correspondence Analysis to Explore Associations between Categories of Qualitative Variables and Cancer Incidence

## About

* **Author**: Didac Florensa Cazorla <didac.florensa@udl.cat>
* **PH.D supervisors**:
  * Jordi Mateo Fornés <jordi.mateo@udl.cat>, @github/JordiMateoUdL
  * Francesc Solsona Tehàs <francesc.solsona@udl.cat>
  * Pere Godoy Garcia <pere.godoy@gencat.cat>
* **Collaborators**:
  * Ramon Piñol <rpinol@catsalut.cat>,
  * Miquel Mesas <mmesas@gss.cat>
  * Tere Pedrol <mtpedrol.lleida.ics@gencat.cat>

## Background

Previous works have shown that risk factors for some kinds of cancer depend on people’s lifestyle (e.g. rural or urban residence). This article looks into this seeking relationships between cancer, age group,gender  and  population  in  the  region  of  Lleida  (Catalonia,Spain) using Multiple Correspondence Analysis (MCA).

## This repository

This repository contains all the code, scripts and services built in the context of my Ph.D Studies related with cancer incidence in the region of Lleida. Inside this repository you will find:

* _data_: This folder contains mock data to use and understand the tools developed. This is not the data used in my research, I can not publish raw data for logical reasons.
* _docker_: This folder contains the required container to deploy the scripts. Alternatively, you can install R, python or jupyter or shinny in your personal laptop or server and run them in a more traditional way.
* _results_: This folder is need by the containers to store inside the results.
* _r-scripts_: This folder contains the R scripts with the main functions to calculate the techniques used.
* _python-scripts_: This folder contains the scripts in python to clean and transform data.

## Running python scripts

First of all, you need to build the custom image to deploy the container in docker environment:

```sh
chmod +x create-python-image.sh
./create-python-image.sh
```

Execute the container that will act as a docker-server, for example if we want to clean data:

```sh
docker run --rm  python-computing-service python parse_extraction.py
```

## Using the R server

First of all, you need to build the custom image to deploy the container in docker environment:

```sh
chmod +x create-r-image.sh
./create-r-image.sh
```

Execute the container that will act as a docker-server:

* Using default values:

```sh
sudo docker run -d --rm -p 28787:8787 -e PASSWORD=123456! --name r-computing-service r-computing-service
```

* Using custom values:

```sh
sudo docker run -d --rm -p 28787:8787 -e PASSWORD=123456! -e SCRIPTS_DIR "path to folder with requirements.R and *.R scripts" -e DATA_DIR "path data folder" -e RESULTS_DIR "path to result folder" --name r-computing-service r-computing-service
```

* Use the navigator to visit </yourhostip:28787>, if you run in your laptop 127.0.0.1; with **User**: _rstudio_
  
* At the end, you can stop the container and remove it, using:

```sh
sudo docker stop r-computing-service
sudo docker rm r-computing-service
```

## Installation and use of R-scripts

Install the libraries from CRAN using the RStudio console:
```sh
install.packages("FactoMineR")
install.packages("factoextra")
install.packages("ggplot2")
install.packages("readr")
install.packages("plotly")
```

Use of r-scripts:
* [mca-study.R](r-scripts/mca-study.R): This file search relations between all cancers and qualitative variables using MCA.
* [mca-colonrectum.R](r-scripts/mca-colonrectum.R): This file search relations between Colorectal cancer and qualitative variables using MCA.
* [mca-lung.R](r-scripts/mca-lung.R): This file search relations between Lung cancer and qualitative variables using MCA.
* [mca-prostate.R](r-scripts/mca-prostate.R): This file search relations between Prostate cancer and qualitative variables using MCA.
* [mca-urinarybladder.R](r-scripts/mca-urinarybladder.R): This file search relations between Urinary Bladder cancer and qualitative variables using MCA.
* [mca-breast.R](r-scripts/mca-breast.R): This file search relations between Breast cancer and qualitative variables using MCA.
* [boxplot_technique.R](r-scripts/boxplot_technique.R): This file is used to detect outliers in the data set using the Box Plot technique.

## Analysis technique

* MCA (Multiple Correspondence Analysis): Used when the dataset contains more than 2 categorical variables
* MFA (Multiple Factor Analysis): Used when the dataset has groups of categorical or numerical numbers
* FAMD (Factor Analysis Mixed Data): Used when the dataset has both categorical and numerical numbers
