#!/bin/bash

# see official manylinux build example:
# https://github.com/pypa/python-manylinux-demo/blob/master/travis/build-wheels.sh

set -e -x
PLAT=manylinux2010_x86_64

PATH_ORIG=$PATH
for py in "36" "37"
do
    # Select python
    export PATH="/opt/python/cp${py}-cp${py}m/bin:${PATH_ORIG}"

    # Compile wheel
    pip wheel --no-deps /io/ -w wheelhouse/

    # Bundle external shared libraries into the wheels
    auditwheel repair wheelhouse/*.whl --plat $PLAT -w wheelhouse/test/

    # Run tests
    pip install tox
    tox --installpkg wheelhouse/test/*.whl -c /io/ -e "py${py}"

    # Copy to output and remove tmp
    mkdir -p /io/wheelhouse
    mv wheelhouse/test/*.whl /io/wheelhouse/
    rm -rf wheelhouse
done