#!/bin/bash

if [ "$(uname)" == "Darwin" ];then
    OS_TYPE="macosx"
    BUILD_TYPE="Ninja-ReleaseAssert"
elif [ "$(uname)" == "Linux" ];then
    OS_TYPE="linux"
    BUILD_TYPE="Ninja-ReleaseAssert"
else
    echo "OS not supported!"
    exit
fi


cd ../..
PROJECT_PATH=$(cd "$(dirname "$0")";pwd)
BUILD_PATH=$PROJECT_PATH/build/$BUILD_TYPE/swift-$OS_TYPE-x86_64
LLVM_PATH=$PROJECT_PATH/build/$BUILD_TYPE/llvm-$OS_TYPE-x86_64
CMARK_PATH=$PROJECT_PATH/build/$BUILD_TYPE/cmark-$OS_TYPE-x86_64
ARM_GCC_PATH=$PROJECT_PATH/gcc-arm-none-eabi-9-2020-q2-update


if [ ! -d $BUILD_PATH ]; then
    echo "$BUILD_PATH not exists!"
    exit
fi

SDK_PATH=$PROJECT_PATH/mm-sdk
if [ ! -d $PROJECT_PATH ]; then
    echo "$PROJECT_PATH not exists!"
    exit
fi

rm -rf $SDK_PATH/usr/lib/swift/madmachine
rm -rf $SDK_PATH/usr/lib/swift_static

cp -rf $BUILD_PATH/lib/swift/madmachine $SDK_PATH/usr/lib/swift
cp -rf $BUILD_PATH/lib/swift_static $SDK_PATH/usr/lib
