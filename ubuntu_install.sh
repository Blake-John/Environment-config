#!/usr/bin/bash

sudo apt update
sudo apt upgrade

# the tools for the system
sudo apt install -y vim wget curl git libssl-dev

# remote control
sudo apt install -y ssh openssh-client openssh-server

# development tools
sudo apt install -y gcc g++
sudo apt install -y make cmake cmake-qt-gui ccache
sudo apt install -y libeigen3-dev build-essential
