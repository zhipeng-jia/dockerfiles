#!/bin/bash

mkdir ~/.ssh
touch ~/.ssh/authorized_keys

echo "export LC_ALL=en_US.UTF-8" >> ~/.profile

echo "export EDITOR=nano" >> ~/.profile

mkdir ~/bin
mkdir ~/go

echo "export GOROOT=/opt/go" >> ~/.profile
echo "export GOPATH=\$HOME/go" >> ~/.profile
echo "export PATH=\$PATH:\$GOROOT/bin:\$HOME/bin:\$GOPATH/bin" >> ~/.profile

mkdir -p ~/.cache
mkdir -p ~/.config
mkdir -p ~/.local/share
