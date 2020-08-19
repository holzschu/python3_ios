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
            checksum: "ec3190430fae143cba81ef334c51166ccb99ec3435d8a9797cc7468511d4e75f"
        ),
        .binaryTarget(
            name: "pythonA",
            url: "https://github.com/holzschu/python3_ios/releases/download/v1.0/pythonA.xcframework.zip",
            checksum: "934f22cf50572a257670e4d90275a5f70355d334ea78fccd84357b6f78ac4422"
        ),
        .binaryTarget(
            name: "pythonB",
            url: "https://github.com/holzschu/python3_ios/releases/download/v1.0/pythonB.xcframework.zip",
            checksum: "22bd76235151c1ae1f64041859888377d0a154b90c35a7a43d31661222ab6b7e"
        ),
        .binaryTarget(
            name: "pythonC",
            url: "https://github.com/holzschu/python3_ios/releases/download/v1.0/pythonC.xcframework.zip",
            checksum: "843b6281b303d6a33740cd18bc90332d24c38496377b11595c3932b7ac841a20"
        ),
        .binaryTarget(
            name: "pythonD",
            url: "https://github.com/holzschu/python3_ios/releases/download/v1.0/pythonD.xcframework.zip",
            checksum: "2c4a606c890017e9333c487b6e0b1766fd2d4b84dc5af6580549cf47c3528391"
        ),
        .binaryTarget(
            name: "pythonE",
            url: "https://github.com/holzschu/python3_ios/releases/download/v1.0/pythonE.xcframework.zip",
            checksum: "0c5fdb2b25e06dfa1d0200db449b6239ef0dd86b96ea3193a9fbbeed12e7b800"
        )
    ]
)
/*
- recompiled with Xcode 12b5, python3_ios copied 5 times.
- module.modulemap not right?
python3_ios
ec3190430fae143cba81ef334c51166ccb99ec3435d8a9797cc7468511d4e75f
pythonA
934f22cf50572a257670e4d90275a5f70355d334ea78fccd84357b6f78ac4422
pythonB
22bd76235151c1ae1f64041859888377d0a154b90c35a7a43d31661222ab6b7e
pythonC
843b6281b303d6a33740cd18bc90332d24c38496377b11595c3932b7ac841a20
pythonD
2c4a606c890017e9333c487b6e0b1766fd2d4b84dc5af6580549cf47c3528391
pythonE
0c5fdb2b25e06dfa1d0200db449b6239ef0dd86b96ea3193a9fbbeed12e7b800
*/
