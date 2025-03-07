// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataLayer",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DataLayer",
            targets: ["DataLayer"]),
    ],
    dependencies: [
        .package(name: "DomainLayer", path: "/../DomainLayer"),
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DataLayer",
            dependencies: [
                "DomainLayer",
                .product(name: "Moya", package: "Moya"),
                .product(name: "CombineMoya", package: "Moya"),
            ],
            resources: [.process("Secret.plist")]
        ),
    ]
)
