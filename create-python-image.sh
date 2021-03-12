#!/usr/bin/env bash

docker rm -f python-computing-service

docker rmi python-computing-servicee

docker build -t python-computing-service -f docker/Python/Dockerfile .
