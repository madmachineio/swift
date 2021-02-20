#!/bin/bash




if [ "$(uname)" == "Darwin" ];then
    OS_TYPE="macosx"
elif [ "$(uname)" == "Linux" ];then
    OS_TYPE="linux"
else
    echo "OS not supported!"
    exit
fi

cd ../..
PROJECT_PATH=$(cd "$(dirname "$0")";pwd)

SOURCE_PATH="$PROJECT_PATH/swift"

if [ ! -d $SOURCE_PATH ]; then
    echo "$SOURCE_PATH not exists!"
    exit
fi

cd $SOURCE_PATH

if [ $OS_TYPE == "macosx" ];then
    echo "Building for macos"
    $SOURCE_PATH/utils/build-script --skip-build-benchmarks --skip-ios --skip-watchos --skip-tvos -R
elif [ $OS_TYPE == "linux" ];then
    echo "Building for linux"
    $SOURCE_PATH/utils/build-script --skip-build-benchmarks --skip-ios --skip-watchos --skip-tvos --build-swift-dynamic-stdlib=0 --build-swift-dynamic-sdk-overlay=0 --build-swift-static-stdlib=0 --no-swift-stdlib-assertions -R
else
    echo "OS not supported!"
    exit
fi