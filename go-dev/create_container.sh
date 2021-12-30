#!/bin/bash

GO_VERSION="1.17.5"
GODEV_ROOT=$HOME/go-dev

docker create \
    --name go-dev \
    --hostname excalibur-go-dev \
    -p 20022:22 \
    -e SSH_PUBKEY="$(cat ~/.ssh/id_rsa.pub)" \
    -v ${GODEV_ROOT}/workspace:/home/ubuntu/workspace \
    -v ${GODEV_ROOT}/gopath:/home/ubuntu/go \
    -v ${GODEV_ROOT}/vscode:/home/ubuntu/.vscode-server \
    zjia/go-dev:go${GO_VERSION}
