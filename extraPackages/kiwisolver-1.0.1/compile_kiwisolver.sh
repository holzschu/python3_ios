#!/bin/sh
# to compile for iOS:
# Make sure we include python3 framework
env CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" CXXFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" LDSHARED="-dynamiclib -undefined error -dynamiclib -arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Python3_ios/build/Debug-iphoneos/ -framework Python3_ios" python3 setup.py build


env CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" CXXFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" LDSHARED="-dynamiclib -undefined error -dynamiclib -arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Python3_ios/build/Debug-iphoneos/ -framework Python3_ios" PYTHONPATH="../../onIpad/lib/python3.7/site-packages/" python3 setup.py install --prefix ../../onIpad/


echo "Creating all frameworks:"
# Create kiwisolver framework:
for name in python3_ios pythonA pythonB pythonC pythonD pythonE
do
	echo Frameworks/${name}_kiwisolver.framework
	rm -rf ../../Frameworks/${name}-kiwisolver.framework
	mkdir ../../Frameworks/${name}-kiwisolver.framework
	cp ../../onIpad/lib/python3.7/site-packages/kiwisolver-1.0.1-py3.7-macosx-10.9-x86_64.egg/kiwisolver.cpython-37m-darwin.so ../../Frameworks/${name}-kiwisolver.framework/${name}-kiwisolver
	cp ../../plists/${name}_kiwisolver_Info.plist ../../Frameworks/${name}-kiwisolver.framework/Info.plist
	install_name_tool -change @rpath/Python3_ios.framework/Python3_ios @rpath/${name}.framework/${name}  ../../Frameworks/${name}-kiwisolver.framework/${name}-kiwisolver
	install_name_tool -id @rpath/${name}-kiwisolver.framework/${name}-kiwisolver   ../../Frameworks/${name}-kiwisolver.framework/${name}-kiwisolver
done
