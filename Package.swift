// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-scale-codec",
    platforms: [.macOS(.v10_12), .iOS(.v10), .tvOS(.v10), .watchOS(.v6)],
    products: [
        .library(
            name: "ScaleCodec",
            targets: ["ScaleCodec"]),
    ],
    dependencies: [
        .package(url: "https://github.com/tesseract-one/Tuples.swift.git", .branch("main"))
    ],
    targets: [
        .target(
            name: "ScaleCodec",
            dependencies: [
                .product(name: "Tuples", package: "Tuples.swift"),
                "DoubleWidth"
            ]),
        .target(
            name: "DoubleWidth",
            dependencies: []),
        .testTarget(
            name: "ScaleCodecTests",
            dependencies: ["ScaleCodec"]),
        .testTarget(
            name: "DoubleWidthTests",
            dependencies: ["ScaleCodec"]
        )
    ]
)


