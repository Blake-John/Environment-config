#!/usr/bin/bash

# Download the dependencies
sudo apt install -y libgtk2.0-dev libjpeg-dev libpng-dev libavcodec-dev libavformat-dev libswscale-dev libtiff5-dev pkg-config

# choose the version
version=none
while [ $version != "4.7.0" ] && [ $version != "4.8.0" ] && [ $version != "4.9.0" ]; do
	read -p "Please choose the version of the opencv. eg. 4.7.0 " version
done

# Get the opencv.tar.gz
if [ -e opencv-$version.tar.gz ]; then
	echo "Archive file exist"
else
	wget https://github.com/opencv/opencv/archive/refs/tags/$version.tar.gz -O opencv-$version.tar.gz
fi

# Prepare for build
tar -xf opencv-$version.tar.gz
cd opencv-$version
mkdir build
cd build

# Start build
cmake -D BUILD_EXAMPLES=OFF \
	-D BUILD_EXAMPLES=OFF \
	-D BUILD_PERF_TESTS=OFF \
	-D BUILD_TESTS=OFF \
	-D BUILD_opencv_python3=OFF \
	-D BUILD_opencv_python_bindings_generator=OFF \
	-D BUILD_opencv_python_tests=OFF \
	-D BUILD_JAVA=OFF \
	-D BUILD_opencv_java_bindings_generator=OFF \
	-D BUILD_opencv_js=OFF \
	-D BUILD_opencv_js_bindings_generator=OFF \
	-D BUILD_opencv_dnn=ON \
	-D BUILD_opencv_ml=ON \
	-D OPENCV_ENABLE_NONFREE=ON \
	-D ENABLE_FAST_MATH=ON \
	-D WITH_GSTREAMER=ON \
	-D BUILD_SHARED_LIBS=OFF \
	-D CMAKE_BUILD_TYPE=Release \
	..
make -j$nproc

# Install
read -p "Install opencv now ? (yes/no) " is_install
if [ $is_install == "yes" ]; then
	sudo make install
else
	echo "You can install the opencv package by 'sudo make install' in the 'path_to_opencv/build/' "
fi

echo "You can use 'opencv_version' to check the installation, and have a great time with opencv !"
