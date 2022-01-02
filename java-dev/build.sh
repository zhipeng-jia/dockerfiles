#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname $SCRIPT_PATH)

MAVEN_VERSION="3.8.4"
MAVEN_URL="https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz"

export DOCKER_BUILDKIT=1

( cd $BASE_DIR &&
  docker build -t zjia/java-dev:jdk11 \
    --build-arg "MAVEN_URL=${MAVEN_URL}" \
    --build-arg "MAVEN_VERSION=${MAVEN_VERSION}" \
    -f Dockerfile . )

docker push zjia/java-dev:jdk11
