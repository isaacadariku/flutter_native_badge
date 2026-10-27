// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "flutter_native_badge_foundation",
    platforms: [
        .macOS("10.15")
    ],
    products: [
        .library(name: "flutter-native-badge-foundation", targets: ["flutter_native_badge_foundation"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "flutter_native_badge_foundation",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ]
        )
    ]
)
