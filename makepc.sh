#!/bin/sh

if [ -z "$PB_SDK_CFG" ]; then
    echo -en "\033[0;31m Environment variable PB_SDK_CFG is not set\n \033[0m"
    exit 1
fi

SDK_DIR=`dirname $PB_SDK_CFG`/usr/
SCRIPT_FILE=`readlink -f ${0}`
PROJECT_DIR=`dirname ${SCRIPT_FILE}`
PROJECT_FILE=${PROJECT_DIR}/browser-minimal.pro
OUTPUT_DIR=${PROJECT_DIR}/output-linux
CPU_COUNT=`cat /proc/cpuinfo | grep processor | wc -l`
QMAKE_BIN=${SDK_DIR}/local/qt5/bin/qmake

mkdir -p ${OUTPUT_DIR}
cd ${OUTPUT_DIR}

${QMAKE_BIN} PLATFORM=linux ${PROJECT_FILE}
make -j ${CPU_COUNT:-1}

cd ..
