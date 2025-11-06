// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BeforeAfterCompare",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "BeforeAfterCompare",
            targets: ["BeforeAfterCompare"])
    ],
    targets: [
        .executableTarget(
            name: "BeforeAfterCompare",
            dependencies: [])
    ]
)