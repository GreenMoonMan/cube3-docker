#! /bin/bash

set -e

# activate venv manually so we can install stuff to it
source venv/bin/activate
# install conan
echo $PATH
echo $VIRTUAL_ENV
pip install "conan>=2.2.2"

# install libhal with conan
conan remote add libhal-trunk https://libhal.jfrog.io/artifactory/api/conan/trunk-conan
conan config install -sf profiles/baremetal/v2 https://github.com/libhal/conan-config.git
conan profile detect --force
conan config install -sf profiles/x86_64/linux/ -tf profiles https://github.com/libhal/conan-config.git

# add arm profiles
conan config install -sf conan/profiles/v1 -tf profiles https://github.com/libhal/libhal-arm-mcu.git
conan config install -sf conan/profiles/v1 -tf profiles https://github.com/libhal/arm-gnu-toolchain.git

# install flashing utility
pip install nxpprog
