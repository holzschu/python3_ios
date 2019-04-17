#!/bin/sh

env CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Frameworks" CXXFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Frameworks" LDSHARED="clang -v -undefined error -dynamiclib -arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -L../.. -lz -F ../../Python3_ios/build/Release-iphoneos/ -framework python3_ios -framework freetype -framework ios_system" python3 setup.py build

env CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Frameworks" CXXFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Frameworks" LDSHARED="clang -v -undefined error -dynamiclib -arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/  -L../.. -lz -F ../../Python3_ios/build/Release-iphoneos/ -framework python3_ios -framework freetype -framework ios_system"  PYTHONPATH="../../onIpad/lib/python3.7/site-packages/" python3 setup.py install --prefix ../../onIpad/

# Dynamic libraries created (excluding tests):
# ../../onIpad/lib/python3.7/site-packages/matplotlib-3.0.3-py3.7-macosx-10.9-x86_64.egg/matplotlib/ttconv.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/matplotlib-3.0.3-py3.7-macosx-10.9-x86_64.egg/matplotlib/backends/_backend_agg.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/matplotlib-3.0.3-py3.7-macosx-10.9-x86_64.egg/matplotlib/_png.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/matplotlib-3.0.3-py3.7-macosx-10.9-x86_64.egg/matplotlib/_image.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/matplotlib-3.0.3-py3.7-macosx-10.9-x86_64.egg/matplotlib/_contour.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/matplotlib-3.0.3-py3.7-macosx-10.9-x86_64.egg/matplotlib/_qhull.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/matplotlib-3.0.3-py3.7-macosx-10.9-x86_64.egg/matplotlib/_tri.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/matplotlib-3.0.3-py3.7-macosx-10.9-x86_64.egg/matplotlib/ft2font.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/matplotlib-3.0.3-py3.7-macosx-10.9-x86_64.egg/matplotlib/_path.cpython-37m-darwin.so


echo "Creating all frameworks:"
directory=../../onIpad/lib/python3.7/site-packages/matplotlib-3.0.3-py3.7-macosx-10.9-x86_64.egg/matplotlib
for library in ttconv backends/_backend_agg _png _image _contour _qhull _tri ft2font _path
do
	libraryFile=$directory/${library}.cpython-37m-darwin.so
	level1=`/usr/bin/dirname $library`
	level2=`/usr/bin/basename $library`
	# Test with "." first, if it fails use "-" (not "_')
	if [ $level1 = "." ] 
	then
	    package=matplotlib.$level2
	else 
	    package=matplotlib.$level1.$level2
	fi
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

