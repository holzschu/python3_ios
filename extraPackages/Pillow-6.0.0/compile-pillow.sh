#!/bin/sh

env CC=clang CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Frameworks " LDSHARED="clang -v -undefined error -dynamiclib -arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -L /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/lib/  -lz -L . -F ../../Python3_ios/build/Release-iphoneos/ -framework python3_ios -framework ios_system -F ../../Frameworks -framework freetype " python3 setup.py build

env CC=clang CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Frameworks " LDSHARED="clang -v -undefined error -dynamiclib -arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -L/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/lib  -lz -L . -F ../../Python3_ios/build/Release-iphoneos/ -framework python3_ios -framework ios_system -F ../../Frameworks -framework freetype " PYTHONPATH="../../onIpad/lib/python3.7/site-packages/"  python3 setup.py install --prefix ../../onIpad/

# Dynamic libraries created (excluding tests):
# ../../onIpad/lib/python3.7/site-packages/Pillow-6.0.0-py3.7-macosx-10.9-x86_64.egg/PIL/_imagingft.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/Pillow-6.0.0-py3.7-macosx-10.9-x86_64.egg/PIL/_imaging.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/Pillow-6.0.0-py3.7-macosx-10.9-x86_64.egg/PIL/_imagingmath.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/Pillow-6.0.0-py3.7-macosx-10.9-x86_64.egg/PIL/_imagingtk.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/Pillow-6.0.0-py3.7-macosx-10.9-x86_64.egg/PIL/_imagingmorph.cpython-37m-darwin.so

# echo "Creating all frameworks:"
directory=../../onIpad/lib/python3.7/site-packages/Pillow-6.0.0-py3.7-macosx-10.9-x86_64.egg/PIL/
for library in _imagingft _imaging _imagingmath _imagingtk _imagingmorph
do
	libraryFile=$directory/${library}.cpython-37m-darwin.so
	converted=${library//\//.}
	package=PIL.$converted
	for name in python3_ios pythonA pythonB pythonC pythonD pythonE
	do
		echo "Creating: " Frameworks/${name}-${package}.framework
		framework=${name}-${package}
		rm -rf ../../Frameworks/$framework.framework
		mkdir ../../Frameworks/$framework.framework
		cp $libraryFile ../../Frameworks/$framework.framework/$framework
		cp ../../plists/basic_Info.plist ../../Frameworks/$framework.framework/Info.plist
		plutil -replace CFBundleExecutable -string $framework ../../Frameworks/$framework.framework/Info.plist
		plutil -replace CFBundleName -string $framework ../../Frameworks/$framework.framework/Info.plist
		# underscore is not allowed in CFBundleIdentifier:
		signature=${framework//_/-}
		plutil -replace CFBundleIdentifier -string Nicolas-Holzschuch.$signature  ../../Frameworks/$framework.framework/Info.plist
		install_name_tool -change @rpath/python3_ios.framework/python3_ios @rpath/${name}.framework/${name}  ../../Frameworks/$framework.framework/$framework
		install_name_tool -id @rpath/$framework.framework/$framework   ../../Frameworks/$framework.framework/$framework
	done
done

