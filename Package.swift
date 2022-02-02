// swift-tools-version:5.5
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
        .package(url: "https://github.com/tealium/tealium-swift", .upToNextMajor(from: "2.6.0")),
        .package(url: "https://github.com/ContentSquare/CS_iOS_SDK", .upToNextMajor(from: "4.10.0"))
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
