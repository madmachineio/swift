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




echo "Processing runtime files..."
RUNTIME_GEN_PATH=$BUILD_PATH/stdlib/public/runtime/CMakeFiles/swiftRuntime-madmachine-thumbv7em.dir
mkdir -p $RUNTIME_GEN_PATH
rm -f $RUNTIME_GEN_PATH/*

cd $BUILD_PATH

for f in $PROJECT_PATH/swift/stdlib/public/runtime/*.cpp
do
    name=${f##*/}
    if [[ ! "$name" =~ ^SwiftRT* ]]; then
        echo "Processing $name"
        $LLVM_PATH/bin/clang++ -DCMARK_STATIC_DEFINE -DGTEST_HAS_RTTI=0 -DLLVM_DISABLE_ABI_BREAKING_CHECKS_ENFORCING=1 -DSWIFT_INLINE_NAMESPACE=__runtime -D_DEBUG -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -D_GNU_SOURCE -D_POSIX_THREADS -D_POSIX_READER_WRITER_LOCKS -D_UNIX98_THREAD_MUTEX_ATTRIBUTES -D__MADMACHINE__ -Istdlib/public/runtime -I$PROJECT_PATH/swift/stdlib/public/runtime -I$PROJECT_PATH/swift/stdlib/include -Iinclude -I$PROJECT_PATH/swift/include -I$PROJECT_PATH/llvm-project/llvm/include -I$LLVM_PATH/include -I$PROJECT_PATH/llvm-project/clang/include -I$LLVM_PATH/tools/clang/include -I$PROJECT_PATH/cmark/src -I$CMARK_PATH/src -Wno-unknown-warning-option -Werror=unguarded-availability-new -ffunction-sections -fdata-sections -fno-stack-protector -fPIC -fvisibility-inlines-hidden -Werror=date-time -Werror=unguarded-availability-new -Wall -Wextra -Wno-unused-parameter -Wwrite-strings -Wcast-qual -Wmissing-field-initializers -Wimplicit-fallthrough -Wcovered-switch-default -Wno-class-memaccess -Wno-noexcept-type -Wnon-virtual-dtor -Wdelete-non-virtual-dtor -Wstring-conversion -fdiagnostics-color -ffunction-sections -fdata-sections -Werror=switch -Wdocumentation -Wimplicit-fallthrough -Wunreachable-code -Woverloaded-virtual -DOBJC_OLD_DISPATCH_PROTOTYPES=0 -O3 -fvisibility=hidden -fvisibility-inlines-hidden -fno-exceptions -fno-rtti -Werror=gnu -UNDEBUG -fno-sanitize=all -Wall -Wglobal-constructors -Wexit-time-destructors -DswiftCore_EXPORTS -I$PROJECT_PATH/swift/stdlib/include/llvm/Support -I$PROJECT_PATH/swift/include  -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1 -I$ARM_GCC_PATH/arm-none-eabi/include -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1/arm-none-eabi/thumb/v7e-m/nofp  -DSWIFT_TARGET_LIBRARY_NAME=swiftRuntime -target thumbv73m-none--eabi -mcpu=cortex-m7 -O2 -g0 -DNDEBUG -DSWIFT_LIBRARY_EVOLUTION=1 -DSWIFT_RUNTIME_OS_VERSIONING -std=c++14 -MD -MT stdlib/public/runtime/CMakeFiles/swiftRuntime-madmachine-thumbv7em.dir/$name.o -MF stdlib/public/runtime/CMakeFiles/swiftRuntime-madmachine-thumbv7em.dir/$name.o.d -o stdlib/public/runtime/CMakeFiles/swiftRuntime-madmachine-thumbv7em.dir/$name.o -c $PROJECT_PATH/swift/stdlib/public/runtime/$name
    fi
done

for f in $PROJECT_PATH/swift/stdlib/public/runtime/*.mm
do
    name=${f##*/}
    if [[ ! "$name" =~ ^Leaks* ]]; then
        echo "Processing $name"
        $LLVM_PATH/bin/clang++ -DCMARK_STATIC_DEFINE -DGTEST_HAS_RTTI=0 -DLLVM_DISABLE_ABI_BREAKING_CHECKS_ENFORCING=1 -DSWIFT_INLINE_NAMESPACE=__runtime -D_DEBUG -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -D_GNU_SOURCE -D_POSIX_THREADS -D_POSIX_READER_WRITER_LOCKS -D_UNIX98_THREAD_MUTEX_ATTRIBUTES -D__MADMACHINE__ -Istdlib/public/runtime -I$PROJECT_PATH/swift/stdlib/public/runtime -I$PROJECT_PATH/swift/stdlib/include -Iinclude -I$PROJECT_PATH/swift/include -I$PROJECT_PATH/llvm-project/llvm/include -I$LLVM_PATH/include -I$PROJECT_PATH/llvm-project/clang/include -I$LLVM_PATH/tools/clang/include -I$PROJECT_PATH/cmark/src -I$CMARK_PATH/src -Wno-unknown-warning-option -Werror=unguarded-availability-new -ffunction-sections -fdata-sections -fno-stack-protector -fPIC -fvisibility-inlines-hidden -Werror=date-time -Werror=unguarded-availability-new -Wall -Wextra -Wno-unused-parameter -Wwrite-strings -Wcast-qual -Wmissing-field-initializers -Wimplicit-fallthrough -Wcovered-switch-default -Wno-class-memaccess -Wno-noexcept-type -Wnon-virtual-dtor -Wdelete-non-virtual-dtor -Wstring-conversion -fdiagnostics-color -ffunction-sections -fdata-sections -Werror=switch -Wdocumentation -Wimplicit-fallthrough -Wunreachable-code -Woverloaded-virtual -DOBJC_OLD_DISPATCH_PROTOTYPES=0 -O3 -fvisibility=hidden -fvisibility-inlines-hidden -fno-exceptions -fno-rtti -Werror=gnu -UNDEBUG -fno-sanitize=all -Wall -Wglobal-constructors -Wexit-time-destructors -DswiftCore_EXPORTS -I$PROJECT_PATH/swift/stdlib/include/llvm/Support -I$PROJECT_PATH/swift/include  -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1 -I$ARM_GCC_PATH/arm-none-eabi/include -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1/arm-none-eabi/thumb/v7e-m/nofp  -DSWIFT_TARGET_LIBRARY_NAME=swiftRuntime -target thumbv73m-none--eabi -mcpu=cortex-m7 -O2 -g0 -DNDEBUG -DSWIFT_LIBRARY_EVOLUTION=1 -DSWIFT_RUNTIME_OS_VERSIONING -std=c++14 -MD -MT stdlib/public/runtime/CMakeFiles/swiftRuntime-madmachine-thumbv7em.dir/$name.o -MF stdlib/public/runtime/CMakeFiles/swiftRuntime-madmachine-thumbv7em.dir/$name.o.d -o stdlib/public/runtime/CMakeFiles/swiftRuntime-madmachine-thumbv7em.dir/$name.o -c $PROJECT_PATH/swift/stdlib/public/runtime/$name
    fi
done




echo "Processing demangling files..."
DEMANGLING_GEN_PATH=$BUILD_PATH/stdlib/public/CMakeFiles/swiftDemangling-madmachine-thumbv7em.dir/__/__/lib/Demangling
mkdir -p $DEMANGLING_GEN_PATH
rm -f $DEMANGLING_GEN_PATH/*

cd $BUILD_PATH

for f in $PROJECT_PATH/swift/lib/Demangling/*.cpp
do
    name=${f##*/}
    echo "Processing $name"
    $LLVM_PATH/bin/clang++ -DCMARK_STATIC_DEFINE -DGTEST_HAS_RTTI=0 -DLLVM_DISABLE_ABI_BREAKING_CHECKS_ENFORCING=1 -DSWIFT_INLINE_NAMESPACE=__runtime -D_DEBUG -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -D_GNU_SOURCE -D_POSIX_THREADS -D_POSIX_READER_WRITER_LOCKS -D_UNIX98_THREAD_MUTEX_ATTRIBUTES -D__MADMACHINE__ -Istdlib/public -I$PROJECT_PATH/swift/stdlib/public -I$PROJECT_PATH/swift/stdlib/include -Iinclude -I$PROJECT_PATH/swift/include -I$PROJECT_PATH/llvm-project/llvm/include -I$LLVM_PATH/include -I$PROJECT_PATH/llvm-project/clang/include -I$LLVM_PATH/tools/clang/include -I$PROJECT_PATH/cmark/src -I$CMARK_PATH/src  -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1 -I$ARM_GCC_PATH/arm-none-eabi/include -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1/arm-none-eabi/thumb/v7e-m/nofp  -Wno-unknown-warning-option -Werror=unguarded-availability-new -ffunction-sections -fdata-sections -fno-stack-protector -fPIC -fvisibility-inlines-hidden -Werror=date-time -Werror=unguarded-availability-new -Wall -Wextra -Wno-unused-parameter -Wwrite-strings -Wcast-qual -Wmissing-field-initializers -Wimplicit-fallthrough -Wcovered-switch-default -Wno-class-memaccess -Wno-noexcept-type -Wnon-virtual-dtor -Wdelete-non-virtual-dtor -Wstring-conversion -fdiagnostics-color -ffunction-sections -fdata-sections -Werror=switch -Wdocumentation -Wimplicit-fallthrough -Wunreachable-code -Woverloaded-virtual -DOBJC_OLD_DISPATCH_PROTOTYPES=0 -O3 -fvisibility=hidden -fvisibility-inlines-hidden -fno-exceptions -fno-rtti -Werror=gnu -UNDEBUG -fno-sanitize=all -DswiftCore_EXPORTS -DSWIFT_TARGET_LIBRARY_NAME=swiftDemangling -target thumbv7em-none--eabi -mcpu=cortex-m7 -O2 -g0 -DNDEBUG -DSWIFT_LIBRARY_EVOLUTION=1 -DSWIFT_RUNTIME_OS_VERSIONING -std=c++14 -MD -MT stdlib/public/CMakeFiles/swiftDemangling-madmachine-thumbv7em.dir/__/__/lib/Demangling/$name.o -MF stdlib/public/CMakeFiles/swiftDemangling-madmachine-thumbv7em.dir/__/__/lib/Demangling/$name.o.d -o stdlib/public/CMakeFiles/swiftDemangling-madmachine-thumbv7em.dir/__/__/lib/Demangling/$name.o -c $PROJECT_PATH/swift/lib/Demangling/$name
done





echo "Processing SwiftRT-ELF..."
SWIFTRT_GEN_PATH=$BUILD_PATH/stdlib/public/runtime/CMakeFiles/swiftImageRegistrationObjectELF-madmachine-thumbv7em.dir
mkdir -p $SWIFTRT_GEN_PATH
rm -f $SWIFTRT_GEN_PATH/*

$LLVM_PATH/bin/clang++ -DCMARK_STATIC_DEFINE -DGTEST_HAS_RTTI=0 -DLLVM_DISABLE_ABI_BREAKING_CHECKS_ENFORCING=1 -DSWIFT_INLINE_NAMESPACE=__runtime -D_DEBUG -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -D_POSIX_THREADS -D_POSIX_READER_WRITER_LOCKS -D_UNIX98_THREAD_MUTEX_ATTRIBUTES -D__MADMACHINE_ -Istdlib/public/runtime -I$PROJECT_PATH/swift/stdlib/public/runtime -I$PROJECT_PATH/swift/stdlib/include -Iinclude -I$PROJECT_PATH/swift/include -I$PROJECT_PATH/llvm-project/llvm/include -I$LLVM_PATH/include -I$PROJECT_PATH/llvm-project/clang/include -I$LLVM_PATH/tools/clang/include -I$PROJECT_PATH/cmark/src -I$CMARK_PATH/src -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1 -I$ARM_GCC_PATH/arm-none-eabi/include -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1/arm-none-eabi/thumb/v7e-m/nofp -Wno-unknown-warning-option -Werror=unguarded-availability-new -ffunction-sections -fdata-sections -fno-stack-protector -fPIC -fvisibility-inlines-hidden -Werror=date-time -Werror=unguarded-availability-new -Wall -Wextra -Wno-unused-parameter -Wwrite-strings -Wcast-qual -Wmissing-field-initializers -Wimplicit-fallthrough -Wcovered-switch-default -Wno-class-memaccess -Wno-noexcept-type -Wnon-virtual-dtor -Wdelete-non-virtual-dtor -Wstring-conversion -fdiagnostics-color -ffunction-sections -fdata-sections -Werror=switch -Wdocumentation -Wimplicit-fallthrough -Wunreachable-code -Woverloaded-virtual -DOBJC_OLD_DISPATCH_PROTOTYPES=0 -O3  -fvisibility=hidden -fvisibility-inlines-hidden -fno-exceptions -fno-rtti -Werror=gnu -UNDEBUG -fno-sanitize=all -Wall -Wglobal-constructors -Wexit-time-destructors -DSWIFT_TARGET_LIBRARY_NAME=swiftImageRegistrationObjectELF -target thumbv7em-none--eabi -mcpu=cortex-m7 -O2 -g0 -DNDEBUG -DSWIFT_LIBRARY_EVOLUTION=1 -DSWIFT_RUNTIME_OS_VERSIONING -std=c++14 -MD -MT stdlib/public/runtime/CMakeFiles/swiftImageRegistrationObjectELF-madmachine-thumbv7em.dir/SwiftRT-ELF.cpp.o -MF stdlib/public/runtime/CMakeFiles/swiftImageRegistrationObjectELF-madmachine-thumbv7em.dir/SwiftRT-ELF.cpp.o.d -o stdlib/public/runtime/CMakeFiles/swiftImageRegistrationObjectELF-madmachine-thumbv7em.dir/SwiftRT-ELF.cpp.o -c $PROJECT_PATH/swift/stdlib/public/runtime/SwiftRT-ELF.cpp

mkdir -p $BUILD_PATH/lib/swift/madmachine/thumbv7em
mkdir -p $BUILD_PATH/lib/swift_static/madmachine/thumbv7em

cp $SWIFTRT_GEN_PATH/SwiftRT-ELF.cpp.o $BUILD_PATH/lib/swift/madmachine/thumbv7em/swiftrt.o
cp $SWIFTRT_GEN_PATH/SwiftRT-ELF.cpp.o $BUILD_PATH/lib/swift_static/madmachine/thumbv7em/swiftrt.o