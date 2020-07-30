// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name     : "RuneFactory",
    platforms: [.macOS(.v10_14)],
    products : [
        .library(
            name   :  "RuneFactory",
            targets: ["RuneFactory"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SteveTrewick/SourceKitHipster", from: "1.0.6"),
    ],
    targets: [
        .target(
            name        : "RuneFactory",
            dependencies: ["SourceKitHipster"]),
        .testTarget(
            name        : "RuneFactoryTests",
            dependencies: ["RuneFactory"]),
    ]
)
