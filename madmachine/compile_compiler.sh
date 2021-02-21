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


if [ ! -d $PROJECT_PATH/swift ]; then
    echo "$PROJECT_PATH/swift not exists!"
    exit
fi

cd $PROJECT_PATH/swift

if [ $OS_TYPE == "macosx" ];then
    echo "Building for macos"
    $SOURCE_PATH/swift/utils/build-script --skip-build-benchmarks --skip-ios --skip-watchos --skip-tvos -R
elif [ $OS_TYPE == "linux" ];then
    echo "Building for linux"
    $SOURCE_PATH/swift/utils/build-script --skip-build-benchmarks --skip-ios --skip-watchos --skip-tvos --build-swift-dynamic-stdlib=0 --build-swift-dynamic-sdk-overlay=0 --build-swift-static-stdlib=0 --no-swift-stdlib-assertions -R
else
    echo "OS not supported!"
    exit
fi