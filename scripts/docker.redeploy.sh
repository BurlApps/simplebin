#!/bin/bash

# Stop & Remove Old Containers
bash scripts/docker.kill.sh

# Remove Old Images
docker rmi bvallelunga/enjoypnd 2> /dev/null

# Build New Image
bash scripts/docker.deploy.sh "$1"
