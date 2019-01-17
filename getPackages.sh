#!/bin/bash


HHROOT="https://github.com/holzschu"
IOS_SYSTEM_VER="2.2"

# Python-3.7.1
rm -rf Python-3.7.1
echo "Downloading Python 3.7.1"
curl -OL https://www.python.org/ftp/python/3.7.1/Python-3.7.1.tgz
tar -xzf Python-3.7.1.tgz
rm Python-3.7.1.tgz
echo "Downloading ios_system.framework"
(cd Frameworks
curl -OL $HHROOT/ios_system/releases/download/v$IOS_SYSTEM_VER/smallRelease.tar.gz
( tar -xzf smallRelease.tar.gz --strip 1 && rm smallRelease.tar.gz ) || { echo "ios_system failed to download"; exit 1; }
)
echo "Downloading header file:"
curl -OL $HHROOT/ios_system/releases/download/v$IOS_SYSTEM_VER/ios_error.h

echo "Downloading libffi-3.2.1"
rm -rf libffi-3.2.1
curl -OL https://www.mirrorservice.org/sites/sourceware.org/pub/libffi/libffi-3.2.1.tar.gz
tar -xvzf libffi-3.2.1.tar.gz
rm libffi-3.2.1.tar.gz
echo "Applying patch to libffi-3.2.1:"
(cd libffi-3.2.1 ; patch -p 1 < ../libffi-3.2.1_patch ; cd ..)
echo "Compiling libffi-3.2.1:"
(cd libffi-3.2.1 ;  xcodebuild -project libffi.xcodeproj -target libffi-iOS -sdk iphoneos -arch arm64 -configuration Debug -quiet; mv build/Debug-iphoneos/libffi.a .. ; cd ..)

echo "Downloading zeromq:"
rm -rf zeromq-4.2.5
curl -OL https://github.com/zeromq/libzmq/releases/download/v4.2.5/zeromq-4.2.5.tar.gz
tar -xzf zeromq-4.2.5.tar.gz
rm zeromq-4.2.5.tar.gz
echo "Applying patch to zeromq:"
(cd zeromq-4.2.5 ; patch -p 1 < ../zeromq.patch ; cd ..)
echo "Compiling zeromq:"
(cd zeromq-4.2.5 ; ./configure CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=12.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -fembed-bitcode" CXXFLAGS="-arch arm64 -miphoneos-version-min=12.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -fembed-bitcode" CPPFLAGS="-arch arm64 -miphoneos-version-min=12.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" --build=x86_64-apple-darwin --host=armv7-apple-darwin ; make ; mv src/.libs/libzmq.a .. ; cd ..)

echo "Applying patch to Python-3.7.1"
(cd Python-3.7.1  ; patch -p 1 < ../Python_Include.patch ; patch -p 1 < ../Python_Lib.patch ; patch -p 1 < ../Python_Modules.patch; patch -p 1 < ../Python_Parser.patch ; patch -p 1 < ../Python_Python.patch; patch -p 1 < ../Python_setup.patch ; patch -p 1 < ../Python_Objects.patch; cd ..)
echo "All done. Now let's build the Python3 framework:" 
xcodebuild -project Python3_ios/Python3_ios.xcodeproj -sdk iphoneos -arch arm64 -configuration Debug -quiet
# duplicate python3 to pythonE:
cp -r Python3_ios/build/Debug-iphoneos/Python3_ios.framework Python3_ios/build/Debug-iphoneos/PythonE.framework
cp pythonE.plist Python3_ios/build/Debug-iphoneos/PythonE.framework/Info.plist
echo "All done. The framework in in Python3_ios/build/Debug-iphoneos/Python3_ios.framework."


