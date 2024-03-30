#!/usr/bin/bash

sudo apt update
sudo apt install -y openocd
sudo apt install -y stlink-tools

wget https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz\?rev\=e434b9ea4afc4ed7998329566b764309\&hash\=CA590209F5774EE1C96E6450E14A3E26 -O arm-none-eabi.tar.xz

echo "Please choose the position to install (recommend and default : /opt/arm_toolchain)"
read path_to_install

if [ -z $path_to_install ]; then
	path_to_install=/opt/arm_toolchain

tar -xf arm-none-eabi.tar.xz
target=$(ls | grep arm-gnu)
sudo mv $target $path_to_install

echo "Do you want to setup the environment ?"
echo -e "\e[31mAttention !\e[0m" "This step only works when the installation path is '/opt/arm_toolchain'"
read -p "(yes/no)" is_setup

if [ $is_setup == "yes" ]; then
	read -p "Your Shell ([bash]/zsh/fish) : " self_shell
	if [ -z $self_shell ]; then
		self_shell=bash
	fi

	if [ $self_shell != "fish" ]; then
		rc=rc
		echo "export PATH=$path_to_install:$PATH" >> ~/.$self_shell$rc
	else
		echo "set PATH $path_to_install $PATH" >> ~/.config/fish/config.fish
	fi

else
	echo "You need to add the 'path_to_arm/bin/'  to the PATH"
fi

echo "Do you want to clean the packages ?"
read -p "(yes/no)" is_clean

if [ $is_clean == "yes" ]; then
	rm -r arm-none-eabi.tar.xz

echo "You can check the installation by : "
echo "arm-none-eabi-gcc --version"
echo "Have a good time with arm_toolchian !"
