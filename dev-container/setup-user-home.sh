#!/bin/bash

mkdir ~/.ssh
touch ~/.ssh/authorized_keys

echo "export LC_ALL=en_US.UTF-8" >> ~/.profile
echo "export EDITOR=nano" >> ~/.profile

mkdir ~/bin

mkdir ~/.cache
mkdir ~/.config

mkdir ~/.local
mkdir ~/.local/bin
mkdir ~/.local/lib
mkdir ~/.local/share
