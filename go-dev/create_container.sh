#!/bin/bash

GO_VERSION="1.17.5"
GODEV_ROOT=$HOME/go-dev
USERNAME=devuser

docker create \
    --name go-dev \
    --hostname excalibur-go-dev \
    -p 20022:22 \
    -e SSH_PUBKEY="$(cat ~/.ssh/id_rsa.pub)" \
    -v ${GODEV_ROOT}/workspace:/home/${USERNAME}/workspace \
    -v ${GODEV_ROOT}/gopath:/home/${USERNAME}/go \
    -v ${GODEV_ROOT}/vscode:/home/${USERNAME}/.vscode-server \
    zjia/go-dev:go${GO_VERSION}
