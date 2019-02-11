#!/bin/bash

# move libraries out of the way:
mkdir -p libraries_iPhoneOS
cp *.a libraries_iPhoneOS
cp libraries_iPhoneSimulator/* .

# Swap frameworks:
mv Frameworks Frameworks_iPhoneOS
mv Frameworks_Simulator Frameworks

xcodebuild -project Python3_ios/Python3_ios.xcodeproj -alltargets -sdk iphonesimulator -configuration Debug -quiet
# swap back: 
mv Frameworks Frameworks_Simulator 
mv Frameworks_iPhoneOS Frameworks 
cp libraries_iPhoneOS/* .
