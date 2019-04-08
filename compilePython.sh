#!/bin/bash

xcodebuild -project Python3_ios/Python3_ios.xcodeproj -alltargets -sdk iphoneos -arch arm64 -configuration Release -quiet

