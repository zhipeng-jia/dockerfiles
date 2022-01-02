#!/bin/bash

RUSTDEV_ROOT=$HOME/rust-dev
USERNAME=devuser

docker create \
    --name rust-dev \
    --hostname excalibur-rust-dev \
    -p 30022:22 \
    -e SSH_PUBKEY="$(cat ~/.ssh/id_rsa.pub)" \
    -v ${RUSTDEV_ROOT}/workspace:/home/${USERNAME}/workspace \
    -v ${RUSTDEV_ROOT}/rustup:/home/${USERNAME}/.rustup \
    -v ${RUSTDEV_ROOT}/cargo:/home/${USERNAME}/.cargo \
    -v ${RUSTDEV_ROOT}/vscode:/home/${USERNAME}/.vscode-server \
    zjia/rust-dev:latest
