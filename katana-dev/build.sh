#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname $SCRIPT_PATH)
TAG=focal

( cd $BASE_DIR &&
  DOCKER_BUILDKIT=1 docker build -t zjia/katana-dev:$TAG . )

docker push zjia/katana-dev:$TAG
