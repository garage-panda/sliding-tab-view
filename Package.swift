import PackageDescription

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
            path: "Sources"),,
    ]
)