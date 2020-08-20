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
            checksum: "4c2d2e95b230adf62ff516dafae92dea542334a79ee9db2483d6f6ef51555140"
        ),
        .binaryTarget(
            name: "pythonA",
            url: "https://github.com/holzschu/python3_ios/releases/download/v1.0/pythonA.xcframework.zip",
            checksum: "4c067470ae5d89f12563cf9430b0a21946faa27b43e757dd84b390ad3addb17b"
        ),
        .binaryTarget(
            name: "pythonB",
            url: "https://github.com/holzschu/python3_ios/releases/download/v1.0/pythonB.xcframework.zip",
            checksum: "807f1cd53257ba72951e53270a59997cdda6db7664c00aeaf788bedb270f9bcc"
        ),
        .binaryTarget(
            name: "pythonC",
            url: "https://github.com/holzschu/python3_ios/releases/download/v1.0/pythonC.xcframework.zip",
            checksum: "b7517fb086f1a13a185ad9d2f932866cc17904a6ae4eb76a139de9edef7e1800"
        ),
        .binaryTarget(
            name: "pythonD",
            url: "https://github.com/holzschu/python3_ios/releases/download/v1.0/pythonD.xcframework.zip",
            checksum: "84255b7312970c8f94d94c268137135f14bf1c91f9e240b1a1ecebb5cd2d8a4f"
        ),
        .binaryTarget(
            name: "pythonE",
            url: "https://github.com/holzschu/python3_ios/releases/download/v1.0/pythonE.xcframework.zip",
            checksum: "be8ab1c89998c8f5d88fb30f46c289a7d77dbc6227d16b4d189b98b89cd0648a"
        )
    ]
)
/*
- recompiled with Xcode 12b5, python3_ios copied 5 times.
- Removed Module
python3_ios
4c2d2e95b230adf62ff516dafae92dea542334a79ee9db2483d6f6ef51555140
pythonA
4c067470ae5d89f12563cf9430b0a21946faa27b43e757dd84b390ad3addb17b
pythonB
807f1cd53257ba72951e53270a59997cdda6db7664c00aeaf788bedb270f9bcc
pythonC
b7517fb086f1a13a185ad9d2f932866cc17904a6ae4eb76a139de9edef7e1800
pythonD
84255b7312970c8f94d94c268137135f14bf1c91f9e240b1a1ecebb5cd2d8a4f
pythonE
be8ab1c89998c8f5d88fb30f46c289a7d77dbc6227d16b4d189b98b89cd0648a
*/
