#!/bin/bash




if [ "$(uname)" == "Darwin" ];then
    OS_TYPE="macos"
elif [ "$(uname)" == "Linux" ];then
    OS_TYPE="linux"
else
    echo "OS not supported!"
    exit
fi

cd ../..
PROJECT_PATH=$(dirname $(readlink -f $0))

SOURCE_PATH="$PROJECT_PATH/swift"


if [ ! -d $SOURCE_PATH ]; then
    echo "$SOURCE_PATH not exists!"
    exit
fi

cd $SOURCE_PATH
$SOURCE_PATH/utils/build-script --skip-build-benchmarks --skip-ios --skip-watchos --skip-tvos --build-swift-dynamic-stdlib=0 --build-swift-dynamic-sdk-overlay=0 --build-swift-static-stdlib --no-swift-stdlib-assertions -R
