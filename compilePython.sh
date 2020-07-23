#!/bin/bash

xcodebuild -project Python3_ios/Python3_ios.xcodeproj -alltargets -sdk iphoneos -arch arm64 -configuration Release -quiet
xcodebuild -project Python3_ios/Python3_ios.xcodeproj -alltargets -arch x86_64 -sdk iphonesimulator -configuration Release -quiet

# xcframeworks creation 

for framework in python3_ios pythonA pythonB pythonC pythonD pythonE
do
   rm -rf $framework.xcframework
   xcodebuild -create-xcframework -framework Python3_ios/build//Release-iphoneos/$framework.framework -framework Python3_ios/build//Release-iphonesimulator/$framework.framework -output $framework.xcframework
done

for framework in python3_ios pythonA pythonB pythonC pythonD pythonE
do
   echo $framework
   rm -f $framework.xcframework.zip
   zip -rq $framework.xcframework.zip $framework.xcframework
   swift package compute-checksum $framework.xcframework.zip
done

