// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CPFHub",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v8),
        .tvOS(.v15)
    ],
    products: [
        .library(name: "CPFHub", targets: ["CPFHub"])
    ],
    targets: [
        .target(
            name: "CPFHub",
            path: "Sources/CPFHub"
        ),
        .testTarget(
            name: "CPFHubTests",
            dependencies: ["CPFHub"],
            path: "Tests/CPFHubTests"
        )
    ]
)
