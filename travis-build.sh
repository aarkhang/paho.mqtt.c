#!/bin/bash

set -ev

rm -rf build.paho
mkdir build.paho
cd build.paho
echo "travis build dir $TRAVIS_BUILD_DIR pwd $PWD"
cmake --version
cmake -S .. \
	-DCMAKE_BUILD_TYPE=$BUILD_TYPE \
	-DPAHO_BUILD_STATIC=$BUILD_STATIC \
	-DPAHO_WITH_SSL=TRUE \
	-DPAHO_BUILD_DOCUMENTATION=FALSE \
	-DPAHO_BUILD_SAMPLES=TRUE
cmake --build . --config $BUILD_TYPE
#python3 ../test/mqttsas.py &
#ctest -VV --timeout 600
#cpack --verbose
#kill %1
#killall mosquitto
