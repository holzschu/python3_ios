echo "Compiling libffi-3.2.1:"
mkdir -p libraries_iPhoneSimulator
(cd libffi-3.2.1 ;  xcodebuild -project libffi.xcodeproj -target libffi-iOS -sdk iphonesimulator -arch x86_64 -mios-simulator-version-min=11.0 -configuration Debug -quiet; mv build/Debug-iphonesimulator/libffi.a ../libraries_iPhoneSimulator ; cd ..)

echo "Compiling zeromq:"
# to configure for the simulator, you need a --host, but no --build!
(cd zeromq-4.2.5 ; make distclean ; ./configure CC=clang CXX=clang++ CFLAGS="-mios-simulator-version-min=11.0 -isysroot/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/ -fembed-bitcode" CXXFLAGS="-mios-simulator-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/ -fembed-bitcode" CPPFLAGS="-mios-simulator-version-min=11.0 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/" --enable-static --host=x86_64-apple-darwin ; make ; mv src/.libs/libzmq.a ../libraries_iPhoneSimulator ; cd ..)

