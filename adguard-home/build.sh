#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname $SCRIPT_PATH)
TAG=0.102.0

( cd $BASE_DIR && 
  docker build -t zjia/adguard-home:$TAG . )

docker tag zjia/adguard-home:$TAG zjia/adguard-home:latest
docker push zjia/adguard-home:$TAG
docker push zjia/adguard-home:latest
