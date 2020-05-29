#!/bin/bash

cd boost-root
export BOOST_ROOT=$(pwd)

#./b2 -j3 libs/nudb/doc//boostrelease | tee output4.txt 2>&1
#2020-05-13
./b2 -j3 libs/nudb/doc//boostdoc | tee output4.txt 2>&1


