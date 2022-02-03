// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "NonacoLogo",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
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
            dependencies: [],
            resources: [.process("bell.wav")]),
        .testTarget(
            name: "NonacoLogoTests",
            dependencies: ["NonacoLogo"]),
    ]
)
