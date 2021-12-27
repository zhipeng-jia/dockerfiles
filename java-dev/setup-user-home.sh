#!/bin/bash

mkdir ~/.ssh
touch ~/.ssh/authorized_keys

echo "export LC_ALL=en_US.UTF-8" >> ~/.profile

echo "export EDITOR=nano" >> ~/.profile

if [ -n ${JAVA_HOME} ]; then
    echo "export JAVA_HOME=${JAVA_HOME}" >> ~/.profile
fi

mkdir ~/bin
echo "export PATH=\$PATH:\$HOME/bin" >> ~/.profile
if [ -n ${MAVEN_PATH} ]; then
    ln -sf ${MAVEN_PATH}/bin/mvn ~/bin/mvn
fi

mkdir -p ~/.cache
mkdir -p ~/.config
mkdir -p ~/.local/share
