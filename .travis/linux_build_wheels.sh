#!/bin/bash

# roughly adjusted from the official manylinux build example:
# https://github.com/pypa/python-manylinux-demo/blob/master/travis/build-wheels.sh

set -e -x
PLAT=manylinux2010_x86_64

# Use python 3.6
export PATH=/opt/python/cp36-cp36m/bin:$PATH

# Compile wheel
pip wheel --no-deps /io/ -w wheelhouse/

# Bundle external shared libraries into the wheel
auditwheel repair wheelhouse/*.whl --plat $PLAT -w /io/wheelhouse/

# run tests
pip install tox
cd /io
tox --installpkg ./wheelhouse/*.whl
