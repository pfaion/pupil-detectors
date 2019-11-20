#!/bin/bash
set -ev

# NOTE: Remove all unnecessary stuff (install files etc.) since we want to cache the
# dependencies and keep the cache small.

mkdir -p dependencies
cd dependencies

# Opencv
wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.5.zip
unzip -q opencv.zip
cd opencv-3.4.5
mkdir -p build
cd build
# Turn off all GUI frameworks, since they won't work on travis anyways.
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
    -G"Visual Studio 15 2017 Win64"
cmake --build . --config Release --target ceres
cmake --install .
cd ..
rm -rf ceres-solver.tar.gz
rm -rf ceres-solver-1.14.0

cd ..
