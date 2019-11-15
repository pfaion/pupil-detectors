wget -O eigen3.zip https://bitbucket.org/eigen/eigen/get/3.3.3.zip
unzip -q eigen3.zip
mv eigen-eigen-* eigen

# wget -O gflags.zip https://github.com/gflags/gflags/archive/v2.2.2.zip
# unzip -q gflags.zip
# cd gflags-2.2.2
# cmake . \
#     -DCMAKE_INSTALL_PREFIX=../gflags \
#     -DCMAKE_GENERATOR_PLATFORM=x64 \
#     -T host=x64
# cmake --build . --config Release
# cmake --install .
# cd ..

wget -O glog.zip https://github.com/google/glog/archive/v0.4.0.zip
unzip -q glog.zip
cd glog-0.4.0
cmake . \
    -DCMAKE_INSTALL_PREFIX=../glog \
    -DCMAKE_GENERATOR_PLATFORM=x64 \
    -T host=x64 \
    -DBUILD_TESTING=OFF
cmake --build . --config Release --target INSTALL
cd ..


wget -O ceres-solver.tar.gz http://ceres-solver.org/ceres-solver-1.14.0.tar.gz
tar -xzf ceres-solver.tar.gz
cd ceres-solver-1.14.0
cmake . \
    -DCMAKE_INSTALL_PREFIX=../ceres-solver \
    -DEIGEN_INCLUDE_DIR_HINTS=../eigen \
    -DGLOG_INCLUDE_DIR_HINTS=../glog/include \
    -DGLOG_LIBRARY_DIR_HINTS=../glog/lib \
    -DCERES_USE_OPENMP=ON \
    -DBUILD_TESTING=OFF \
    -DBUILD_EXAMPLES=OFF \
    -DCMAKE_GENERATOR_PLATFORM=x64 \
    -T host=x64
cmake --build . --config Release --target ceres
cmake --install .
