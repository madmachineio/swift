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

rm -f $BUILD_PATH/lib/swift_static/madmachine/thumbv7em/eabi/libswiftCore.a

echo "Linking..."
STD_GEN_PATH=$BUILD_PATH/stdlib/public/core/MADMACHINE/thumbv7em/eabi
RUNTIME_GEN_PATH=$BUILD_PATH/stdlib/public/runtime/CMakeFiles/swiftRuntime-madmachine-thumbv7em-eabi.dir
LLVM_GEN_PATH=$BUILD_PATH/stdlib/public/LLVMSupport/CMakeFiles/swiftLLVMSupport-madmachine-thumbv7em-eabi.dir
DEMANGLING_GEN_PATH=$BUILD_PATH/stdlib/public/CMakeFiles/swiftDemangling-madmachine-thumbv7em-eabi.dir/__/__/lib/Demangling
SWIFTRT_GEN_PATH=$BUILD_PATH/stdlib/public/runtime/CMakeFiles/swiftImageRegistrationObjectELF-madmachine-thumbv7em-eabi.dir
STUBS_GEN_PATH=$BUILD_PATH/stdlib/public/stubs/CMakeFiles/swiftStdlibStubs-madmachine-thumbv7em-eabi.dir

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


$ARM_GCC_PATH/bin/arm-none-eabi-ar Dqc $BUILD_PATH/lib/swift_static/madmachine/thumbv7em/eabi/libswiftCore.a $obj_files
$ARM_GCC_PATH/bin/arm-none-eabi-ranlib -D $BUILD_PATH/lib/swift_static/madmachine/thumbv7em/eabi/libswiftCore.a




rm -f $BUILD_PATH/lib/swift_static/madmachine/*.lnk

cat << EOF > $BUILD_PATH/lib/swift_static/madmachine/static-stdlib-args.lnk
-nostdlib
-nostdlib++
EOF

cp -f $BUILD_PATH/lib/swift_static/madmachine/static-stdlib-args.lnk $BUILD_PATH/lib/swift_static/madmachine/static-executable-args.lnk
cp -rf $BUILD_PATH/lib/swift/shims $BUILD_PATH/lib/swift_static