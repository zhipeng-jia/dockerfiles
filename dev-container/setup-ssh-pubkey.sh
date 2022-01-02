#!/bin/bash

KEYFILE=/home/${DEVUSER}/.ssh/authorized_keys

if [ -n "${SSH_PUBKEY}" ]; then
    echo "${SSH_PUBKEY}" > ${KEYFILE}
    exit 0
fi

if [ -f /etc/container_environment/SSH_PUBKEY ]; then
    cat /etc/container_environment/SSH_PUBKEY > ${KEYFILE}
    exit 0
fi

if [ -f /tmp/id_rsa.pub ]; then
    cat /tmp/id_rsa.pub > ${KEYFILE}
    exit 0
fi

exit 1
