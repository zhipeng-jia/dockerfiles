#!/bin/bash

JAVADEV_ROOT=$HOME/java-dev
USERNAME=devuser

docker create \
    --name java-dev \
    --hostname excalibur-java-dev \
    -p 10022:22 \
    -e SSH_PUBKEY="$(cat ~/.ssh/id_rsa.pub)" \
    -v ${JAVADEV_ROOT}/workspace:/home/${USERNAME}/workspace \
    -v ${JAVADEV_ROOT}/repository/m2:/home/${USERNAME}/.m2 \
    -v ${JAVADEV_ROOT}/repository/gradle:/home/${USERNAME}/.gradle \
    -v ${JAVADEV_ROOT}/JetBrains/config:/home/${USERNAME}/.config/JetBrains \
    -v ${JAVADEV_ROOT}/JetBrains/cache:/home/${USERNAME}/.cache/JetBrains \
    -v ${JAVADEV_ROOT}/JetBrains/plugin:/home/${USERNAME}/.local/share/JetBrains \
    zjia/java-dev:jdk11
