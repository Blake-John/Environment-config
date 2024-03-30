#!/usr/bin/bash

echo "Now we are going to install miniconda ... "

if [ -f /opt/miniconda3 ]; then
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
	if [ $self_shell != "fish" ]; then
		rc=rc
		echo "export PATH=/opt/miniconda3/bin:$PATH" >> ~/.$self_shell$rc
		source ~/.$self_shell$rc
	else
		echo "set PATH /opt/miniconda3/bin $PATH" >> ~/.config/fish/config.fish
		source ~/.config/fish/config.fish
	fi

	conda init $self_shell
	
	read -p "Do you want to disable auto activating base? (yes/no) " is_autodisable
	if [ $is_autodisable == "yes" ]; then
		conda config --set auto_activate_base false
	else
		echo "You can disable the auto activating base by : "
		echo "conda config --set auto_activate_base false"
		echo 
	fi
else
	echo "If you are bash/zsh user, you can add 'path_to_miniconda/bin' to PATH by :"
	echo "echo \"export PATH=path_to_miniconda/bin:\$PATH\" >> ~/.bashrc"
	echo "or"
	echo "echo \"export PATH=path_to_miniconda/bin:\$PATH\" >> ~/.zshrc"
	echo "If you are fish user, you can : "
	echo "echo \"set PATH path_to_miniconda/bin \$PATH\" >> ~/,config/fish/config.fish"
	echo
	echo "after restart the terminal, you need to initialize the conda by : "
	echo "'conda init <your_shell>'"
	echo "such as 'conda init bash'"
fi

venv_list=(opencv pytorch labelimg tensorflow)

config_venv() {
	if [ $1 == "labelimg" ]; then
		conda create -n labelimg python=3.8
		conda activate labelimg
		pip install labelimg -i https://pypi.tuna.tsinghua.edu.cn/simple
	elif [ $1 == "opencv" ]; then
		conda create -n opencv python=3.10
		conda activate opencv
		pip install opencv-python -i https://pypi.tuna.tsinghua.edu.cn/simple
	elif [ $1 == "pytorch" ]; then
		conda create -n pytorch python=3.10
		conda activate pytorch
		pip install torch -i https://pypi.tuna.tsinghua.edu.cn/simple
	elif [ $1 == "tensorflow" ]; then
		conda create -n tensorflow python=3.9
		conda activate tensorflow
		pip install tensorflow -i https://pypi.tuna.tsinghua.edu.cn/simple
	fi
}

read -p "Do you want to install some virtual environment ? (yes/no) " is_venv

if [ $is_venv == "yes" ]; then
	echo "There are \"${venv_list[*]}\" available."
	condition=none
	for venv in ${venv_list[*]}; do
		echo "Do you want to configure $venv ?"
		while [ $condition != "yes" ] && [ $condition != "no" ]; do
			read -p "Do you want to configure $venv ? (yes/no) " condition
		done
		if [ $condition == "yes" ]; then
			config_venv $venv
		fi
		condition=none
	done
fi

echo "Have a good time with conda !"
