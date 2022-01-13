#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname $SCRIPT_PATH)

GO_VERSION="1.17.6"
GOSDK_URL="https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"

export DOCKER_BUILDKIT=1

TAG="go${GO_VERSION}"

( cd $BASE_DIR &&
  docker build -t zjia/go-dev:$TAG \
    --build-arg "GOSDK_URL=${GOSDK_URL}" \
    -f Dockerfile . )

docker push zjia/go-dev:$TAG
