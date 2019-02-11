# Building for iOS:
echo "Download OpenBLAS and install"
rm -rf OpenBLAS-0.2.20/
curl -OL http://github.com/xianyi/OpenBLAS/archive/v0.2.20.tar.gz 
tar -xzf v0.2.20.tar.gz
(cd OpenBLAS-0.2.20/ ; make HOSTCC="clang -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/" CC="clang -arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ " TARGET=ARMV8 AR="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ar" NOFORTRAN="1" NO_SHARED="1" ; make HOSTCC="clang -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/" CC="clang -arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ " TARGET=ARMV8 AR="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ar" NOFORTRAN="1" NO_SHARED="1" install PREFIX=./install ; cd ..)

echo "Creating framework:"
# Create openblas framework:
rm -rf Frameworks/openblas.framework
mkdir Frameworks/openblas.framework
mkdir Frameworks/openblas.framework/Headers
cp OpenBLAS-0.2.20/install/include/*.h Frameworks/openblas.framework/Headers
libtool -no_warning_for_no_symbols -dynamic -undefined dynamic_lookup -ios_version_min 11.0 -install_name @rpath/openblas.framework/openblas -o Frameworks/openblas.framework/openblas OpenBLAS-0.2.20/libopenblas_armv8p-r0.2.20.a 
cp plists/openblas_Info.plist Frameworks/openblas.framework/Info.plist

# echo "Cleanup:"
#
# To build OpenBLAS for OSX:
#  make hostcc="clang -isysroot /applications/xcode.app/contents/developer/platforms/macosx.platform/developer/sdks/macosx.sdk/" cc="clang -isysroot /applications/xcode.app/contents/developer/platforms/macosx.platform/developer/sdks/macosx.sdk/" 
# then install:
#  make hostcc="clang -isysroot /applications/xcode.app/contents/developer/platforms/macosx.platform/developer/sdks/macosx.sdk/" cc="clang -isysroot /applications/xcode.app/contents/developer/platforms/macosx.platform/developer/sdks/macosx.sdk/" install prefix=/usr/local/


