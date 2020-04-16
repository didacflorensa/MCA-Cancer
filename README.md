
About
-----

Author: Didac Florensa Cazorla
PH.D supervisors:
* Jordi Mateo Fornés <jordi.mateo@udl.cat>, #JordiMateoUdL
* Francesc Solsona Tehàs
* Pere Godoy

This repository
---------------

This repository contains all the code, scripts and services builed in the context of my Ph.D Studies. Inside this repository you will find:

* data: This folder contains mock data to use and understand the tools developed. This is not the data used in my research, I can not publish raw data for logical reasons.
* docker: This folder contains the required container to deploy the scripts. Alternatively, you can install R, python or jupyter or shinny in your personal laptop or server and run them in a more traditional way.
* results: This folder is need by the containers to store inside the results. 

Using the R server
----------------

First of all, you need to build the custom image to deploy the container in docker environment:

```sh
chmod +x create-image.sh
./create-image
```

Execute the container that will act as a docker-server:

* Using default values:

```sh
sudo docker run -d --rm -p 28787:8787 -e PASSWORD=123456! --name r-computing-service rstudio/r-computing-service
```

* Using custom values:

```sh
sudo docker run -d --rm -p 28787:8787 -e PASSWORD=123456! -e SCRIPTS_DIR "path to folder with requirements.R and *.R scripts" -e DATA_DIR "path data folder" -e RESULTS_DIR "path to result folder" --name r-computing-service rstudio/r-computing-service
```

* Use the navigator to visit </yourhostip:28787>, if you run in your laptop 127.0.0.1

* At the end, you can stop the container and remove it, using:

```sh
sudo docker stop r-computing-service
sudo docker rm r-computing-service
```