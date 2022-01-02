#!/bin/bash

SCRIPT_PATH=$(readlink -f $0)
BASE_DIR=$(dirname $SCRIPT_PATH)

APT_PKGS="wget
curl
git
build-essential
g++
gdb
htop
tmux
less
cloc
python3-pip
zip
unzip
vim
cmake
pkg-config
autoconf
automake
libtool
"

export DOCKER_BUILDKIT=1

( cd $BASE_DIR &&
  docker build -t zjia/dev-container:focal \
    --build-arg "EXTRA_APT_PKGS=${APT_PKGS}" \
    -f Dockerfile . )

docker push zjia/dev-container:focal
