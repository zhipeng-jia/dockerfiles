#!/bin/bash

if [ -f /home/${DEVUSER}/.cargo/bin/rustup ]; then
    exit 0
fi

wget -O /tmp/rustup-init.sh https://sh.rustup.rs
chmod +x /tmp/rustup-init.sh

sudo -u ${DEVUSER} -H \
    /tmp/rustup-init.sh -q -y --no-modify-path

rm /tmp/rustup-init.sh
