// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "NonacoLogo",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "NonacoLogo",
            targets: ["NonacoLogo"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "NonacoLogo",
            dependencies: []),
        .testTarget(
            name: "NonacoLogoTests",
            dependencies: ["NonacoLogo"]),
    ]
)
