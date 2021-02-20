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

HOST_TYPE="swift-$OS_TYPE-x86_64"

cd ../..
PROJECT_PATH=$(cd "$(dirname "$0")";pwd)

SOURCE_PATH="$PROJECT_PATH/swift"
BUILD_PATH="$PROJECT_PATH/build/$BUILD_TYPE/$HOST_TYPE"

if [ ! -d $SOURCE_PATH ]; then
    echo "$SOURCE_PATH not exists!"
    exit
fi

if [ ! -d $BUILD_PATH ]; then
    echo "$BUILD_PATH not exists!"
    exit
fi




echo "Processing gyb files..."
mkdir -p $BUILD_PATH/stdlib/public/core/4
rm -f $BUILD_PATH/stdlib/public/core/4/*

cd $BUILD_PATH/stdlib/public/core/4
cp $SOURCE_PATH/stdlib/public/core/*.gyb ./

for f in `ls *.gyb`
do
    #echo "Processing $f"
    name=${f%.gyb}
    $SOURCE_PATH/utils/gyb -D CMAKE_SIZEOF_VOID_P=4 -o $name $f 
done

rm -f $BUILD_PATH/stdlib/public/core/4/*.gyb




echo "Generating Swift.o..."
mkdir -p $BUILD_PATH/stdlib/public/core/MADMACHINE/thumbv7em
rm -f $BUILD_PATH/stdlib/public/core/MADMACHINE/thumbv7em/Swift.o

cd $BUILD_PATH

$BUILD_PATH/bin/swiftc -c -sdk / -target thumbv7em-none--eabi -target-cpu cortex-m7 -Xfrontend -function-sections -Xfrontend -data-sections -resource-dir $BUILD_PATH/./lib/swift -O -D SWIFT_ENABLE_EXPERIMENTAL_DIFFERENTIABLE_PROGRAMMING -D SWIFT_RUNTIME_OS_VERSIONING -module-cache-path $BUILD_PATH/./module-cache -no-link-objc-runtime -enable-library-evolution -Xfrontend -enforce-exclusivity=unchecked -nostdimport -parse-stdlib -module-name Swift -Xfrontend -group-info-path -Xfrontend $SOURCE_PATH/stdlib/public/core/GroupInfo.json -swift-version 5 -runtime-compatibility-version none -disable-autolinking-runtime-compatibility-dynamic-replacements -warn-swift3-objc-inference-complete -Xfrontend -verify-syntax-tree -Xllvm -sil-inline-generics -Xllvm -sil-partial-specialization -Xfrontend -enable-experimental-concise-pound-file -Xcc -DswiftCore_EXPORTS -warn-implicit-overrides -Xfrontend -disable-implicit-concurrency-module-import -module-link-name swiftCore -whole-module-optimization -parse-as-library -o $BUILD_PATH/stdlib/public/core/MADMACHINE/thumbv7em/Swift.o $SOURCE_PATH/stdlib/public/core/Algorithm.swift $SOURCE_PATH/stdlib/public/core/ArrayBody.swift $SOURCE_PATH/stdlib/public/core/ArrayBuffer.swift $SOURCE_PATH/stdlib/public/core/ArrayBufferProtocol.swift $SOURCE_PATH/stdlib/public/core/ArrayCast.swift $SOURCE_PATH/stdlib/public/core/Array.swift $SOURCE_PATH/stdlib/public/core/ArrayShared.swift $SOURCE_PATH/stdlib/public/core/ArraySlice.swift $SOURCE_PATH/stdlib/public/core/ArrayType.swift $SOURCE_PATH/stdlib/public/core/ASCII.swift $SOURCE_PATH/stdlib/public/core/Assert.swift $SOURCE_PATH/stdlib/public/core/AssertCommon.swift $SOURCE_PATH/stdlib/public/core/BidirectionalCollection.swift $SOURCE_PATH/stdlib/public/core/Bitset.swift $SOURCE_PATH/stdlib/public/core/Bool.swift $SOURCE_PATH/stdlib/public/core/BridgeObjectiveC.swift $SOURCE_PATH/stdlib/public/core/BridgeStorage.swift $SOURCE_PATH/stdlib/public/core/BridgingBuffer.swift $SOURCE_PATH/stdlib/public/core/Builtin.swift $SOURCE_PATH/stdlib/public/core/BuiltinMath.swift $SOURCE_PATH/stdlib/public/core/Character.swift $SOURCE_PATH/stdlib/public/core/CocoaArray.swift $SOURCE_PATH/stdlib/public/core/Codable.swift $SOURCE_PATH/stdlib/public/core/Collection.swift $SOURCE_PATH/stdlib/public/core/CollectionAlgorithms.swift $SOURCE_PATH/stdlib/public/core/Comparable.swift $SOURCE_PATH/stdlib/public/core/CompilerProtocols.swift $SOURCE_PATH/stdlib/public/core/ContiguousArray.swift $SOURCE_PATH/stdlib/public/core/ContiguouslyStored.swift $SOURCE_PATH/stdlib/public/core/ClosedRange.swift $SOURCE_PATH/stdlib/public/core/ContiguousArrayBuffer.swift $SOURCE_PATH/stdlib/public/core/CString.swift $SOURCE_PATH/stdlib/public/core/CTypes.swift $SOURCE_PATH/stdlib/public/core/DebuggerSupport.swift $SOURCE_PATH/stdlib/public/core/Dictionary.swift $SOURCE_PATH/stdlib/public/core/DictionaryBridging.swift $SOURCE_PATH/stdlib/public/core/DictionaryBuilder.swift $SOURCE_PATH/stdlib/public/core/DictionaryCasting.swift $SOURCE_PATH/stdlib/public/core/DictionaryStorage.swift $SOURCE_PATH/stdlib/public/core/DictionaryVariant.swift $SOURCE_PATH/stdlib/public/core/DropWhile.swift $SOURCE_PATH/stdlib/public/core/Dump.swift $SOURCE_PATH/stdlib/public/core/EmptyCollection.swift $SOURCE_PATH/stdlib/public/core/Equatable.swift $SOURCE_PATH/stdlib/public/core/ErrorType.swift $SOURCE_PATH/stdlib/public/core/ExistentialCollection.swift $SOURCE_PATH/stdlib/public/core/Filter.swift $SOURCE_PATH/stdlib/public/core/FixedArray.swift $SOURCE_PATH/stdlib/public/core/FlatMap.swift $SOURCE_PATH/stdlib/public/core/Flatten.swift $SOURCE_PATH/stdlib/public/core/FloatingPoint.swift $SOURCE_PATH/stdlib/public/core/Hashable.swift $SOURCE_PATH/stdlib/public/core/AnyHashable.swift $SOURCE_PATH/stdlib/public/core/Hasher.swift $SOURCE_PATH/stdlib/public/core/Hashing.swift $SOURCE_PATH/stdlib/public/core/HashTable.swift $SOURCE_PATH/stdlib/public/core/ICU.swift $SOURCE_PATH/stdlib/public/core/Identifiable.swift $SOURCE_PATH/stdlib/public/core/Indices.swift $SOURCE_PATH/stdlib/public/core/InputStream.swift $SOURCE_PATH/stdlib/public/core/IntegerParsing.swift $SOURCE_PATH/stdlib/public/core/Integers.swift $SOURCE_PATH/stdlib/public/core/Join.swift $SOURCE_PATH/stdlib/public/core/KeyPath.swift $SOURCE_PATH/stdlib/public/core/KeyValuePairs.swift $SOURCE_PATH/stdlib/public/core/LazyCollection.swift $SOURCE_PATH/stdlib/public/core/LazySequence.swift $SOURCE_PATH/stdlib/public/core/LegacyABI.swift $SOURCE_PATH/stdlib/public/core/LifetimeManager.swift $SOURCE_PATH/stdlib/public/core/ManagedBuffer.swift $SOURCE_PATH/stdlib/public/core/Map.swift $SOURCE_PATH/stdlib/public/core/MemoryLayout.swift $SOURCE_PATH/stdlib/public/core/UnicodeScalar.swift $SOURCE_PATH/stdlib/public/core/Mirrors.swift $SOURCE_PATH/stdlib/public/core/Misc.swift $SOURCE_PATH/stdlib/public/core/MutableCollection.swift $SOURCE_PATH/stdlib/public/core/NativeDictionary.swift $SOURCE_PATH/stdlib/public/core/NativeSet.swift $SOURCE_PATH/stdlib/public/core/NewtypeWrapper.swift $SOURCE_PATH/stdlib/public/core/ObjectIdentifier.swift $SOURCE_PATH/stdlib/public/core/Optional.swift $SOURCE_PATH/stdlib/public/core/OptionSet.swift $SOURCE_PATH/stdlib/public/core/OutputStream.swift $SOURCE_PATH/stdlib/public/core/Pointer.swift $SOURCE_PATH/stdlib/public/core/Policy.swift $SOURCE_PATH/stdlib/public/core/PrefixWhile.swift $SOURCE_PATH/stdlib/public/core/Prespecialize.swift $SOURCE_PATH/stdlib/public/core/Print.swift $SOURCE_PATH/stdlib/public/core/PtrAuth.swift $SOURCE_PATH/stdlib/public/core/Random.swift $SOURCE_PATH/stdlib/public/core/RandomAccessCollection.swift $SOURCE_PATH/stdlib/public/core/Range.swift $SOURCE_PATH/stdlib/public/core/RangeReplaceableCollection.swift $SOURCE_PATH/stdlib/public/core/ReflectionMirror.swift $SOURCE_PATH/stdlib/public/core/Repeat.swift $SOURCE_PATH/stdlib/public/core/REPL.swift $SOURCE_PATH/stdlib/public/core/Result.swift $SOURCE_PATH/stdlib/public/core/Reverse.swift $SOURCE_PATH/stdlib/public/core/Runtime.swift $SOURCE_PATH/stdlib/public/core/RuntimeFunctionCounters.swift $SOURCE_PATH/stdlib/public/core/SipHash.swift $SOURCE_PATH/stdlib/public/core/Sequence.swift $SOURCE_PATH/stdlib/public/core/SequenceAlgorithms.swift $SOURCE_PATH/stdlib/public/core/Set.swift $SOURCE_PATH/stdlib/public/core/SetAlgebra.swift $SOURCE_PATH/stdlib/public/core/SetAnyHashableExtensions.swift $SOURCE_PATH/stdlib/public/core/SetBridging.swift $SOURCE_PATH/stdlib/public/core/SetBuilder.swift $SOURCE_PATH/stdlib/public/core/SetCasting.swift $SOURCE_PATH/stdlib/public/core/SetStorage.swift $SOURCE_PATH/stdlib/public/core/SetVariant.swift $SOURCE_PATH/stdlib/public/core/ShadowProtocols.swift $SOURCE_PATH/stdlib/public/core/Shims.swift $SOURCE_PATH/stdlib/public/core/Slice.swift $SOURCE_PATH/stdlib/public/core/SmallString.swift $SOURCE_PATH/stdlib/public/core/Sort.swift $SOURCE_PATH/stdlib/public/core/StaticString.swift $SOURCE_PATH/stdlib/public/core/Stride.swift $SOURCE_PATH/stdlib/public/core/StringHashable.swift $SOURCE_PATH/stdlib/public/core/String.swift $SOURCE_PATH/stdlib/public/core/StringBreadcrumbs.swift $SOURCE_PATH/stdlib/public/core/StringBridge.swift $SOURCE_PATH/stdlib/public/core/StringCharacterView.swift $SOURCE_PATH/stdlib/public/core/StringComparable.swift $SOURCE_PATH/stdlib/public/core/StringComparison.swift $SOURCE_PATH/stdlib/public/core/StringCreate.swift $SOURCE_PATH/stdlib/public/core/StringGuts.swift $SOURCE_PATH/stdlib/public/core/StringGutsSlice.swift $SOURCE_PATH/stdlib/public/core/StringGutsRangeReplaceable.swift $SOURCE_PATH/stdlib/public/core/StringObject.swift $SOURCE_PATH/stdlib/public/core/StringProtocol.swift $SOURCE_PATH/stdlib/public/core/StringIndex.swift $SOURCE_PATH/stdlib/public/core/StringIndexConversions.swift $SOURCE_PATH/stdlib/public/core/StringInterpolation.swift $SOURCE_PATH/stdlib/public/core/StringLegacy.swift $SOURCE_PATH/stdlib/public/core/StringNormalization.swift $SOURCE_PATH/stdlib/public/core/StringRangeReplaceableCollection.swift $SOURCE_PATH/stdlib/public/core/StringStorage.swift $SOURCE_PATH/stdlib/public/core/StringStorageBridge.swift $SOURCE_PATH/stdlib/public/core/StringSwitch.swift $SOURCE_PATH/stdlib/public/core/StringTesting.swift $SOURCE_PATH/stdlib/public/core/StringUnicodeScalarView.swift $SOURCE_PATH/stdlib/public/core/StringUTF16View.swift $SOURCE_PATH/stdlib/public/core/StringUTF8View.swift $SOURCE_PATH/stdlib/public/core/StringUTF8Validation.swift $SOURCE_PATH/stdlib/public/core/Substring.swift $SOURCE_PATH/stdlib/public/core/SwiftNativeNSArray.swift $SOURCE_PATH/stdlib/public/core/ThreadLocalStorage.swift $SOURCE_PATH/stdlib/public/core/UIntBuffer.swift $SOURCE_PATH/stdlib/public/core/UnavailableStringAPIs.swift $SOURCE_PATH/stdlib/public/core/UnicodeEncoding.swift $SOURCE_PATH/stdlib/public/core/UnicodeHelpers.swift $SOURCE_PATH/stdlib/public/core/UnicodeParser.swift $SOURCE_PATH/stdlib/public/core/UnicodeScalarProperties.swift $SOURCE_PATH/stdlib/public/core/CharacterProperties.swift $SOURCE_PATH/stdlib/public/core/Unmanaged.swift $SOURCE_PATH/stdlib/public/core/UnmanagedOpaqueString.swift $SOURCE_PATH/stdlib/public/core/UnmanagedString.swift $SOURCE_PATH/stdlib/public/core/UnsafePointer.swift $SOURCE_PATH/stdlib/public/core/UnsafeRawPointer.swift $SOURCE_PATH/stdlib/public/core/UTFEncoding.swift $SOURCE_PATH/stdlib/public/core/UTF8.swift $SOURCE_PATH/stdlib/public/core/UTF16.swift $SOURCE_PATH/stdlib/public/core/UTF32.swift $SOURCE_PATH/stdlib/public/core/Unicode.swift $SOURCE_PATH/stdlib/public/core/StringGraphemeBreaking.swift $SOURCE_PATH/stdlib/public/core/ValidUTF8Buffer.swift $SOURCE_PATH/stdlib/public/core/WriteBackMutableSlice.swift $SOURCE_PATH/stdlib/public/core/MigrationSupport.swift $SOURCE_PATH/stdlib/public/core/Availability.swift $SOURCE_PATH/stdlib/public/core/CollectionDifference.swift $SOURCE_PATH/stdlib/public/core/CollectionOfOne.swift $SOURCE_PATH/stdlib/public/core/Diffing.swift $SOURCE_PATH/stdlib/public/core/FloatingPointRandom.swift $SOURCE_PATH/stdlib/public/core/Mirror.swift $SOURCE_PATH/stdlib/public/core/PlaygroundDisplay.swift $SOURCE_PATH/stdlib/public/core/CommandLine.swift $SOURCE_PATH/stdlib/public/core/SliceBuffer.swift $SOURCE_PATH/stdlib/public/core/SIMDVector.swift $SOURCE_PATH/stdlib/public/core/UnfoldSequence.swift $SOURCE_PATH/stdlib/public/core/VarArgs.swift $SOURCE_PATH/stdlib/public/core/Zip.swift $BUILD_PATH/stdlib/public/core/4/AtomicInt.swift $BUILD_PATH/stdlib/public/core/4/FloatingPointParsing.swift $BUILD_PATH/stdlib/public/core/4/FloatingPointTypes.swift $BUILD_PATH/stdlib/public/core/4/IntegerTypes.swift $BUILD_PATH/stdlib/public/core/4/UnsafeBufferPointer.swift $BUILD_PATH/stdlib/public/core/4/UnsafeRawBufferPointer.swift $BUILD_PATH/stdlib/public/core/4/SIMDVectorTypes.swift $BUILD_PATH/stdlib/public/core/4/Tuple.swift




echo "Generating swiftmodule..."
mkdir -p $BUILD_PATH/./lib/swift/madmachine/Swift.swiftmodule
rm -f $BUILD_PATH/./lib/swift/madmachine/Swift.swiftmodule/*.swift*

cd $BUILD_PATH

$BUILD_PATH/bin/swiftc -emit-module -o $BUILD_PATH/./lib/swift/madmachine/Swift.swiftmodule/thumbv7em-none--eabi.swiftmodule -avoid-emit-module-source-info -sdk / -target thumbv7em-none--eabi -target-cpu cortex-m7 -Xfrontend -function-sections -Xfrontend -data-sections -resource-dir $BUILD_PATH/./lib/swift -O -D SWIFT_ENABLE_EXPERIMENTAL_DIFFERENTIABLE_PROGRAMMING -D SWIFT_RUNTIME_OS_VERSIONING -module-cache-path $BUILD_PATH/./module-cache -no-link-objc-runtime -enable-library-evolution -Xfrontend -enforce-exclusivity=unchecked -nostdimport -parse-stdlib -module-name Swift -Xfrontend -group-info-path -Xfrontend $SOURCE_PATH/stdlib/public/core/GroupInfo.json -swift-version 5 -runtime-compatibility-version none -disable-autolinking-runtime-compatibility-dynamic-replacements -warn-swift3-objc-inference-complete -Xfrontend -verify-syntax-tree -Xllvm -sil-inline-generics -Xllvm -sil-partial-specialization -Xfrontend -enable-experimental-concise-pound-file -Xcc -DswiftCore_EXPORTS -warn-implicit-overrides -Xfrontend -disable-implicit-concurrency-module-import -module-link-name swiftCore -whole-module-optimization -parse-as-library -emit-module-interface-path $BUILD_PATH/./lib/swift/madmachine/Swift.swiftmodule/thumbv7em-none--eabi.swiftinterface $SOURCE_PATH/stdlib/public/core/Algorithm.swift $SOURCE_PATH/stdlib/public/core/ArrayBody.swift $SOURCE_PATH/stdlib/public/core/ArrayBuffer.swift $SOURCE_PATH/stdlib/public/core/ArrayBufferProtocol.swift $SOURCE_PATH/stdlib/public/core/ArrayCast.swift $SOURCE_PATH/stdlib/public/core/Array.swift $SOURCE_PATH/stdlib/public/core/ArrayShared.swift $SOURCE_PATH/stdlib/public/core/ArraySlice.swift $SOURCE_PATH/stdlib/public/core/ArrayType.swift $SOURCE_PATH/stdlib/public/core/ASCII.swift $SOURCE_PATH/stdlib/public/core/Assert.swift $SOURCE_PATH/stdlib/public/core/AssertCommon.swift $SOURCE_PATH/stdlib/public/core/BidirectionalCollection.swift $SOURCE_PATH/stdlib/public/core/Bitset.swift $SOURCE_PATH/stdlib/public/core/Bool.swift $SOURCE_PATH/stdlib/public/core/BridgeObjectiveC.swift $SOURCE_PATH/stdlib/public/core/BridgeStorage.swift $SOURCE_PATH/stdlib/public/core/BridgingBuffer.swift $SOURCE_PATH/stdlib/public/core/Builtin.swift $SOURCE_PATH/stdlib/public/core/BuiltinMath.swift $SOURCE_PATH/stdlib/public/core/Character.swift $SOURCE_PATH/stdlib/public/core/CocoaArray.swift $SOURCE_PATH/stdlib/public/core/Codable.swift $SOURCE_PATH/stdlib/public/core/Collection.swift $SOURCE_PATH/stdlib/public/core/CollectionAlgorithms.swift $SOURCE_PATH/stdlib/public/core/Comparable.swift $SOURCE_PATH/stdlib/public/core/CompilerProtocols.swift $SOURCE_PATH/stdlib/public/core/ContiguousArray.swift $SOURCE_PATH/stdlib/public/core/ContiguouslyStored.swift $SOURCE_PATH/stdlib/public/core/ClosedRange.swift $SOURCE_PATH/stdlib/public/core/ContiguousArrayBuffer.swift $SOURCE_PATH/stdlib/public/core/CString.swift $SOURCE_PATH/stdlib/public/core/CTypes.swift $SOURCE_PATH/stdlib/public/core/DebuggerSupport.swift $SOURCE_PATH/stdlib/public/core/Dictionary.swift $SOURCE_PATH/stdlib/public/core/DictionaryBridging.swift $SOURCE_PATH/stdlib/public/core/DictionaryBuilder.swift $SOURCE_PATH/stdlib/public/core/DictionaryCasting.swift $SOURCE_PATH/stdlib/public/core/DictionaryStorage.swift $SOURCE_PATH/stdlib/public/core/DictionaryVariant.swift $SOURCE_PATH/stdlib/public/core/DropWhile.swift $SOURCE_PATH/stdlib/public/core/Dump.swift $SOURCE_PATH/stdlib/public/core/EmptyCollection.swift $SOURCE_PATH/stdlib/public/core/Equatable.swift $SOURCE_PATH/stdlib/public/core/ErrorType.swift $SOURCE_PATH/stdlib/public/core/ExistentialCollection.swift $SOURCE_PATH/stdlib/public/core/Filter.swift $SOURCE_PATH/stdlib/public/core/FixedArray.swift $SOURCE_PATH/stdlib/public/core/FlatMap.swift $SOURCE_PATH/stdlib/public/core/Flatten.swift $SOURCE_PATH/stdlib/public/core/FloatingPoint.swift $SOURCE_PATH/stdlib/public/core/Hashable.swift $SOURCE_PATH/stdlib/public/core/AnyHashable.swift $SOURCE_PATH/stdlib/public/core/Hasher.swift $SOURCE_PATH/stdlib/public/core/Hashing.swift $SOURCE_PATH/stdlib/public/core/HashTable.swift $SOURCE_PATH/stdlib/public/core/ICU.swift $SOURCE_PATH/stdlib/public/core/Identifiable.swift $SOURCE_PATH/stdlib/public/core/Indices.swift $SOURCE_PATH/stdlib/public/core/InputStream.swift $SOURCE_PATH/stdlib/public/core/IntegerParsing.swift $SOURCE_PATH/stdlib/public/core/Integers.swift $SOURCE_PATH/stdlib/public/core/Join.swift $SOURCE_PATH/stdlib/public/core/KeyPath.swift $SOURCE_PATH/stdlib/public/core/KeyValuePairs.swift $SOURCE_PATH/stdlib/public/core/LazyCollection.swift $SOURCE_PATH/stdlib/public/core/LazySequence.swift $SOURCE_PATH/stdlib/public/core/LegacyABI.swift $SOURCE_PATH/stdlib/public/core/LifetimeManager.swift $SOURCE_PATH/stdlib/public/core/ManagedBuffer.swift $SOURCE_PATH/stdlib/public/core/Map.swift $SOURCE_PATH/stdlib/public/core/MemoryLayout.swift $SOURCE_PATH/stdlib/public/core/UnicodeScalar.swift $SOURCE_PATH/stdlib/public/core/Mirrors.swift $SOURCE_PATH/stdlib/public/core/Misc.swift $SOURCE_PATH/stdlib/public/core/MutableCollection.swift $SOURCE_PATH/stdlib/public/core/NativeDictionary.swift $SOURCE_PATH/stdlib/public/core/NativeSet.swift $SOURCE_PATH/stdlib/public/core/NewtypeWrapper.swift $SOURCE_PATH/stdlib/public/core/ObjectIdentifier.swift $SOURCE_PATH/stdlib/public/core/Optional.swift $SOURCE_PATH/stdlib/public/core/OptionSet.swift $SOURCE_PATH/stdlib/public/core/OutputStream.swift $SOURCE_PATH/stdlib/public/core/Pointer.swift $SOURCE_PATH/stdlib/public/core/Policy.swift $SOURCE_PATH/stdlib/public/core/PrefixWhile.swift $SOURCE_PATH/stdlib/public/core/Prespecialize.swift $SOURCE_PATH/stdlib/public/core/Print.swift $SOURCE_PATH/stdlib/public/core/PtrAuth.swift $SOURCE_PATH/stdlib/public/core/Random.swift $SOURCE_PATH/stdlib/public/core/RandomAccessCollection.swift $SOURCE_PATH/stdlib/public/core/Range.swift $SOURCE_PATH/stdlib/public/core/RangeReplaceableCollection.swift $SOURCE_PATH/stdlib/public/core/ReflectionMirror.swift $SOURCE_PATH/stdlib/public/core/Repeat.swift $SOURCE_PATH/stdlib/public/core/REPL.swift $SOURCE_PATH/stdlib/public/core/Result.swift $SOURCE_PATH/stdlib/public/core/Reverse.swift $SOURCE_PATH/stdlib/public/core/Runtime.swift $SOURCE_PATH/stdlib/public/core/RuntimeFunctionCounters.swift $SOURCE_PATH/stdlib/public/core/SipHash.swift $SOURCE_PATH/stdlib/public/core/Sequence.swift $SOURCE_PATH/stdlib/public/core/SequenceAlgorithms.swift $SOURCE_PATH/stdlib/public/core/Set.swift $SOURCE_PATH/stdlib/public/core/SetAlgebra.swift $SOURCE_PATH/stdlib/public/core/SetAnyHashableExtensions.swift $SOURCE_PATH/stdlib/public/core/SetBridging.swift $SOURCE_PATH/stdlib/public/core/SetBuilder.swift $SOURCE_PATH/stdlib/public/core/SetCasting.swift $SOURCE_PATH/stdlib/public/core/SetStorage.swift $SOURCE_PATH/stdlib/public/core/SetVariant.swift $SOURCE_PATH/stdlib/public/core/ShadowProtocols.swift $SOURCE_PATH/stdlib/public/core/Shims.swift $SOURCE_PATH/stdlib/public/core/Slice.swift $SOURCE_PATH/stdlib/public/core/SmallString.swift $SOURCE_PATH/stdlib/public/core/Sort.swift $SOURCE_PATH/stdlib/public/core/StaticString.swift $SOURCE_PATH/stdlib/public/core/Stride.swift $SOURCE_PATH/stdlib/public/core/StringHashable.swift $SOURCE_PATH/stdlib/public/core/String.swift $SOURCE_PATH/stdlib/public/core/StringBreadcrumbs.swift $SOURCE_PATH/stdlib/public/core/StringBridge.swift $SOURCE_PATH/stdlib/public/core/StringCharacterView.swift $SOURCE_PATH/stdlib/public/core/StringComparable.swift $SOURCE_PATH/stdlib/public/core/StringComparison.swift $SOURCE_PATH/stdlib/public/core/StringCreate.swift $SOURCE_PATH/stdlib/public/core/StringGuts.swift $SOURCE_PATH/stdlib/public/core/StringGutsSlice.swift $SOURCE_PATH/stdlib/public/core/StringGutsRangeReplaceable.swift $SOURCE_PATH/stdlib/public/core/StringObject.swift $SOURCE_PATH/stdlib/public/core/StringProtocol.swift $SOURCE_PATH/stdlib/public/core/StringIndex.swift $SOURCE_PATH/stdlib/public/core/StringIndexConversions.swift $SOURCE_PATH/stdlib/public/core/StringInterpolation.swift $SOURCE_PATH/stdlib/public/core/StringLegacy.swift $SOURCE_PATH/stdlib/public/core/StringNormalization.swift $SOURCE_PATH/stdlib/public/core/StringRangeReplaceableCollection.swift $SOURCE_PATH/stdlib/public/core/StringStorage.swift $SOURCE_PATH/stdlib/public/core/StringStorageBridge.swift $SOURCE_PATH/stdlib/public/core/StringSwitch.swift $SOURCE_PATH/stdlib/public/core/StringTesting.swift $SOURCE_PATH/stdlib/public/core/StringUnicodeScalarView.swift $SOURCE_PATH/stdlib/public/core/StringUTF16View.swift $SOURCE_PATH/stdlib/public/core/StringUTF8View.swift $SOURCE_PATH/stdlib/public/core/StringUTF8Validation.swift $SOURCE_PATH/stdlib/public/core/Substring.swift $SOURCE_PATH/stdlib/public/core/SwiftNativeNSArray.swift $SOURCE_PATH/stdlib/public/core/ThreadLocalStorage.swift $SOURCE_PATH/stdlib/public/core/UIntBuffer.swift $SOURCE_PATH/stdlib/public/core/UnavailableStringAPIs.swift $SOURCE_PATH/stdlib/public/core/UnicodeEncoding.swift $SOURCE_PATH/stdlib/public/core/UnicodeHelpers.swift $SOURCE_PATH/stdlib/public/core/UnicodeParser.swift $SOURCE_PATH/stdlib/public/core/UnicodeScalarProperties.swift $SOURCE_PATH/stdlib/public/core/CharacterProperties.swift $SOURCE_PATH/stdlib/public/core/Unmanaged.swift $SOURCE_PATH/stdlib/public/core/UnmanagedOpaqueString.swift $SOURCE_PATH/stdlib/public/core/UnmanagedString.swift $SOURCE_PATH/stdlib/public/core/UnsafePointer.swift $SOURCE_PATH/stdlib/public/core/UnsafeRawPointer.swift $SOURCE_PATH/stdlib/public/core/UTFEncoding.swift $SOURCE_PATH/stdlib/public/core/UTF8.swift $SOURCE_PATH/stdlib/public/core/UTF16.swift $SOURCE_PATH/stdlib/public/core/UTF32.swift $SOURCE_PATH/stdlib/public/core/Unicode.swift $SOURCE_PATH/stdlib/public/core/StringGraphemeBreaking.swift $SOURCE_PATH/stdlib/public/core/ValidUTF8Buffer.swift $SOURCE_PATH/stdlib/public/core/WriteBackMutableSlice.swift $SOURCE_PATH/stdlib/public/core/MigrationSupport.swift $SOURCE_PATH/stdlib/public/core/Availability.swift $SOURCE_PATH/stdlib/public/core/CollectionDifference.swift $SOURCE_PATH/stdlib/public/core/CollectionOfOne.swift $SOURCE_PATH/stdlib/public/core/Diffing.swift $SOURCE_PATH/stdlib/public/core/FloatingPointRandom.swift $SOURCE_PATH/stdlib/public/core/Mirror.swift $SOURCE_PATH/stdlib/public/core/PlaygroundDisplay.swift $SOURCE_PATH/stdlib/public/core/CommandLine.swift $SOURCE_PATH/stdlib/public/core/SliceBuffer.swift $SOURCE_PATH/stdlib/public/core/SIMDVector.swift $SOURCE_PATH/stdlib/public/core/UnfoldSequence.swift $SOURCE_PATH/stdlib/public/core/VarArgs.swift $SOURCE_PATH/stdlib/public/core/Zip.swift $BUILD_PATH/stdlib/public/core/4/AtomicInt.swift $BUILD_PATH/stdlib/public/core/4/FloatingPointParsing.swift $BUILD_PATH/stdlib/public/core/4/FloatingPointTypes.swift $BUILD_PATH/stdlib/public/core/4/IntegerTypes.swift $BUILD_PATH/stdlib/public/core/4/UnsafeBufferPointer.swift $BUILD_PATH/stdlib/public/core/4/UnsafeRawBufferPointer.swift $BUILD_PATH/stdlib/public/core/4/SIMDVectorTypes.swift $BUILD_PATH/stdlib/public/core/4/Tuple.swift
