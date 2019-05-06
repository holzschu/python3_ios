#!/bin/sh
# to compile for iOS:
# Make sure we include python3 framework
env CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" CXXFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" LDSHARED="-dynamiclib -undefined error -dynamiclib -arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Python3_ios/build/Release-iphoneos/ -framework python3_ios" python3 setup.py build


env CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" CXXFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" LDSHARED="-dynamiclib -undefined error -dynamiclib -arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Python3_ios/build/Release-iphoneos/ -framework python3_ios" PYTHONPATH="../../onIpad/lib/python3.7/site-packages/" python3 setup.py install --prefix ../../onIpad/


echo "Creating all frameworks:"
# Create kiwisolver framework:
for name in python3_ios pythonA pythonB pythonC pythonD pythonE
do
	echo Frameworks/${name}_kiwisolver.framework
	framework=${name}-kiwisolver
	rm -rf ../../Frameworks/$framework.framework
	mkdir ../../Frameworks/$framework.framework
	cp ../../onIpad/lib/python3.7/site-packages/kiwisolver-1.0.1-py3.7-macosx-10.9-x86_64.egg/kiwisolver.cpython-37m-darwin.so ../../Frameworks/$framework.framework/$framework
	# cp ../../plists/${name}_kiwisolver_Info.plist ../../Frameworks/$framework.framework/Info.plist
	cp ../../plists/basic_Info.plist ../../Frameworks/$framework.framework/Info.plist
	plutil -replace CFBundleExecutable -string $framework ../../Frameworks/$framework.framework/Info.plist
	plutil -replace CFBundleName -string $framework ../../Frameworks/$framework.framework/Info.plist
	# underscore is not allowed in CFBundleIdentifier:
	if [ "$name" == python3_ios ]; then 
		signature=python3-ios-kiwisolver
	else
		signature=$framework
	fi
	plutil -replace CFBundleIdentifier -string Nicolas-Holzschuch.$signature  ../../Frameworks/$framework.framework/Info.plist
	install_name_tool -change @rpath/python3_ios.framework/python3_ios @rpath/${name}.framework/${name}  ../../Frameworks/$framework.framework/$framework
	install_name_tool -id @rpath/$framework.framework/$framework   ../../Frameworks/$framework.framework/$framework
done
