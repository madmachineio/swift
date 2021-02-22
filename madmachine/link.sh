#!/bin/bash




if [ "$(uname)" == "Darwin" ];then
    OS_TYPE="macosx"
    BUILD_TYPE="Ninja-ReleaseAssert"
elif [ "$(uname)" == "Linux" ];then
    OS_TYPE="linux"
    BUILD_TYPE="Ninja-ReleaseAssert+stdlib-Release"
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

rm -f $BUILD_PATH/lib/swift_static/madmachine/thumbv7em/libswiftCore.a

echo "Linking..."
STD_GEN_PATH=$BUILD_PATH/stdlib/public/core/MADMACHINE/thumbv7em
RUNTIME_GEN_PATH=$BUILD_PATH/stdlib/public/runtime/CMakeFiles/swiftRuntime-madmachine-thumbv7em.dir
LLVM_GEN_PATH=$BUILD_PATH/stdlib/public/LLVMSupport/CMakeFiles/swiftLLVMSupport-madmachine-thumbv7em.dir
DEMANGLING_GEN_PATH=$BUILD_PATH/stdlib/public/CMakeFiles/swiftDemangling-madmachine-thumbv7em.dir/__/__/lib/Demangling
SWIFTRT_GEN_PATH=$BUILD_PATH/stdlib/public/runtime/CMakeFiles/swiftImageRegistrationObjectELF-madmachine-thumbv7em.dir
STUBS_GEN_PATH=$BUILD_PATH/stdlib/public/stubs/CMakeFiles/swiftStdlibStubs-madmachine-thumbv7em.dir

declare -a link_files
index=0

for f in $STD_GEN_PATH/*.o
do
    length=${#link_files[@]} 
    link_files[index]=${f}
    index=`expr ${index} + 1`
done

for f in $RUNTIME_GEN_PATH/*.o
do
    length=${#link_files[@]} 
    link_files[index]=${f}
    index=`expr ${index} + 1`
done

for f in $LLVM_GEN_PATH/*.o
do
    length=${#link_files[@]} 
    link_files[index]=${f}
    index=`expr ${index} + 1`
done

for f in $DEMANGLING_GEN_PATH/*.o
do
    length=${#link_files[@]} 
    link_files[index]=${f}
    index=`expr ${index} + 1`
done

for f in $STUBS_GEN_PATH/*.o
do
    length=${#link_files[@]} 
    link_files[index]=${f}
    index=`expr ${index} + 1`
done

obj_files=${link_files[*]}

#echo $obj_files


$ARM_GCC_PATH/bin/arm-none-eabi-ar Dqc $BUILD_PATH/lib/swift_static/madmachine/thumbv7em/libswiftCore.a $obj_files
$ARM_GCC_PATH/bin/arm-none-eabi-ranlib -D $BUILD_PATH/lib/swift_static/madmachine/thumbv7em/libswiftCore.a
