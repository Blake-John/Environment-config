#!/usr/bin/bash

app_install() {
	case $1 in
		(vscode)
			wget -c https://code.visualstudio.com/sha/download\?build\=stable\&os\=linux-deb-x64 -O vscode.deb
			sudo dpkg -i vscode.deb
			;;

		(obsidian)
			wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.5.11/obsidian_1.5.11_amd64.deb -O obsidian.deb
			sudo dpkg -i obsidian.deb
			;;

		(miniconda3)
			if [ -f /opt/miniconda3 ]; then
				echo "Miniconda3 has beed installed !"
			else
				echo "You can press q to quit the license"
				echo "The recommended location to install miniconda3 is /opt/miniconda3"
				
				if [ -e Miniconda3-latest-Linux-x86_64.sh ] || [ -e miniconda3.sh ]; then
					echo "sh file exist"
				else
					wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda3.sh
				fi

				sudo bash miniconda3.sh
			fi
			;;

		(todesk)
			wget https://dl.todesk.com/linux/todesk-v4.7.2.0-amd64.deb -O todesk.deb
			sudo dpkg -i todesk.deb
			;;

		(qq)
			wget https://dldir1.qq.com/qqfile/qq/QQNT/Linux/QQ_3.2.6_240322_amd64_01.deb -O qq.deb
			sudo dpkg -i qq.deb
			;;

		(nutstore)
			sudo apt install gir1.2-appindicator3-0.1 gir1.2-ayatanaappindicator3-0.1
			wget https://www.jianguoyun.com/static/exe/installer/ubuntu/nautilus_nutstore_amd64.deb -O nutstore.deb
			sudo dpkg -i nutstore.deb
			;;

		(clion)
			sudo snap install clion --classic
			;;

		(pycharm)
			pycharm_type=none
			while [ $pycharm_type != "Community" ] && [ $pycharm_type != "Professional" ]; do
				read -p "Community or Professional : " pycharm_type
			done
			
			if [ $pycharm_type == "Community" ]; then
				sudo snap install pycharm-community --classic
			else
				sudo snap install pycharm-professional --classic
			fi
			;;
	esac
}


tool_list=(vscode obsidian miniconda3 todesk qq nutstore clion pycharm)
to_install=()
condition=none

echo "Welcome to tool installation !"
echo "You can use this script to install ${tool_list[*]}"

# choose the tools to be installed
for app in ${tool_list[*]}; do
	echo "Do you want to install $app ?"
	while [ $condition != "yes" ] && [ $condition != "no" ]; do
		read -p "(yes/no) " condition
	done
	if [ $condition == "yes" ]; then
		to_install+=($app)
	fi
	condition=none
done


echo "Clean the packages after installation ?"
read -p "(yes/no) " is_clean


echo "Now, we are going to install ${to_install[*]} ..."


count=0
for installapp in ${to_install[*]}; do
	echo -e "\e[36mStep $count : Installing $installapp ...\e[0m"
	count=$(($count + 1))
	app_install $installapp
	echo -e "\e[32mSuccessfully install $installapp !\e[0m"
done


if [ $is_clean == "yes" ]; then
	echo "Cleaning the packages ..."
	for cleanapp in ${to_install[*]}; do
		rm $cleanapp*
	done
fi


echo "Succeed to install ${#to_install[@]} packages !"
echo "Have a good experience with these tools !"

# # vscode
# wget https://code.visualstudio.com/sha/download\?build\=stable\&os\=linux-deb-x64 -O vscode.deb
# sudo dpkg -i vscode.deb
# 
# # obsidian
# wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.5.11/obsidian_1.5.11_amd64.deb -O obsidian.deb
# sudo dpkg -i obsidian.deb
# 
# # todesk
# wget https://dl.todesk.com/linux/todesk-v4.7.2.0-amd64.deb -O todesk.deb
# sudo dpkg -i todesk.deb
# 
# # miniconda3
# wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda3_install.sh
# sudo bash miniconda3_install.sh
# 
# # QQ
# wget https://dldir1.qq.com/qqfile/qq/QQNT/Linux/QQ_3.2.6_240322_amd64_01.deb -O QQ.deb
# sudo dpkg -i QQ.deb
#
# nutstore
# sudo apt install gir1.2-appindicator3-0.1 gir1.2-ayatanaappindicator3-0.1
# wget https://www.jianguoyun.com/static/exe/installer/ubuntu/nautilus_nutstore_amd64.deb -O nutstore.deb
# sudo dpkg -i nutstore.deb
