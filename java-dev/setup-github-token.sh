#!/bin/bash

if [[ -n ${GITHUB_USERNAME} && -n ${GITHUB_ACCESS_TOKEN} ]]; then
    git config --global credential.helper store
    touch $HOME/.git-credentials
    echo "https://${GITHUB_USERNAME}:${GITHUB_ACCESS_TOKEN}@github.com" >> $HOME/.git-credentials
fi

sleep infinity
