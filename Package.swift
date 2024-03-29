// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RenetikCore",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RenetikCore",
            targets: ["RenetikCore"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, branch: "master"),
    ],
    targets: [
        .target(
            name: "RenetikCore",
            dependencies: []
        ),
        .testTarget(
            name: "RenetikCoreTests",
            dependencies: ["RenetikCore"]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
