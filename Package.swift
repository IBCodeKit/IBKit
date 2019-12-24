// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IBKit",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "IBKit",
            targets: ["IBKit"]),
    ],
    targets: [
        .target(
            name: "IBKit"),
        .testTarget(
            name: "IBKitTests",
            dependencies: ["IBKit"]),
    ]
)
