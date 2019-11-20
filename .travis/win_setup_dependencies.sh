#!/bin/bash
set -ev

# NOTE: Remove all unnecessary stuff (install files etc.) since we want to cache the
# dependencies and keep the cache small.

mkdir -p dependencies
cd dependencies

Opencv
wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.5.zip
unzip -q opencv.zip
cd opencv-3.4.5
mkdir -p build
cd build
cmake ..\
    -DCMAKE_BUILD_TYPE=Release\
    -DBUILD_LIST=core,highgui,videoio,imgcodecs,imgproc,video\
    -DBUILD_opencv_world=ON\
    -DWITH_WIN32UI=OFF\
    -DWITH_DSHOW=OFF\
    -DWITH_MSMF=OFF\
    -DWITH_DIRECTX=OFF\
    -DCMAKE_INSTALL_PREFIX=../../opencv\
    -G"Visual Studio 15 2017 Win64"
cmake --build . --target INSTALL --config Release
cd ../..
rm -rf opencv.zip
rm -rf opencv-3.4.5

# # Opencv
# # Downloading the precompiled installer for windows and executing via cmd is actually
# # faster than compiling yourself. Note: The .exe is a 7-zip self extracting archive,
# # which explains the non-exe-standard cli argument -y. See here:
# # https://sevenzip.osdn.jp/chm/cmdline/switches/sfx.htm
# wget https://sourceforge.net/projects/opencvlibrary/files/3.4.5/opencv-3.4.5-vc14_vc15.exe
# ./opencv-3.4.5-vc14_vc15.exe -y
# mv opencv opencvfull
# mv opencvfull/build opencv
# rm -rf opencvfull
# rm -rf opencv-3.4.5-vc14_vc15.exe

# Eigen3
wget -O eigen3.zip https://bitbucket.org/eigen/eigen/get/3.3.3.zip
unzip -q eigen3.zip
mv eigen-eigen-* eigen
rm -rf eigen3.zip

# Ceres with Miniglog
# Although glog is recommended, it is way more complicated to setup and needs a separate
# compilation. Ceres ships with Miniglog, which is a replacement for glog on Android,
# but can also be used on Windows.
wget -O ceres-solver.tar.gz http://ceres-solver.org/ceres-solver-1.14.0.tar.gz
tar -xzf ceres-solver.tar.gz
cd ceres-solver-1.14.0
cmake .\
    -DCMAKE_INSTALL_PREFIX=../ceres-solver\
    -DEIGEN_INCLUDE_DIR_HINTS=../eigen\
    -DMINIGLOG=ON\
    -DCERES_USE_OPENMP=ON\
    -DBUILD_TESTING=OFF\
    -DBUILD_EXAMPLES=OFF\
    -DSCHUR_SPECIALIZATIONS=OFF\
    -G"Visual Studio 15 2017 Win64"
cmake --build . --config Release --target ceres
cmake --install .
cd ..
rm -rf ceres-solver.tar.gz
rm -rf ceres-solver-1.14.0

cd ..
