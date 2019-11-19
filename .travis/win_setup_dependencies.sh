#!/bin/bash

set -ev

mkdir -p dependencies
cd dependencies

# Eigen3
wget -O eigen3.zip https://bitbucket.org/eigen/eigen/get/3.3.3.zip
unzip -q eigen3.zip
mv eigen-eigen-* eigen
rm -rf eigen3.zip

# Opencv
wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.5.zip
unzip -q opencv.zip
cd opencv-3.4.5
mkdir -p build
cd build
cmake ..\
    -DCMAKE_BUILD_TYPE=Release\
    -DBUILD_LIST=core,highgui,videoio,imgcodecs,imgproc,video\
    -DBUILD_opencv_world=ON\
    -DCMAKE_INSTALL_PREFIX=../../opencv\
    -G"Visual Studio 15 2017 Win64"

cmake --build . --target INSTALL --config Release
cd ../..
rm -rf opencv.zip

# Ceres with Miniglog
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

cd ..
