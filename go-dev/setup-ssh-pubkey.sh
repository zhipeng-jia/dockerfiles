#!/bin/bash

if [ -n "${SSH_PUBKEY}" ]; then
    echo "${SSH_PUBKEY}" > ~/.ssh/authorized_keys
    exit 0
fi

if [ -f /etc/container_environment/SSH_PUBKEY ]; then
    cat /etc/container_environment/SSH_PUBKEY > ~/.ssh/authorized_keys
    exit 0
fi

if [ -f /tmp/id_rsa.pub ]; then
    cat /tmp/id_rsa.pub > ~/.ssh/authorized_keys
    exit 0
fi

exit 1
