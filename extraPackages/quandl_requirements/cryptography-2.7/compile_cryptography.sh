#!/bin/sh


env CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../../Python-3.7.1/Include/ -I../../../Python-3.7.1/ -I../../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../../Frameworks" LDSHARED="clang -v -undefined error -dynamiclib -arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../../Python3_ios/build/Release-iphoneos/ -framework python3_ios -framework ios_system -F ../../../Frameworks -framework openssl" python3 setup.py build

env CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../../Python-3.7.1/Include/ -I../../../Python-3.7.1/ -I../../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../../Frameworks" LDSHARED="clang -v -undefined error -dynamiclib -arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../../Python3_ios/build/Release-iphoneos/ -framework python3_ios -framework ios_system -F ../../../Frameworks -framework openssl" PYTHONPATH="../../../onIpad/lib/python3.7/site-packages/" python3 setup.py install  --prefix ../../../onIpad/

# Dynamic libraries created (excluding tests):
# ../../../onIpad/lib/python3.7/site-packages/cryptography-2.6.1-py3.7-macosx-10.9-x86_64.egg/cryptography//hazmat/bindings/_padding.abi3.so
# ../../../onIpad/lib/python3.7/site-packages/cryptography-2.6.1-py3.7-macosx-10.9-x86_64.egg/cryptography//hazmat/bindings/_constant_time.abi3.so
# ../../../onIpad/lib/python3.7/site-packages/cryptography-2.6.1-py3.7-macosx-10.9-x86_64.egg/cryptography//hazmat/bindings/_openssl.abi3.so

echo "Creating all frameworks:"
directory=../../../onIpad/lib/python3.7/site-packages/cryptography-2.7-py3.7-macosx-10.9-x86_64.egg/cryptography/
for library in hazmat/bindings/_padding hazmat/bindings/_constant_time hazmat/bindings/_openssl
do
	libraryFile=$directory/${library}.abi3.so
	converted=${library//\//.}
	package=cryptography.$converted
	for name in python3_ios pythonA pythonB pythonC pythonD pythonE
	do
		echo "Creating: " Frameworks/${name}-${package}.framework
		framework=${name}-${package}
		rm -rf ../../../Frameworks/$framework.framework
		mkdir ../../../Frameworks/$framework.framework
		cp $libraryFile ../../../Frameworks/$framework.framework/$framework
		cp ../../../plists/basic_Info.plist ../../../Frameworks/$framework.framework/Info.plist
		plutil -replace CFBundleExecutable -string $framework ../../../Frameworks/$framework.framework/Info.plist
		plutil -replace CFBundleName -string $framework ../../../Frameworks/$framework.framework/Info.plist
		# underscore is not allowed in CFBundleIdentifier:
		signature=${framework//_/-}
		plutil -replace CFBundleIdentifier -string Nicolas-Holzschuch.$signature  ../../../Frameworks/$framework.framework/Info.plist
		install_name_tool -change @rpath/python3_ios.framework/python3_ios @rpath/${name}.framework/${name}  ../../../Frameworks/$framework.framework/$framework
		install_name_tool -id @rpath/$framework.framework/$framework   ../../../Frameworks/$framework.framework/$framework
	done
done

