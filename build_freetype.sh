# Building for iOS:
echo "Download libpng and install"
rm -rf libpng-1.6.36/
curl -OL http://prdownloads.sourceforge.net/libpng/libpng-1.6.36.tar.gz
tar -xzf libpng-1.6.36.tar.gz
(cd libpng-1.6.36/ ; ./configure CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" CPPFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" CXXFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/"  --build=x86_64-apple-darwin --host=armv7-apple-darwin ; make -j 4 -s ; cp .libs/libpng16.a .. ; cd ..)

echo "Downloading freetype and building freetype without harfbuzz:"

rm -rf freetype-2.9
curl -OL https://download.savannah.gnu.org/releases/freetype/freetype-2.9.tar.gz
tar xvzf freetype-2.9.tar.gz
(cd freetype-2.9 ; env CCexe_CFLAGS="-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/" ./configure CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" CPPFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" CXXFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" LDFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" --build=x86_64-apple-darwin --host=armv7-apple-darwin --with-harfbuzz=no --with-png=yes LIBPNG_CFLAGS="-I../libpng-1.6.36/" LIBPNG_LIBS="-L.. -lpng16" ; make -j 4 -s ; cd .. )
# create freetype framework:
rm -rf Frameworks/freetype.framework
mkdir Frameworks/freetype.framework
mkdir Frameworks/freetype.framework/Headers
cp -R freetype-2.9/include/* Frameworks/freetype.framework/Headers
cp freetype-2.9/objs/.libs/libfreetype.dylib Frameworks/freetype.framework/freetype
cp plists/freetype_Info.plist Frameworks/freetype.framework/Info.plist

echo "Downloading and building harfbuzz with freetype support:" 
rm -rf harfbuzz-2.3.0/
curl -OL https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-2.3.0.tar.bz2
tar xvzf harfbuzz-2.3.0.tar.bz2
(cd harfbuzz-2.3.0 ; ./configure CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" CPPFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" CXXFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" LDFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -F$PWD/../Frameworks/" --build=x86_64-apple-darwin --host=armv7-apple-darwin --with-glib=no --with-cairo=no --with-freetype=yes FREETYPE_CFLAGS="-I$PWD/../Frameworks/freetype.framework/Headers/" FREETYPE_LIBS="-framework freetype" ; make -j 4 -s ; cd ..)

# Create harfbuzz framework:
rm -rf Frameworks/harfbuzz.framework
mkdir Frameworks/harfbuzz.framework
mkdir Frameworks/harfbuzz.framework/Headers
cp harfbuzz-2.3.0/src/*.h Frameworks/harfbuzz.framework/Headers
cp harfbuzz-2.3.0/src/.libs/libharfbuzz.dylib Frameworks/harfbuzz.framework/harfbuzz 
cp plists/harfbuzz_Info.plist Frameworks/harfbuzz.framework/Info.plist

echo "Re-building freetype with harfbuzz support:"
(cd freetype-2.9 ; make distclean ; env CCexe_CFLAGS="-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/" ./configure CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" CPPFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" CXXFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" LDFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" --build=x86_64-apple-darwin --host=armv7-apple-darwin --with-harfbuzz=yes --with-png=yes LIBPNG_CFLAGS="-I$PWD/../libpng-1.6.36/" LIBPNG_LIBS="-L$PWD/.. -lpng16" HARFBUZZ_CFLAGS="-I$PWD/../Frameworks/harfbuzz.framework/Headers/" HARFBUZZ_LIBS="-F$PWD/../Frameworks -framework harfbuzz" ; make -j 4 -s ; cd ..)
# create freetype framework:
rm -rf Frameworks/freetype.framework
mkdir Frameworks/freetype.framework
mkdir Frameworks/freetype.framework/Headers
cp -R freetype-2.9/include/* Frameworks/freetype.framework/Headers
cp freetype-2.9/objs/.libs/libfreetype.dylib Frameworks/freetype.framework/freetype
cp plists/freetype_Info.plist Frameworks/freetype.framework/Info.plist

echo "Cleanup:"
(cd  libpng-1.6.36/ ;  make distclean ; cd ..)
(cd harfbuzz-2.3.0 ; make distclean ; cd ..)
(cd freetype-2.9 ; make distclean ; cd ..)
