#!/bin/bash

set -x
if [ ! -d boost-root ]; then
  git clone -b master https://github.com/boostorg/boost.git boost-root
fi

#these steps are specific to nudb
git submodule update --init doc/docca
cd doc
chmod 755 makeqbk.sh
./makeqbk.sh
cd ..

cd boost-root
git pull
export BOOST_ROOT=$(pwd)
git submodule update --init libs/context
git submodule update --init tools/boostbook
git submodule update --init tools/boostdep
git submodule update --init tools/docca
git submodule update --init tools/quickbook

#2020-05-13 for nudb
git submodule update --init libs/beast

rsync -av --exclude boost-root ../ libs/nudb
python tools/boostdep/depinst/depinst.py ../tools/quickbook
./bootstrap.sh
./b2 headers

echo "using doxygen ; using boostbook ; using saxonhe ;" > tools/build/src/user-config.jam

cp boost/beast/_experimental/unit_test/main.ipp boost/beast/_experimental/unit_test/main.cpp
#./b2 -j3 libs/nudb/doc//boostrelease | tee output4.txt 2>&1
#2020-05-13

#The final step, let's wait
#./b2 -j3 libs/nudb/doc//boostdoc 


