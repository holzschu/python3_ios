#!/bin/sh

# with -DCYTHON_PEP489_MULTI_PHASE_INIT=0 : fail
# with -DCYTHON_USE_DICT_VERSIONS=0: works
# numpy.mtrand required both.
# known to work, but no cleanup: -DNPY_NO_DEPRECATED_API -DCYTHON_USE_DICT_VERSIONS=0
# Edited Python module cleanup to force decreasing ref count on pandas and numpy. 
# Just -DCYTHON_PEP489_MULTI_PHASE_INIT=0: fails (TSOffsets) (but cleanup OK)


env CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Frameworks -DNPY_NO_DEPRECATED_API -DCYTHON_USE_DICT_VERSIONS=0" CXXFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Frameworks -DNPY_NO_DEPRECATED_API -DCYTHON_USE_DICT_VERSIONS=0" LDSHARED="clang -v -undefined error -dynamiclib -arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -L../.. -lz -F ../../Python3_ios/build/Release-iphoneos/ -framework python3_ios -framework ios_system" python3 setup.py build

env CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Frameworks  -DNPY_NO_DEPRECATED_API -DCYTHON_USE_DICT_VERSIONS=0" CXXFLAGS="-arch arm64 -miphoneos-version-min=11.0 -I../../Python-3.7.1/Include/ -I../../Python-3.7.1/ -I../.. -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F ../../Frameworks -DNPY_NO_DEPRECATED_API -DCYTHON_USE_DICT_VERSIONS=0" LDSHARED="clang -v -undefined error -dynamiclib -arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/  -L../.. -lz -F ../../Python3_ios/build/Release-iphoneos/ -framework python3_ios -framework ios_system"  PYTHONPATH="../../onIpad/lib/python3.7/site-packages/" python3 setup.py install --prefix ../../onIpad/

# Dynamic libraries created (excluding tests):
# 41 libraries!!!
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/util/_move.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/io/msgpack/_packer.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/io/msgpack/_unpacker.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/io/sas/_sas.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/writers.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/properties.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/interval.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/reduction.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/lib.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/join.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/testing.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/reshape.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/internals.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/hashing.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/missing.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/groupby.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/parsers.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/ops.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/indexing.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/sparse.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/window.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/tslibs/ccalendar.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/tslibs/conversion.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/tslibs/fields.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/tslibs/nattype.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/tslibs/timedeltas.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/tslibs/frequencies.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/tslibs/resolution.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/tslibs/offsets.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/tslibs/np_datetime.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/tslibs/period.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/tslibs/timezones.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/tslibs/strptime.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/tslibs/parsing.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/tslibs/timestamps.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/tslib.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/index.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/algos.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/skiplist.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/hashtable.cpython-37m-darwin.so
# ../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas/_libs/json.cpython-37m-darwin.so

echo "Creating all frameworks:"
directory=../../onIpad/lib/python3.7/site-packages/pandas-0.24.2-py3.7-macosx-10.9-x86_64.egg/pandas
for library in util/_move io/msgpack/_packer io/msgpack/_unpacker io/sas/_sas _libs/writers _libs/properties _libs/interval _libs/reduction _libs/lib _libs/join _libs/testing _libs/reshape _libs/internals _libs/hashing _libs/missing _libs/groupby _libs/parsers _libs/ops _libs/indexing _libs/sparse _libs/window _libs/tslibs/ccalendar _libs/tslibs/conversion _libs/tslibs/fields _libs/tslibs/nattype _libs/tslibs/timedeltas _libs/tslibs/frequencies _libs/tslibs/resolution _libs/tslibs/offsets _libs/tslibs/np_datetime _libs/tslibs/period _libs/tslibs/timezones _libs/tslibs/strptime _libs/tslibs/parsing _libs/tslibs/timestamps _libs/tslib _libs/index _libs/algos _libs/skiplist _libs/hashtable _libs/json
do
	libraryFile=$directory/${library}.cpython-37m-darwin.so
	converted=${library//\//.}
	package=pandas.$converted
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

