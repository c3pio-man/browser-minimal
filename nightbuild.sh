#!/bin/bash

. ../../env_set.sh >/dev/null

export FRSCSDK_DIR=$TOOLCHAIN_PATH
export PB_SYSROOT=$TOOLCHAIN_PATH/$TOOLCHAIN_PREFIX/sysroot/

QMAKE_BIN=$TOOLCHAIN_PATH/$TOOLCHAIN_PREFIX/sysroot/usr/qt5/bin/qmake
OUTPUT_DIR=output-nightbuild

rm -rf $OUTPUT_DIR
mkdir -p $OUTPUT_DIR
cd $OUTPUT_DIR

$QMAKE_BIN PLATFORM=arm CONFIG+=release ../browser-minimal.pro || exit 1
make -j ${PB_CPU_COUNT:-1}  || exit 1

cd ..
