#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname $SCRIPT_PATH)
TAG=1.17.9

( cd $BASE_DIR && 
  docker build -t zjia/nginx:$TAG . )

docker tag zjia/nginx:$TAG zjia/nginx:latest
docker push zjia/nginx:$TAG
docker push zjia/nginx:latest
