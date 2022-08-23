
// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.import PackageDescription

let package = Package(
    name: "SlidingTabView",
    products: [
        .library(
            name: "SlidingTabView",
            targets: ["SlidingTabView"]),
    ],
    dependencies: [

    ],
    targets: [
        .target(
            name: "SlidingTabView",
            dependencies: [],
            path: "Sources"),
    ]
)
