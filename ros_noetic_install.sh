#!/usr/bin/bash

# Setup source.list
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

# Setup keys
sudo apt install -y curl # if you haven't already installed curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

# Update source
sudo apt update

# Install ros
sudo apt install ros-noetic-desktop-full

# Setup Environment
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

# Dependencies for building packages
sudo apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential

sudo apt install python3-rosdep

sudo rosdep init
rosdep update

# Install the complete prompt
sudo apt install python3-argcomplete
