FROM quay.io/pypa/manylinux2010_x86_64

### Install OpenCV
# NOTE: There's no centOS package for opencv 3, so we have to build from source
RUN yum -y install wget
# NOTE: 3.4.5 has a bug and won't compile here, using 3.4.6 instead
RUN wget https://github.com/opencv/opencv/archive/3.4.6.zip
RUN unzip 3.4.6.zip
RUN cd opencv-3.4.6 \
    && mkdir -p build \
    && cd build \
    && cmake -DCMAKE_BUILD_TYPE=Release -DWITH_TBB=ON -DWITH_CUDA=OFF -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_LIST=core,highgui,videoio,imgcodecs,imgproc,video .. \
    && make -j8 \
    && make install
# Cleanup
RUN rm -f 3.4.6.zip
RUN rm -rf opencv-3.4.6

### Install Eigen
RUN yum -y install eigen3-devel

### Install ceres
RUN yum -y install http://repo.okay.com.mx/centos/6/x86_64/release/okay-release-1-1.noarch.rpm
RUN yum -y install glog-devel
RUN yum -y install ceres-solver-devel
