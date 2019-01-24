# Building for iOS:
echo "Download libpng and install"
rm -rf libpng-1.6.36/
curl -OL http://prdownloads.sourceforge.net/libpng/libpng-1.6.36.tar.gz
tar -xzf libpng-1.6.36.tar.gz
(cd libpng-1.6.36/ ; ./configure CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -fembed-bitcode" CPPFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" CXXFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -fembed-bitcode"  --build=x86_64-apple-darwin --host=armv7-apple-darwin ; make -j4 --quiet ; cp .libs/libpng16.a .. ; cd ..)

echo "Downloading freetype and building freetype without harfbuzz:"

rm -rf freetype-2.9
curl -OL https://download.savannah.gnu.org/releases/freetype/freetype-2.9.tar.gz
tar -xzf freetype-2.9.tar.gz
(cd freetype-2.9 ; env CCexe_CFLAGS="-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/" ./configure CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -fembed-bitcode" CPPFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" CXXFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -fembed-bitcode" LDFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -fembed-bitcode" --build=x86_64-apple-darwin --host=armv7-apple-darwin --with-harfbuzz=no --with-png=yes LIBPNG_CFLAGS="-I../libpng-1.6.36/" LIBPNG_LIBS="-L.. -lpng16" ; make -j4 --quiet ; cd .. )
mkdir freetype-2.9/lib/
cp freetype-2.9/objs/.libs/lib* freetype-2.9/lib/

echo "Downloading and building harfbuzz with freetype support:" 
rm -rf harfbuzz-2.3.0/
curl -OL https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-2.3.0.tar.bz2
tar -xzf harfbuzz-2.3.0.tar.bz2
(cd harfbuzz-2.3.0 ; patch  < ../harfbuzz.patch ; ./configure CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -fembed-bitcode" CPPFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" CXXFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -fembed-bitcode" LDFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -L$PWD/../freetype-2.9/lib/  -fembed-bitcode " --build=x86_64-apple-darwin --host=armv7-apple-darwin --enable-static=yes --with-glib=no --with-cairo=no --with-freetype=yes FREETYPE_CFLAGS="-I$PWD/../freetype-2.9/include/" FREETYPE_LIBS="-lfreetype" ; make -j4 --quiet ; cd ..)

echo "Re-building freetype with harfbuzz support:"
(cd freetype-2.9 ; env CCexe_CFLAGS="-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/" ./configure CC=clang CXX=clang++ CFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -fembed-bitcode" CPPFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/" CXXFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -fembed-bitcode" LDFLAGS="-arch arm64 -miphoneos-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ -fembed-bitcode " --build=x86_64-apple-darwin --host=armv7-apple-darwin --with-harfbuzz=yes --with-png=yes LIBPNG_CFLAGS="-I$PWD/../libpng-1.6.36/" LIBPNG_LIBS="-L$PWD/.. -lpng16" HARFBUZZ_CFLAGS="-I$PWD/../harfbuzz-2.3.0/src/" HARFBUZZ_LIBS="-L$PWD/../harfbuzz-2.3.0/src/.libs -lharfbuzz" ; make -j4 --quiet ; cd ..)

echo "Creating frameworks:"
# Create harfbuzz framework:
rm -rf Frameworks/harfbuzz.framework
mkdir Frameworks/harfbuzz.framework
mkdir Frameworks/harfbuzz.framework/Headers
cp harfbuzz-2.3.0/src/*.h Frameworks/harfbuzz.framework/Headers
libtool -no_warning_for_no_symbols -dynamic -undefined dynamic_lookup -ios_version_min 11.0 -install_name @rpath/harfbuzz.framework/harfbuzz -o Frameworks/harfbuzz.framework/harfbuzz harfbuzz-2.3.0/src/.libs/libharfbuzz.a 
cp plists/harfbuzz_Info.plist Frameworks/harfbuzz.framework/Info.plist


# create freetype framework:
rm -rf Frameworks/freetype.framework
mkdir Frameworks/freetype.framework
mkdir Frameworks/freetype.framework/Headers
cp -R freetype-2.9/include/* Frameworks/freetype.framework/Headers
libtool -no_warning_for_no_symbols -dynamic -undefined dynamic_lookup -ios_version_min 11.0 -install_name @rpath/freetype.framework/freetype -o Frameworks/freetype.framework/freetype freetype-2.9/objs/.libs/libfreetype.a 
cp plists/freetype_Info.plist Frameworks/freetype.framework/Info.plist

# echo "Cleanup:"
# (cd  libpng-1.6.36/ ;  make distclean ; cd ..)
# (cd harfbuzz-2.3.0 ; make distclean ; cd ..)
# (cd freetype-2.9 ; make distclean ; cd ..)
