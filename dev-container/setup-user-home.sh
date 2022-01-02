#!/bin/bash

mkdir ~/.ssh
touch ~/.ssh/authorized_keys

echo "export LC_ALL=en_US.UTF-8" >> ~/.profile

echo "export EDITOR=nano" >> ~/.profile

mkdir ~/bin
echo "export PATH=\$PATH:\$HOME/bin" >> ~/.profile

mkdir -p ~/.cache
mkdir -p ~/.config
mkdir -p ~/.local/share
