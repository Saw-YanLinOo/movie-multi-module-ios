// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovieDomain",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "MovieDomain", targets: ["MovieDomain"]),
    ],
    targets: [
        .target(name: "MovieDomain"),
        .testTarget(name: "MovieDomainTests", dependencies: ["MovieDomain"]),
    ]
)
