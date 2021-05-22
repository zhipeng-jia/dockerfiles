#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname $SCRIPT_PATH)

( cd $BASE_DIR &&
  DOCKER_BUILDKIT=1 docker build -t zjia/java-dev:jdk8-idea  -f Dockerfile.jdk8 . &&
  DOCKER_BUILDKIT=1 docker build -t zjia/java-dev:jdk11-idea -f Dockerfile.jdk11 . )

docker push zjia/java-dev:jdk8-idea
docker push zjia/java-dev:jdk11-idea
