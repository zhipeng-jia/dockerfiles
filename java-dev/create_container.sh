#!/bin/bash

JAVADEV_ROOT=$HOME/java-dev

docker create \
    --name java-dev \
    --hostname excalibur-java-dev \
    -p 10022:22 \
    -e SSH_PUBKEY="$(cat ~/.ssh/id_rsa.pub)" \
    -v ${JAVADEV_ROOT}/workspace:/home/ubuntu/workspace \
    -v ${JAVADEV_ROOT}/repository/m2:/home/ubuntu/.m2 \
    -v ${JAVADEV_ROOT}/repository/gradle:/home/ubuntu/.gradle \
    -v ${JAVADEV_ROOT}/JetBrains/config:/home/ubuntu/.config/JetBrains \
    -v ${JAVADEV_ROOT}/JetBrains/cache:/home/ubuntu/.cache/JetBrains \
    -v ${JAVADEV_ROOT}/JetBrains/plugin:/home/ubuntu/.local/share/JetBrains \
    zjia/java-dev:jdk11
