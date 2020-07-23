// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Python",
    products: [
        .library(name: "Python", targets: ["python3_ios", "pythonA", "pythonB", "pythonC", "pythonD", "pythonE"])
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "python3_ios",
            url: "https://github.com/holzschu/python3_ios/releases/download/1.0/python3_ios.xcframework.zip",
            checksum: "907119bb145e7986c5b6f75ed1d3f64f10ca4cf1cc127b2b82cc16b0c1a54b55"
        ),
        .binaryTarget(
            name: "pythonA",
            url: "https://github.com/holzschu/python3_ios/releases/download/1.0/pythonA.xcframework.zip",
            checksum: "1edd54ddbd7337f184b641637b6b23e808d52718eb431e51800eadbee1b22b5f"
        ),
        .binaryTarget(
            name: "pythonB",
            url: "https://github.com/holzschu/python3_ios/releases/download/1.0/pythonB.xcframework.zip",
            checksum: "c6061503629230ec267dfe37e229e66e878b7c163a8547e9e5508302a7c87f9e"
        ),
        .binaryTarget(
            name: "pythonC",
            url: "https://github.com/holzschu/python3_ios/releases/download/1.0/pythonC.xcframework.zip",
            checksum: "79b29b42d7286dd3914512570ef85801597bacd875b39d7e4c56e9a60d95dc79"
        ),
        .binaryTarget(
            name: "pythonD",
            url: "https://github.com/holzschu/python3_ios/releases/download/1.0/pythonD.xcframework.zip",
            checksum: "144c07b32f77cd5aeb612c859654fe4ff5d98e0c0d4a7bd061a1b146bb14300c"
        ),
        .binaryTarget(
            name: "pythonE",
            url: "https://github.com/holzschu/python3_ios/releases/download/1.0/pythonE.xcframework.zip",
            checksum: "184489150637cb1ab3f7415989c48603a55c56581d2ef4c0f8e30159a78c515e"
        )
    ]
)
/*
xcframework successfully written out to: /Users/holzschu/src/Xcode_iPad/python3_ios/python3_ios.xcframework
python3_ios
907119bb145e7986c5b6f75ed1d3f64f10ca4cf1cc127b2b82cc16b0c1a54b55
xcframework successfully written out to: /Users/holzschu/src/Xcode_iPad/python3_ios/pythonA.xcframework
pythonA
1edd54ddbd7337f184b641637b6b23e808d52718eb431e51800eadbee1b22b5f
xcframework successfully written out to: /Users/holzschu/src/Xcode_iPad/python3_ios/pythonB.xcframework
pythonB
c6061503629230ec267dfe37e229e66e878b7c163a8547e9e5508302a7c87f9e
xcframework successfully written out to: /Users/holzschu/src/Xcode_iPad/python3_ios/pythonC.xcframework
pythonC
79b29b42d7286dd3914512570ef85801597bacd875b39d7e4c56e9a60d95dc79
xcframework successfully written out to: /Users/holzschu/src/Xcode_iPad/python3_ios/pythonD.xcframework
pythonD
144c07b32f77cd5aeb612c859654fe4ff5d98e0c0d4a7bd061a1b146bb14300c
xcframework successfully written out to: /Users/holzschu/src/Xcode_iPad/python3_ios/pythonE.xcframework
pythonE
184489150637cb1ab3f7415989c48603a55c56581d2ef4c0f8e30159a78c515e
*/
