#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname $SCRIPT_PATH)
TAG=0.34.1

( cd $BASE_DIR &&
  docker build -t zjia/dnsproxy:$TAG-arm64 -f Dockerfile.arm64 . )

docker push zjia/dnsproxy:$TAG-arm64
