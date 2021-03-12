#!/usr/bin/env bash

docker rm -f r-computing-service

docker rmi r-computing-servicee

docker build -t r-computing-service -f docker/R/Dockerfile .
