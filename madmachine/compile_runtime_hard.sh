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




echo "Processing runtime files..."
RUNTIME_GEN_PATH=$BUILD_PATH/stdlib/public/runtime/CMakeFiles/swiftRuntime-madmachine-thumbv7em-eabihf.dir
mkdir -p $RUNTIME_GEN_PATH
rm -f $RUNTIME_GEN_PATH/*

cd $BUILD_PATH

for f in $PROJECT_PATH/swift/stdlib/public/runtime/*.cpp
do
    name=${f##*/}
    if [[ ! "$name" =~ ^SwiftRT* ]]; then
        echo "Processing $name"
        COMMAND="$LLVM_PATH/bin/clang++ -DCMARK_STATIC_DEFINE -DGTEST_HAS_RTTI=0 -DLLVM_DISABLE_ABI_BREAKING_CHECKS_ENFORCING=1 -DSWIFT_INLINE_NAMESPACE=__runtime -D_DEBUG -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -D_GNU_SOURCE -D_POSIX_THREADS -D_POSIX_READER_WRITER_LOCKS -D_UNIX98_THREAD_MUTEX_ATTRIBUTES -D__MADMACHINE__ -Istdlib/public/runtime -I$PROJECT_PATH/swift/stdlib/public/runtime -I$PROJECT_PATH/swift/stdlib/include -Iinclude -I$PROJECT_PATH/swift/include -I$PROJECT_PATH/llvm-project/llvm/include -I$LLVM_PATH/include -I$PROJECT_PATH/llvm-project/clang/include -I$LLVM_PATH/tools/clang/include -I$PROJECT_PATH/cmark/src -I$CMARK_PATH/src -Wno-unknown-warning-option -Werror=unguarded-availability-new -fno-stack-protector -fPIC -fvisibility-inlines-hidden -Werror=date-time -Werror=unguarded-availability-new -Wall -Wextra -Wno-unused-parameter -Wwrite-strings -Wcast-qual -Wmissing-field-initializers -Wimplicit-fallthrough -Wcovered-switch-default -Wno-class-memaccess -Wno-noexcept-type -Wnon-virtual-dtor -Wdelete-non-virtual-dtor -Wstring-conversion -fdiagnostics-color -ffunction-sections -fdata-sections -Werror=switch -Wdocumentation -Wimplicit-fallthrough -Wunreachable-code -Woverloaded-virtual -DOBJC_OLD_DISPATCH_PROTOTYPES=0 -O3 -fvisibility=hidden -fvisibility-inlines-hidden -fno-exceptions -fno-rtti -Werror=gnu -UNDEBUG -fno-sanitize=all -Wall -Wglobal-constructors -Wexit-time-destructors -DswiftCore_EXPORTS -I$PROJECT_PATH/swift/stdlib/include/llvm/Support -I$PROJECT_PATH/swift/include  -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1 -I$ARM_GCC_PATH/arm-none-eabi/include -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1/arm-none-eabi/thumb/v7e-m+dp/hard  -DSWIFT_TARGET_LIBRARY_NAME=swiftRuntime -target thumbv7em-none-eabihf -mcpu=cortex-m7 -mfloat-abi=hard -O2 -g0 -DNDEBUG -DSWIFT_LIBRARY_EVOLUTION=1 -DSWIFT_RUNTIME_OS_VERSIONING -std=c++14 -MD -MT stdlib/public/runtime/CMakeFiles/swiftRuntime-madmachine-thumbv7em-eabihf.dir/$name.o -MF stdlib/public/runtime/CMakeFiles/swiftRuntime-madmachine-thumbv7em-eabihf.dir/$name.o.d -o stdlib/public/runtime/CMakeFiles/swiftRuntime-madmachine-thumbv7em-eabihf.dir/$name.o -c $PROJECT_PATH/swift/stdlib/public/runtime/$name"
        $COMMAND
    fi
done

for f in $PROJECT_PATH/swift/stdlib/public/runtime/*.mm
do
    name=${f##*/}
    if [[ ! "$name" =~ ^Leaks* ]]; then
        echo "Processing $name"
        COMMAND="$LLVM_PATH/bin/clang++ -DCMARK_STATIC_DEFINE -DGTEST_HAS_RTTI=0 -DLLVM_DISABLE_ABI_BREAKING_CHECKS_ENFORCING=1 -DSWIFT_INLINE_NAMESPACE=__runtime -D_DEBUG -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -D_GNU_SOURCE -D_POSIX_THREADS -D_POSIX_READER_WRITER_LOCKS -D_UNIX98_THREAD_MUTEX_ATTRIBUTES -D__MADMACHINE__ -Istdlib/public/runtime -I$PROJECT_PATH/swift/stdlib/public/runtime -I$PROJECT_PATH/swift/stdlib/include -Iinclude -I$PROJECT_PATH/swift/include -I$PROJECT_PATH/llvm-project/llvm/include -I$LLVM_PATH/include -I$PROJECT_PATH/llvm-project/clang/include -I$LLVM_PATH/tools/clang/include -I$PROJECT_PATH/cmark/src -I$CMARK_PATH/src -Wno-unknown-warning-option -Werror=unguarded-availability-new -fno-stack-protector -fPIC -fvisibility-inlines-hidden -Werror=date-time -Werror=unguarded-availability-new -Wall -Wextra -Wno-unused-parameter -Wwrite-strings -Wcast-qual -Wmissing-field-initializers -Wimplicit-fallthrough -Wcovered-switch-default -Wno-class-memaccess -Wno-noexcept-type -Wnon-virtual-dtor -Wdelete-non-virtual-dtor -Wstring-conversion -fdiagnostics-color -ffunction-sections -fdata-sections -Werror=switch -Wdocumentation -Wimplicit-fallthrough -Wunreachable-code -Woverloaded-virtual -DOBJC_OLD_DISPATCH_PROTOTYPES=0 -O3 -fvisibility=hidden -fvisibility-inlines-hidden -fno-exceptions -fno-rtti -Werror=gnu -UNDEBUG -fno-sanitize=all -Wall -Wglobal-constructors -Wexit-time-destructors -DswiftCore_EXPORTS -I$PROJECT_PATH/swift/stdlib/include/llvm/Support -I$PROJECT_PATH/swift/include  -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1 -I$ARM_GCC_PATH/arm-none-eabi/include -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1/arm-none-eabi/thumb/v7e-m+dp/hard  -DSWIFT_TARGET_LIBRARY_NAME=swiftRuntime -target thumbv7em-none-eabihf -mcpu=cortex-m7 -mfloat-abi=hard -O2 -g0 -DNDEBUG -DSWIFT_LIBRARY_EVOLUTION=1 -DSWIFT_RUNTIME_OS_VERSIONING -std=c++14 -MD -MT stdlib/public/runtime/CMakeFiles/swiftRuntime-madmachine-thumbv7em-eabihf.dir/$name.o -MF stdlib/public/runtime/CMakeFiles/swiftRuntime-madmachine-thumbv7em-eabihf.dir/$name.o.d -o stdlib/public/runtime/CMakeFiles/swiftRuntime-madmachine-thumbv7em-eabihf.dir/$name.o -c $PROJECT_PATH/swift/stdlib/public/runtime/$name"
        $COMMAND
    fi
done




echo "Processing llvm supporting files..."
LLVM_GEN_PATH=$BUILD_PATH/stdlib/public/LLVMSupport/CMakeFiles/swiftLLVMSupport-madmachine-thumbv7em-eabihf.dir
mkdir -p $LLVM_GEN_PATH
rm -f $LLVM_GEN_PATH/*

cd $BUILD_PATH

for f in $PROJECT_PATH/swift/stdlib/public/LLVMSupport/*.cpp
do
    name=${f##*/}
    echo "Processing $name"
    COMMAND="$LLVM_PATH/bin/clang++ -DCMARK_STATIC_DEFINE -DGTEST_HAS_RTTI=0 -DLLVM_DISABLE_ABI_BREAKING_CHECKS_ENFORCING=1 -DSWIFT_INLINE_NAMESPACE=__runtime -D_DEBUG -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -D_GNU_SOURCE -D_POSIX_THREADS -D_POSIX_READER_WRITER_LOCKS -D_UNIX98_THREAD_MUTEX_ATTRIBUTES -D__MADMACHINE__ -Istdlib/public/LLVMSupport -I$PROJECT_PATH/swift/stdlib/public/LLVMSupport -I$PROJECT_PATH/swift/stdlib/include -Iinclude -I$PROJECT_PATH/swift/include -I$PROJECT_PATH/llvm-project/llvm/include -I$LLVM_PATH/include -I$PROJECT_PATH/llvm-project/clang/include -I$LLVM_PATH/tools/clang/include -I$PROJECT_PATH/cmark/src -I$CMARK_PATH/src -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1 -I$ARM_GCC_PATH/arm-none-eabi/include -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1/arm-none-eabi/thumb/v7e-m+dp/hard -Wno-unknown-warning-option -Werror=unguarded-availability-new -fno-stack-protector -fPIC -fvisibility-inlines-hidden -Werror=date-time -Werror=unguarded-availability-new -Wall -Wextra -Wno-unused-parameter -Wwrite-strings -Wcast-qual -Wmissing-field-initializers -Wimplicit-fallthrough -Wcovered-switch-default -Wno-class-memaccess -Wno-noexcept-type -Wnon-virtual-dtor -Wdelete-non-virtual-dtor -Wstring-conversion -fdiagnostics-color -ffunction-sections -fdata-sections -Werror=switch -Wdocumentation -Wimplicit-fallthrough -Wunreachable-code -Woverloaded-virtual -DOBJC_OLD_DISPATCH_PROTOTYPES=0 -O3  -fvisibility=hidden -fvisibility-inlines-hidden -fno-exceptions -fno-rtti -Werror=gnu -UNDEBUG -fno-sanitize=all -DSWIFT_TARGET_LIBRARY_NAME=swiftLLVMSupport -target thumbv7em-none-eabihf -mcpu=cortex-m7 -mfloat-abi=hard -O2 -g0 -DNDEBUG -DSWIFT_LIBRARY_EVOLUTION=1 -DSWIFT_RUNTIME_OS_VERSIONING -std=c++14 -MD -MT stdlib/public/LLVMSupport/CMakeFiles/swiftLLVMSupport-madmachine-thumbv7em-eabihf.dir/$name.o -MF stdlib/public/LLVMSupport/CMakeFiles/swiftLLVMSupport-madmachine-thumbv7em-eabihf.dir/$name.o.d -o stdlib/public/LLVMSupport/CMakeFiles/swiftLLVMSupport-madmachine-thumbv7em-eabihf.dir/$name.o -c $PROJECT_PATH/swift/stdlib/public/LLVMSupport/$name"
    $COMMAND
done




echo "Processing demangling files..."
DEMANGLING_GEN_PATH=$BUILD_PATH/stdlib/public/CMakeFiles/swiftDemangling-madmachine-thumbv7em-eabihf.dir/__/__/lib/Demangling
mkdir -p $DEMANGLING_GEN_PATH
rm -f $DEMANGLING_GEN_PATH/*

cd $BUILD_PATH

for f in $PROJECT_PATH/swift/lib/Demangling/*.cpp
do
    name=${f##*/}
    echo "Processing $name"
    COMMAND="$LLVM_PATH/bin/clang++ -DCMARK_STATIC_DEFINE -DGTEST_HAS_RTTI=0 -DLLVM_DISABLE_ABI_BREAKING_CHECKS_ENFORCING=1 -DSWIFT_INLINE_NAMESPACE=__runtime -D_DEBUG -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -D_GNU_SOURCE -D_POSIX_THREADS -D_POSIX_READER_WRITER_LOCKS -D_UNIX98_THREAD_MUTEX_ATTRIBUTES -D__MADMACHINE__ -Istdlib/public -I$PROJECT_PATH/swift/stdlib/public -I$PROJECT_PATH/swift/stdlib/include -Iinclude -I$PROJECT_PATH/swift/include -I$PROJECT_PATH/llvm-project/llvm/include -I$LLVM_PATH/include -I$PROJECT_PATH/llvm-project/clang/include -I$LLVM_PATH/tools/clang/include -I$PROJECT_PATH/cmark/src -I$CMARK_PATH/src  -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1 -I$ARM_GCC_PATH/arm-none-eabi/include -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1/arm-none-eabi/thumb/v7e-m+dp/hard  -Wno-unknown-warning-option -Werror=unguarded-availability-new -fno-stack-protector -fPIC -fvisibility-inlines-hidden -Werror=date-time -Werror=unguarded-availability-new -Wall -Wextra -Wno-unused-parameter -Wwrite-strings -Wcast-qual -Wmissing-field-initializers -Wimplicit-fallthrough -Wcovered-switch-default -Wno-class-memaccess -Wno-noexcept-type -Wnon-virtual-dtor -Wdelete-non-virtual-dtor -Wstring-conversion -fdiagnostics-color -ffunction-sections -fdata-sections -Werror=switch -Wdocumentation -Wimplicit-fallthrough -Wunreachable-code -Woverloaded-virtual -DOBJC_OLD_DISPATCH_PROTOTYPES=0 -O3 -fvisibility=hidden -fvisibility-inlines-hidden -fno-exceptions -fno-rtti -Werror=gnu -UNDEBUG -fno-sanitize=all -DswiftCore_EXPORTS -DSWIFT_TARGET_LIBRARY_NAME=swiftDemangling -target thumbv7em-none-eabihf -mcpu=cortex-m7 -mfloat-abi=hard -O2 -g0 -DNDEBUG -DSWIFT_LIBRARY_EVOLUTION=1 -DSWIFT_RUNTIME_OS_VERSIONING -std=c++14 -MD -MT stdlib/public/CMakeFiles/swiftDemangling-madmachine-thumbv7em-eabihf.dir/__/__/lib/Demangling/$name.o -MF stdlib/public/CMakeFiles/swiftDemangling-madmachine-thumbv7em-eabihf.dir/__/__/lib/Demangling/$name.o.d -o stdlib/public/CMakeFiles/swiftDemangling-madmachine-thumbv7em-eabihf.dir/__/__/lib/Demangling/$name.o -c $PROJECT_PATH/swift/lib/Demangling/$name"
    $COMMAND
done





echo "Processing SwiftRT-ELF..."
SWIFTRT_GEN_PATH=$BUILD_PATH/stdlib/public/runtime/CMakeFiles/swiftImageRegistrationObjectELF-madmachine-thumbv7em-eabihf.dir
mkdir -p $SWIFTRT_GEN_PATH
rm -f $SWIFTRT_GEN_PATH/*

COMMAND="$LLVM_PATH/bin/clang++ -DCMARK_STATIC_DEFINE -DGTEST_HAS_RTTI=0 -DLLVM_DISABLE_ABI_BREAKING_CHECKS_ENFORCING=1 -DSWIFT_INLINE_NAMESPACE=__runtime -D_DEBUG -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -D_POSIX_THREADS -D_POSIX_READER_WRITER_LOCKS -D_UNIX98_THREAD_MUTEX_ATTRIBUTES -D__MADMACHINE_ -Istdlib/public/runtime -I$PROJECT_PATH/swift/stdlib/public/runtime -I$PROJECT_PATH/swift/stdlib/include -Iinclude -I$PROJECT_PATH/swift/include -I$PROJECT_PATH/llvm-project/llvm/include -I$LLVM_PATH/include -I$PROJECT_PATH/llvm-project/clang/include -I$LLVM_PATH/tools/clang/include -I$PROJECT_PATH/cmark/src -I$CMARK_PATH/src -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1 -I$ARM_GCC_PATH/arm-none-eabi/include -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1/arm-none-eabi/thumb/v7e-m+dp/hard -Wno-unknown-warning-option -Werror=unguarded-availability-new -fno-stack-protector -fPIC -fvisibility-inlines-hidden -Werror=date-time -Werror=unguarded-availability-new -Wall -Wextra -Wno-unused-parameter -Wwrite-strings -Wcast-qual -Wmissing-field-initializers -Wimplicit-fallthrough -Wcovered-switch-default -Wno-class-memaccess -Wno-noexcept-type -Wnon-virtual-dtor -Wdelete-non-virtual-dtor -Wstring-conversion -fdiagnostics-color -ffunction-sections -fdata-sections -Werror=switch -Wdocumentation -Wimplicit-fallthrough -Wunreachable-code -Woverloaded-virtual -DOBJC_OLD_DISPATCH_PROTOTYPES=0 -O3  -fvisibility=hidden -fvisibility-inlines-hidden -fno-exceptions -fno-rtti -Werror=gnu -UNDEBUG -fno-sanitize=all -Wall -Wglobal-constructors -Wexit-time-destructors -DSWIFT_TARGET_LIBRARY_NAME=swiftImageRegistrationObjectELF -target thumbv7em-none-eabihf -mcpu=cortex-m7 -mfloat-abi=hard -O2 -g0 -DNDEBUG -DSWIFT_LIBRARY_EVOLUTION=1 -DSWIFT_RUNTIME_OS_VERSIONING -std=c++14 -MD -MT stdlib/public/runtime/CMakeFiles/swiftImageRegistrationObjectELF-madmachine-thumbv7em-eabihf.dir/SwiftRT-ELF.cpp.o -MF stdlib/public/runtime/CMakeFiles/swiftImageRegistrationObjectELF-madmachine-thumbv7em-eabihf.dir/SwiftRT-ELF.cpp.o.d -o stdlib/public/runtime/CMakeFiles/swiftImageRegistrationObjectELF-madmachine-thumbv7em-eabihf.dir/SwiftRT-ELF.cpp.o -c $PROJECT_PATH/swift/stdlib/public/runtime/SwiftRT-ELF.cpp"
$COMMAND

mkdir -p $BUILD_PATH/lib/swift/madmachine/thumbv7em/eabihf
mkdir -p $BUILD_PATH/lib/swift_static/madmachine/thumbv7em/eabihf

cp $SWIFTRT_GEN_PATH/SwiftRT-ELF.cpp.o $BUILD_PATH/lib/swift_static/madmachine/thumbv7em/eabihf/swiftrt.o





echo "Processing stubs..."
STUBS_GEN_PATH=$BUILD_PATH/stdlib/public/stubs/CMakeFiles/swiftStdlibStubs-madmachine-thumbv7em-eabihf.dir
mkdir -p $STUBS_GEN_PATH
rm -rf $STUBS_GEN_PATH/*

for f in $PROJECT_PATH/swift/stdlib/public/stubs/*.cpp
do
    name=${f##*/}
    echo "Processing $name"
    COMMAND="$LLVM_PATH/bin/clang++ -DCMARK_STATIC_DEFINE -DGTEST_HAS_RTTI=0 -DLLVM_DISABLE_ABI_BREAKING_CHECKS_ENFORCING=1 -DSWIFT_INLINE_NAMESPACE=__runtime -D_DEBUG -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -D_GNU_SOURCE -D_POSIX_THREADS -D_POSIX_READER_WRITER_LOCKS -D_UNIX98_THREAD_MUTEX_ATTRIBUTES -D__MADMACHINE__ -Istdlib/public/stubs -I$PROJECT_PATH/swift/stdlib/public/stubs -I$PROJECT_PATH/swift/stdlib/include -Iinclude -I$PROJECT_PATH/swift/include -I$PROJECT_PATH/llvm-project/llvm/include -I$LLVM_PATH/include -I$PROJECT_PATH/llvm-project/clang/include -I$LLVM_PATH/tools/clang/include -I$PROJECT_PATH/cmark/src -I$CMARK_PATH/src -Wno-unknown-warning-option -Werror=unguarded-availability-new -fno-stack-protector -fPIC -fvisibility-inlines-hidden -Werror=date-time -Werror=unguarded-availability-new -Wall -Wextra -Wno-unused-parameter -Wwrite-strings -Wcast-qual -Wmissing-field-initializers -Wimplicit-fallthrough -Wcovered-switch-default -Wno-class-memaccess -Wno-noexcept-type -Wnon-virtual-dtor -Wdelete-non-virtual-dtor -Wstring-conversion -fdiagnostics-color -ffunction-sections -fdata-sections -Werror=switch -Wdocumentation -Wimplicit-fallthrough -Wunreachable-code -Woverloaded-virtual -DOBJC_OLD_DISPATCH_PROTOTYPES=0 -O3  -fvisibility=hidden -fvisibility-inlines-hidden -fno-exceptions -fno-rtti -Werror=gnu -UNDEBUG -fno-sanitize=all -Wall -Wglobal-constructors -Wexit-time-destructors -DswiftCore_EXPORTS -I$PROJECT_PATH/swift/include  -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1 -I$ARM_GCC_PATH/arm-none-eabi/include -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1/arm-none-eabi/thumb/v7e-m+dp/hard  -DSWIFT_TARGET_LIBRARY_NAME=swiftStdlibStubs -target thumbv7em-none-eabihf -mcpu=cortex-m7 -mfloat-abi=hard -O2 -g0 -DNDEBUG -DSWIFT_LIBRARY_EVOLUTION=1 -DSWIFT_RUNTIME_OS_VERSIONING -std=c++14 -MD -MT stdlib/public/stubs/CMakeFiles/swiftStdlibStubs-madmachine-thumbv7em-eabihf.dir/$name.o -MF stdlib/public/stubs/CMakeFiles/swiftStdlibStubs-madmachine-thumbv7em-eabihf.dir/$name.o.d -o stdlib/public/stubs/CMakeFiles/swiftStdlibStubs-madmachine-thumbv7em-eabihf.dir/$name.o -c $PROJECT_PATH/swift/stdlib/public/stubs/$name"
    $COMMAND
done


echo "Processing SimpleUnicodeSupport..."
for f in $PROJECT_PATH/swift/stdlib/public/stubs/SimpleUnicodeSupport/*.c
do
    name=${f##*/}
    echo "Processing $name"
    COMMAND="$LLVM_PATH/bin/clang -DCMARK_STATIC_DEFINE -DGTEST_HAS_RTTI=0 -DLLVM_DISABLE_ABI_BREAKING_CHECKS_ENFORCING=1 -DSWIFT_INLINE_NAMESPACE=__runtime -D_DEBUG -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -D_GNU_SOURCE -D_POSIX_THREADS -D_POSIX_READER_WRITER_LOCKS -D_UNIX98_THREAD_MUTEX_ATTRIBUTES -D__MADMACHINE__ -Istdlib/public/stubs -I$PROJECT_PATH/swift/stdlib/public/stubs -I$PROJECT_PATH/swift/stdlib/include -Iinclude -I$PROJECT_PATH/swift/include -I$PROJECT_PATH/llvm-project/llvm/include -I$LLVM_PATH/include -I$PROJECT_PATH/llvm-project/clang/include -I$LLVM_PATH/tools/clang/include -I$PROJECT_PATH/cmark/src -I$CMARK_PATH/src -I$PROJECT_PATH/swift/stdlib/public/stubs/SimpleUnicodeSupport/include -Wno-unknown-warning-option -Werror=unguarded-availability-new -fno-stack-protector -fPIC -fvisibility-inlines-hidden -Werror=date-time -Werror=unguarded-availability-new -Wall -Wextra -Wno-unused-parameter -Wwrite-strings -Wcast-qual -Wmissing-field-initializers -Wimplicit-fallthrough -Wcovered-switch-default -Wno-class-memaccess -Wno-noexcept-type -Wnon-virtual-dtor -Wdelete-non-virtual-dtor -Wstring-conversion -fdiagnostics-color -ffunction-sections -fdata-sections -Werror=switch -Wdocumentation -Wimplicit-fallthrough -Wunreachable-code -Woverloaded-virtual -DOBJC_OLD_DISPATCH_PROTOTYPES=0 -O3  -fvisibility=hidden -fvisibility-inlines-hidden -fno-exceptions -fno-rtti -UNDEBUG -fno-sanitize=all -Wall -Wglobal-constructors -Wexit-time-destructors -DswiftCore_EXPORTS -I$PROJECT_PATH/swift/include  -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1 -I$ARM_GCC_PATH/arm-none-eabi/include -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1/arm-none-eabi/thumb/v7e-m+dp/hard  -DSWIFT_TARGET_LIBRARY_NAME=swiftStdlibStubs -target thumbv7em-none-eabihf -mcpu=cortex-m7 -mfloat-abi=hard -O2 -g0 -DNDEBUG -DSWIFT_LIBRARY_EVOLUTION=1 -DSWIFT_RUNTIME_OS_VERSIONING -std=c11 -MD -MT stdlib/public/stubs/CMakeFiles/swiftStdlibStubs-madmachine-thumbv7em-eabihf.dir/$name.o -MF stdlib/public/stubs/CMakeFiles/swiftStdlibStubs-madmachine-thumbv7em-eabihf.dir/$name.o.d -o stdlib/public/stubs/CMakeFiles/swiftStdlibStubs-madmachine-thumbv7em-eabihf.dir/$name.o -c $PROJECT_PATH/swift/stdlib/public/stubs/SimpleUnicodeSupport/$name"
    $COMMAND
done



echo "Processing pthread stubs..."
for f in $PROJECT_PATH/swift/stdlib/public/stubs/PThreadStubs/*.c
do
    name=${f##*/}
    echo "Processing $name"
    COMMAND="$LLVM_PATH/bin/clang -DCMARK_STATIC_DEFINE -DGTEST_HAS_RTTI=0 -DLLVM_DISABLE_ABI_BREAKING_CHECKS_ENFORCING=1 -DSWIFT_INLINE_NAMESPACE=__runtime -D_DEBUG -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -D_GNU_SOURCE -D_POSIX_THREADS -D_POSIX_READER_WRITER_LOCKS -D_UNIX98_THREAD_MUTEX_ATTRIBUTES -D__MADMACHINE__ -Istdlib/public/stubs -I$PROJECT_PATH/swift/stdlib/public/stubs -I$PROJECT_PATH/swift/stdlib/include -Iinclude -I$PROJECT_PATH/swift/include -I$PROJECT_PATH/llvm-project/llvm/include -I$LLVM_PATH/include -I$PROJECT_PATH/llvm-project/clang/include -I$LLVM_PATH/tools/clang/include -I$PROJECT_PATH/cmark/src -I$CMARK_PATH/src -Wno-unknown-warning-option -Werror=unguarded-availability-new -fno-stack-protector -fPIC -fvisibility-inlines-hidden -Werror=date-time -Werror=unguarded-availability-new -Wall -Wextra -Wno-unused-parameter -Wwrite-strings -Wcast-qual -Wmissing-field-initializers -Wimplicit-fallthrough -Wcovered-switch-default -Wno-class-memaccess -Wno-noexcept-type -Wnon-virtual-dtor -Wdelete-non-virtual-dtor -Wstring-conversion -fdiagnostics-color -ffunction-sections -fdata-sections -Werror=switch -Wdocumentation -Wimplicit-fallthrough -Wunreachable-code -Woverloaded-virtual -DOBJC_OLD_DISPATCH_PROTOTYPES=0 -O3  -fvisibility=hidden -fvisibility-inlines-hidden -fno-exceptions -fno-rtti -UNDEBUG -fno-sanitize=all -Wall -Wglobal-constructors -Wexit-time-destructors -DswiftCore_EXPORTS -I$PROJECT_PATH/swift/include  -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1 -I$ARM_GCC_PATH/arm-none-eabi/include -I$ARM_GCC_PATH/arm-none-eabi/include/c++/9.3.1/arm-none-eabi/thumb/v7e-m+dp/hard  -DSWIFT_TARGET_LIBRARY_NAME=swiftStdlibStubs -target thumbv7em-none-eabihf -mcpu=cortex-m7 -mfloat-abi=hard -O2 -g0 -DNDEBUG -DSWIFT_LIBRARY_EVOLUTION=1 -DSWIFT_RUNTIME_OS_VERSIONING -std=c11 -MD -MT stdlib/public/stubs/CMakeFiles/swiftStdlibStubs-madmachine-thumbv7em-eabihf.dir/$name.o -MF stdlib/public/stubs/CMakeFiles/swiftStdlibStubs-madmachine-thumbv7em-eabihf.dir/$name.o.d -o stdlib/public/stubs/CMakeFiles/swiftStdlibStubs-madmachine-thumbv7em-eabihf.dir/$name.o -c $PROJECT_PATH/swift/stdlib/public/stubs/PThreadStubs/$name"
    $COMMAND
done
