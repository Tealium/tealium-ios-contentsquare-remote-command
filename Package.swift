// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "TealiumContentsquare",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "TealiumContentsquare", targets: ["TealiumContentsquare"])
    ],
    dependencies: [
        .package(url: "https://github.com/tealium/tealium-swift", .upToNextMajor(from: "2.9.0")),
        .package(url: "https://github.com/ContentSquare/CS_iOS_SDK", .upToNextMajor(from: "4.19.0"))
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
            exclude: ["Support"])
    ]
)
