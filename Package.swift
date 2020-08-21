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
            url: "https://github.com/holzschu/python3_ios/releases/download/v1.0/python3_ios.xcframework.zip",
            checksum: "e221caf400a7a09d0f29a41eb0ab6a9a4f643262c5e4f6899791be3e4a029063"
        ),
        .binaryTarget(
            name: "pythonA",
            url: "https://github.com/holzschu/python3_ios/releases/download/v1.0/pythonA.xcframework.zip",
            checksum: "a96ea86e0a037bba4c260501a690145ed1b18bc2fe958ca49034d74ae748fd1b"
        ),
        .binaryTarget(
            name: "pythonB",
            url: "https://github.com/holzschu/python3_ios/releases/download/v1.0/pythonB.xcframework.zip",
            checksum: "a52de89c653012a52fed418842491f65b7df1e57b83a18bb2c05e3ba62a7f212"
        ),
        .binaryTarget(
            name: "pythonC",
            url: "https://github.com/holzschu/python3_ios/releases/download/v1.0/pythonC.xcframework.zip",
            checksum: "8423a5991484d7e95095c7355643e351f1ceed158a7333105a56ac7f7d61b58b"
        ),
        .binaryTarget(
            name: "pythonD",
            url: "https://github.com/holzschu/python3_ios/releases/download/v1.0/pythonD.xcframework.zip",
            checksum: "e1fc10a169f8b77672a52275d2faf0b8bb7896e486e9bc0d06d023666bb55db7"
        ),
        .binaryTarget(
            name: "pythonE",
            url: "https://github.com/holzschu/python3_ios/releases/download/v1.0/pythonE.xcframework.zip",
            checksum: "0f281485789cfeefd545c3672ef933e3f5e7a38cb92c8440dd5366dbe4c8bb4d"
        )
    ]
)
/*
python3_ios
e221caf400a7a09d0f29a41eb0ab6a9a4f643262c5e4f6899791be3e4a029063
pythonA
a96ea86e0a037bba4c260501a690145ed1b18bc2fe958ca49034d74ae748fd1b
pythonB
a52de89c653012a52fed418842491f65b7df1e57b83a18bb2c05e3ba62a7f212
pythonC
8423a5991484d7e95095c7355643e351f1ceed158a7333105a56ac7f7d61b58b
pythonD
e1fc10a169f8b77672a52275d2faf0b8bb7896e486e9bc0d06d023666bb55db7
pythonE
0f281485789cfeefd545c3672ef933e3f5e7a38cb92c8440dd5366dbe4c8bb4d
*/
