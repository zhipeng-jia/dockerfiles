#!/bin/bash

mkdir ~/go

echo "export GOROOT=/usr/local/go" >> ~/.profile
echo "export GOPATH=\$HOME/go" >> ~/.profile
echo "export PATH=\$PATH:\$GOROOT/bin:\$HOME/bin:\$GOPATH/bin" >> ~/.profile
