# Ph.D Repository

## About

* **Author**: Didac Florensa Cazorla
* **PH.D supervisors**:
  * Jordi Mateo Fornés <jordi.mateo@udl.cat>, @github/JordiMateoUdL
  * Francesc Solsona Tehàs <francesc.solsona@udl.cat>
  * Pere Godoy

## This repository

This repository contains all the code, scripts and services builed in the context of my Ph.D Studies. Inside this repository you will find:

* _data_: This folder contains mock data to use and understand the tools developed. This is not the data used in my research, I can not publish raw data for logical reasons.
* _docker_: This folder contains the required container to deploy the scripts. Alternatively, you can install R, python or jupyter or shinny in your personal laptop or server and run them in a more traditional way.
* _results_: This folder is need by the containers to store inside the results.
* _r-scripts_: This folder is need by 
* _jupyter-notebools_: This folder is need by t
* _python-scripts_: This folder is need by 

## Using the R server

First of all, you need to build the custom image to deploy the container in docker environment:

```sh
chmod +x create-r-image.sh
./create-r-image
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
## Analysis technique
* MCA (Multiple Correspondence Analysis): Used when the dataset contains more than 2 categorical variables
* MFA (Multiple Factor Analysis): Used when the dataset has groups of categorical or numerical numbers
* FAMD (Factor Analysis Mixed Data): Used when the dataset has both categorical and numerical numbers