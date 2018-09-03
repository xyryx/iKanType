// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Dependencies",
    products: [
        .library(name: "Dependencies", type: .dynamic, targets: ["Dependencies"]),
    ],
    dependencies: [
        .package(url: "https://github.com/xyryx/nlp.git", from: "0.1.0"),
        .package(url: "https://github.com/Hearst-DD/ObjectMapper.git", from: "3.2.0"),
    ],
    targets: [
        .target(name: "Dependencies", dependencies: ["nlp", "ObjectMapper"], path: "." )
    ]
)
