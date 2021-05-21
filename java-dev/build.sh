#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname $SCRIPT_PATH)
TAG=idea-community

( cd $BASE_DIR &&
  DOCKER_BUILDKIT=1 docker build -t zjia/java-dev:$TAG . )

docker push zjia/java-dev:$TAG
