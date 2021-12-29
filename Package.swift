// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "TealiumContentsquare",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "TealiumContentsquare", targets: ["TealiumContentsquare"])
    ],
    dependencies: [
        .package(url: "https://github.com/tealium/tealium-swift", from: "2.5.0"),
        .package(url: "https://github.com/ContentSquare/CS_iOS_SDK", from: "4.10.0")
    ],
    targets: [
        .target(
            name: "TealiumContentsquare",
            dependencies: [
                 .product(name: "TealiumCore", package: "tealium-swift"),
                 .product(name: "TealiumRemoteCommands", package: "tealium-swift"),
                 .product(name: "ContentsquareModule", package: "CS_iOS_SDK")
            ],
            path: "./Sources",
            exclude: ["Support"]),
        .testTarget(
            name: "TealiumContentsquareTests",
            dependencies: ["TealiumContentsquare"],
            path: "./Tests",
            exclude: ["Support"])
    ]
)