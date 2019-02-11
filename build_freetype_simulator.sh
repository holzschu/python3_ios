# Building for iOS simulator:
echo "Download libpng and install"
rm -rf libpng-1.6.36/
curl -OL http://prdownloads.sourceforge.net/libpng/libpng-1.6.36.tar.gz
tar -xzf libpng-1.6.36.tar.gz
(cd libpng-1.6.36/ ; ./configure CC=clang CXX=clang++ CFLAGS="-mios-simulator-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/ -fembed-bitcode" CPPFLAGS="-mios-simulator-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/" CXXFLAGS="-mios-simulator-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/ -fembed-bitcode"  --host=x86_64-apple-darwin ; make -j4 --quiet ; cp .libs/libpng16.a ../libraries_iPhoneSimulator/ ; cd ..)

echo "Downloading freetype and building freetype without harfbuzz:"

rm -rf freetype-2.9
curl -OL https://download.savannah.gnu.org/releases/freetype/freetype-2.9.tar.gz
tar -xzf freetype-2.9.tar.gz
(cd freetype-2.9 ; env CCexe_CFLAGS="-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/" ./configure CC=clang CXX=clang++ CFLAGS="-mios-simulator-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/ -fembed-bitcode" CPPFLAGS="-mios-simulator-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/" CXXFLAGS="-mios-simulator-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/ -fembed-bitcode" LDFLAGS="-mios-simulator-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/ -fembed-bitcode" --host=x86_64-apple-darwin --with-harfbuzz=no --with-png=yes LIBPNG_CFLAGS="-I../libpng-1.6.36/" LIBPNG_LIBS="-L.. -lpng16" ; make -j4 --quiet ; cd .. )
mkdir freetype-2.9/lib/
cp freetype-2.9/objs/.libs/lib* freetype-2.9/lib/

echo "Downloading and building harfbuzz with freetype support:" 
rm -rf harfbuzz-2.3.0/
curl -OL https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-2.3.0.tar.bz2
tar -xzf harfbuzz-2.3.0.tar.bz2
(cd harfbuzz-2.3.0 ; patch  < ../harfbuzz.patch ; ./configure CC=clang CXX=clang++ CFLAGS="-mios-simulator-version-min=11.0 -isysroot  /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/ -fembed-bitcode" CPPFLAGS="-mios-simulator-version-min=11.0 -isysroot  /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/" CXXFLAGS="-mios-simulator-version-min=11.0 -isysroot  /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/ -fembed-bitcode" LDFLAGS="-mios-simulator-version-min=11.0 -isysroot  /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/ -L$PWD/../freetype-2.9/lib/  -fembed-bitcode " --host=x86_64-apple-darwin --enable-static=yes --with-glib=no --with-cairo=no --with-freetype=yes FREETYPE_CFLAGS="-I$PWD/../freetype-2.9/include/" FREETYPE_LIBS="-lfreetype" ; make -j4 --quiet ; cd ..)

echo "Re-building freetype with harfbuzz support:"
(cd freetype-2.9 ; env CCexe_CFLAGS="-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/" ./configure CC=clang CXX=clang++ CFLAGS="-mios-simulator-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/ -fembed-bitcode" CPPFLAGS="-mios-simulator-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/" CXXFLAGS="-mios-simulator-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/ -fembed-bitcode" LDFLAGS="-mios-simulator-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/ -fembed-bitcode " --host=x86_64-apple-darwin --with-harfbuzz=yes --with-png=yes LIBPNG_CFLAGS="-I$PWD/../libpng-1.6.36/" LIBPNG_LIBS="-L$PWD/.. -lpng16" HARFBUZZ_CFLAGS="-I$PWD/../harfbuzz-2.3.0/src/" HARFBUZZ_LIBS="-L$PWD/../harfbuzz-2.3.0/src/.libs -lharfbuzz" ; make -j4 --quiet ; cd ..)

echo "Creating frameworks:"
# Create harfbuzz framework:
rm -rf Frameworks_Simulator/harfbuzz.framework
mkdir -p Frameworks_Simulator/harfbuzz.framework
mkdir -p Frameworks_Simulator/harfbuzz.framework/Headers
cp harfbuzz-2.3.0/src/*.h Frameworks_Simulator/harfbuzz.framework/Headers
libtool -no_warning_for_no_symbols -dynamic -undefined dynamic_lookup -ios_simulator_version_min 11.0 -install_name @rpath/harfbuzz.framework/harfbuzz -o Frameworks_Simulator/harfbuzz.framework/harfbuzz harfbuzz-2.3.0/src/.libs/libharfbuzz.a 
cp plists/harfbuzz_Info.plist Frameworks_Simulator/harfbuzz.framework/Info.plist


# create freetype framework:
rm -rf Frameworks_Simulator/freetype.framework
mkdir -p Frameworks_Simulator/freetype.framework
mkdir -p Frameworks_Simulator/freetype.framework/Headers
cp -R freetype-2.9/include/* Frameworks_Simulator/freetype.framework/Headers
libtool -no_warning_for_no_symbols -dynamic -undefined dynamic_lookup -ios_simulator_version_min 11.0 -install_name @rpath/freetype.framework/freetype -o Frameworks_Simulator/freetype.framework/freetype freetype-2.9/objs/.libs/libfreetype.a 
cp plists/freetype_Info.plist Frameworks_Simulator/freetype.framework/Info.plist

# echo "Cleanup:"
# (cd  libpng-1.6.36/ ;  make distclean ; cd ..)
# (cd harfbuzz-2.3.0 ; make distclean ; cd ..)
# (cd freetype-2.9 ; make distclean ; cd ..)
