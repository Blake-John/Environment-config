#!/usr/bin/bash

echo "Now we are going to install miniconda ... "

if [ -e /opt/miniconda3 ]; then
	echo "Miniconda has been installed !"
else
	echo "You can press q to quit the license"
	echo "The recommended location to install miniconda3 is /opt/miniconda3"

	if [ -e Miniconda3-latest-Linux-x86_64.sh ]; then
		sudo bash Miniconda3-latest-Linux-x86_64.sh
	elif [ -e miniconda3.sh ]; then
		sudo bash miniconda3.sh
	else
		wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda3.sh
		sudo bash miniconda3.sh
	fi
fi

echo "Do you want to set the environment ?"
echo -e "\e[31mAttention!\e[0m" "This step only works when your installation path is '/opt/miniconda3'"
echo "If your installation path is not '/opt/miniconda3', you need to choose 'no' and set up your environment by yourself"
read -p "(yes/no) " is_setup

if [ $is_setup == "yes" ]; then
	read -p "Your Shell ([bash]/zsh/fish) " self_shell
	if [ -z $self_shell ]; then
		self_shell=bash
	fi

	/opt/miniconda3/bin/conda init $self_shell

	read -p "Do you want to disable auto activating base? (yes/no) " is_autodisable
	if [ $is_autodisable == "yes" ]; then
		 /opt/miniconda3/bin/conda config --set auto_activate_base false
	else
		echo "You can disable the auto activating base by : "
		echo "conda config --set auto_activate_base false"
		echo 
	fi
else
	echo "You need to set you environment by : "
	echo 
	echo "path_to_miniconda/bin/conda init <your shell>"
fi

echo -e "\e[32mMiniconda is installed successfully !\e[0m"
echo "Have a good time with conda !"
