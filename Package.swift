// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "TuringMachine",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "TuringMachine",
            targets: ["TuringMachine"]
        ),
    ],
    dependencies: [
        // Swift collections is added for use of the `Deque<T>` structure to model the tape, infinitely expandable in both directions.
        .package(url: "https://github.com/apple/swift-collections.git", from: "1.0.0"),
        .package(url: "https://github.com/JohnSundell/Files", from: "4.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "cli",
            dependencies: [
                "Files",
                "TuringMachine"
            ]
        ),
        .target(
            name: "TuringMachine",
            dependencies: [
                .product(name: "Collections", package: "swift-collections"),
            ]
        ),
        .testTarget(
            name: "TuringMachineTests",
            dependencies: ["TuringMachine"],
            resources: [
                .process("JSON"),
                .process("TUR")
            ]
        ),
    ]
)
