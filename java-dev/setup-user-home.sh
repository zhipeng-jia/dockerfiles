#!/bin/bash

if [ -n ${JAVA_HOME} ]; then
    echo "export JAVA_HOME=${JAVA_HOME}" >> ~/.profile
fi

if [ -n ${MAVEN_PATH} ]; then
    ln -sf ${MAVEN_PATH}/bin/mvn ~/bin/mvn
fi
