#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname $SCRIPT_PATH)
TAG=4.23.1

( cd $BASE_DIR && 
  docker build -t zjia/v2ray-core:$TAG . )

docker tag zjia/v2ray-core:$TAG zjia/v2ray-core:latest
docker push zjia/v2ray-core:$TAG
docker push zjia/v2ray-core:latest
