// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if os(Linux) || os(tvOS)
let doubleWidthTestTarget: Target = .testTarget(
    name: "DoubleWidthTests",
    dependencies: ["ScaleCodec", "CwlPosixPreconditionTesting"]
)
#else
let doubleWidthTestTarget: Target = .testTarget(
    name: "DoubleWidthTests",
    dependencies: ["ScaleCodec", "CwlPreconditionTesting"]
)
#endif

let package = Package(
    name: "swift-scale-codec",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "ScaleCodec",
            targets: ["ScaleCodec"]),
    ],
    dependencies: [
        .package(url: "https://github.com/mattgallagher/CwlPreconditionTesting.git", from: "2.1.0")
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "ScaleCodec",
            dependencies: ["DoubleWidth"]),
        .target(
            name: "DoubleWidth",
            dependencies: []),
        .testTarget(
            name: "ScaleCodecTests",
            dependencies: ["ScaleCodec"]),
        doubleWidthTestTarget
    ]
)


