#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname $SCRIPT_PATH)
TAG=0.106.3

( cd $BASE_DIR &&
  DOCKER_BUILDKIT=1 docker build -t zjia/adguard-home:$TAG . )

docker tag zjia/adguard-home:$TAG zjia/adguard-home:latest
docker push zjia/adguard-home:$TAG
docker push zjia/adguard-home:latest
