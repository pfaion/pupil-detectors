# pupil-detectors

This repository contains standalone pupil detectors:

* pupil-labs 2D detector
* pupil-labs 3D detector


## Dependencies

Before you can use pupil-detectors, you will need to install the following dependencies. See below fore more detailed install instructions based on your operating system.

* [OpenCV (v3)](https://opencv.org/about/)
* [Eigen3](http://eigen.tuxfamily.org/)
* [ceres-solver](http://ceres-solver.org/)

### Ubuntu

In Ubuntu 18.04 you can just install everything from apt. For older versions you might have to compile the dependencies from source. See below for more detailed instructions in this case.

```bash
# Install OpenCV
sudo apt install -y libopencv-dev

# Install dependencies for ceres
sudo apt install -y libgoogle-glog-dev libatlas-base-dev libeigen3-dev

# Install ceres
sudo apt install -y libceres-dev
```

#### Building OpenCV from Source
If you are using older versions of Ubuntu (<18.04) you might have to build OpenCV from source.
Here's a snippet from how we build OpenCV in [our Dockerfile for building linux wheels](.docker/manylinux.Dockerfile). Note that this will install OpenCV into `/usr/local` which might or might not be what you want.

```bash
# Download and setup
wget https://github.com/opencv/opencv/archive/3.4.6.zip
unzip 3.4.6.zip
cd opencv-3.4.6
mkdir -p build
cd build

# Build and install
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DBUILD_LIST=core,highgui,videoio,imgcodecs,imgproc,video
make -j8 && make install

# Cleanup
rm -f 3.4.6.zip
rm -rf opencv-3.4.6
```

#### Building Ceres from Source



### macOS



### Prebuilt Wheels
We have prebuilt binaries on PyPI for the most common setups. We included smaller dependencies in the 

```bash
pip install pupil-detectors
```


