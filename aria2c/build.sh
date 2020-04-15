#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname $SCRIPT_PATH)
TAG=1.35.0

( cd $BASE_DIR && 
  docker build -t zjia/aria2c:$TAG . )

docker tag zjia/aria2c:$TAG zjia/aria2c:latest
docker push zjia/aria2c:$TAG
docker push zjia/aria2c:latest
