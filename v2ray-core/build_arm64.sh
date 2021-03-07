#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname $SCRIPT_PATH)
TAG=4.35.1

( cd $BASE_DIR &&
  docker build -t zjia/v2ray-core:$TAG-arm64 -f Dockerfile.arm64 . )

docker push zjia/v2ray-core:$TAG
docker push zjia/v2ray-core:$TAG-arm64
