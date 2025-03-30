// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Storage",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Storage",
            targets: ["Storage"]
        ),
    ],
    dependencies: [
        .package(path: "Utility"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess", exact: "4.2.2")
    ],
    targets: [
        .target(
            name: "Storage",
            dependencies: [
                "Utility",
                .product(name: "KeychainAccess", package: "KeychainAccess")
            ]
        ),
    ],
    swiftLanguageModes: [.v5]
)
