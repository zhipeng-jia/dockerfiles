#!/bin/bash

mkdir ~/go

echo "export GOROOT=/usr/local/go" >> ~/.profile
echo "export GOPATH=\$HOME/go" >> ~/.profile
echo "export PATH=\$GOROOT/bin:\$GOPATH/bin:\$PATH" >> ~/.profile
