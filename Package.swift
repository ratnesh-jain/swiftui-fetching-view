// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FetchingView",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "FetchingView",
            targets: ["FetchingView"]
        ),
    ],
    targets: [
        .target(
            name: "FetchingView"
        )
    ]
)
