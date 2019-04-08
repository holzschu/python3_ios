#!/bin/sh

env CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Frameworks" CXXFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Frameworks" LDSHARED="clang -v -undefined error -dynamiclib -arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Python3_ios/build/Release-iphoneos/ -framework python3_ios -framework openblas -framework ios_system" python3 setup.py build

env CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Frameworks" CXXFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Frameworks" LDSHARED="clang -v -undefined error -dynamiclib -arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Python3_ios/build/Release-iphoneos/ -framework python3_ios -framework openblas -framework ios_system"  PYTHONPATH="../../onIpad/lib/python3.7/site-packages/" python3 setup.py install --prefix ../../onIpad/

# Dynamic libraries created (excluding tests):
# ../../onIpad/lib/python3.7/site-packages/numpy-1.16.0-py3.7-macosx-10.9-x86_64.egg/numpy/core/_dummy.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/numpy-1.16.0-py3.7-macosx-10.9-x86_64.egg/numpy/core/_multiarray_umath.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/numpy-1.16.0-py3.7-macosx-10.9-x86_64.egg/numpy/linalg/lapack_lite.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/numpy-1.16.0-py3.7-macosx-10.9-x86_64.egg/numpy/linalg/_umath_linalg.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/numpy-1.16.0-py3.7-macosx-10.9-x86_64.egg/numpy/fft/fftpack_lite.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/numpy-1.16.0-py3.7-macosx-10.9-x86_64.egg/numpy/random/mtrand.cpython-37m-darwin.so

echo "Creating all frameworks:"
# Create kiwisolver framework:
directory=../../onIpad/lib/python3.7/site-packages/numpy-1.16.0-py3.7-macosx-10.9-x86_64.egg/numpy
for library in core/_dummy core/_multiarray_umath linalg/lapack_lite linalg/_umath_linalg fft/fftpack_lite random/mtrand
do
	libraryFile=$directory/${library}.cpython-37m-darwin.so
	level1=`/usr/bin/dirname $library`
	level2=`/usr/bin/basename $library`
	# Test with "." first, if it fails use "-" (not "_')
	package=numpy.$level1.$level2
	echo $framework
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
		if [ "$name" == python3_ios ]; then 
			signature=python3-ios-kiwisolver
		else
			signature=$framework
		fi
		plutil -replace CFBundleIdentifier -string Nicolas-Holzschuch.$signature  ../../Frameworks/$framework.framework/Info.plist
		install_name_tool -change @rpath/python3_ios.framework/python3_ios @rpath/${name}.framework/${name}  ../../Frameworks/$framework.framework/$framework
		install_name_tool -id @rpath/$framework.framework/$framework   ../../Frameworks/$framework.framework/$framework
	done
done

