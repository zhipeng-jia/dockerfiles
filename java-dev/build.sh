#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname $SCRIPT_PATH)

JDK8_DEB_URL="https://corretto.aws/downloads/latest/amazon-corretto-8-x64-linux-jdk.deb"
JDK11_DEB_URL="https://corretto.aws/downloads/latest/amazon-corretto-11-x64-linux-jdk.deb"
MAVEN_URL="https://downloads.apache.org/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.tar.gz"

export DOCKER_BUILDKIT=1

( cd $BASE_DIR &&
  docker build -t zjia/java-dev:jdk8-idea \
    --build-arg "JDK_DEB_URL=${JDK8_DEB_URL}" \
    --build-arg "JAVA_HOME=/usr/lib/jvm/java-1.8.0-amazon-corretto" \
    --build-arg "MAVEN_URL=${MAVEN_URL}" \
    -f Dockerfile . )

docker push zjia/java-dev:jdk8-idea

( cd $BASE_DIR &&
  docker build -t zjia/java-dev:jdk11-idea \
    --build-arg "JDK_DEB_URL=${JDK11_DEB_URL}" \
    --build-arg "JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto" \
    --build-arg "MAVEN_URL=${MAVEN_URL}" \
    -f Dockerfile . )

docker push zjia/java-dev:jdk11-idea
