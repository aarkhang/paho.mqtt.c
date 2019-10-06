#!/bin/bash
set -ev

export MY_BUILD_DIR=build.paho
cmake -E remove_directory $MY_BUILD_DIR
cmake -E make_directory $MY_BUILD_DIR
cd $MY_BUILD_DIR
echo "travis build dir $TRAVIS_BUILD_DIR pwd $PWD"
cmake .. \
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
