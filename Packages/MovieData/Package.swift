// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovieData",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "MovieData", targets: ["MovieData"]),
    ],
    dependencies: [
        .package(path: "../MovieDomain"),
    ],
    targets: [
        .target(
            name: "MovieData",
            dependencies: ["MovieDomain"]
        ),
        .testTarget(name: "MovieDataTests", dependencies: ["MovieData"]),
    ]
)
