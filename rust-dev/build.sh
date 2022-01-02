#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname $SCRIPT_PATH)

export DOCKER_BUILDKIT=1

( cd $BASE_DIR &&
  docker build -t zjia/rust-dev:latest \
    -f Dockerfile . )

docker push zjia/rust-dev:latest
