#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname $SCRIPT_PATH)

GO_VERSION="1.17.5"
GOSDK_URL="https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"

APT_PKGS="curl
build-essential
git
gdb
htop
tmux
less
cloc
python3-pip
"

export DOCKER_BUILDKIT=1

TAG="go${GO_VERSION}"

( cd $BASE_DIR &&
  docker build -t zjia/go-dev:$TAG \
    --build-arg "EXTRA_APT_PKGS=${APT_PKGS}" \
    --build-arg "GOSDK_URL=${GOSDK_URL}" \
    -f Dockerfile . )

docker push zjia/go-dev:$TAG
