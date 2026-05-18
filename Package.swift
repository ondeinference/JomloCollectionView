// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JomloCollectionView",
    platforms: [
        .iOS(.v17),
        .tvOS(.v17),
    ],
    products: [
        .library(
            name: "JomloCollectionView",
            targets: ["JomloCollectionView"]
        )
    ],
    targets: [
        .target(
            name: "JomloCollectionView",
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
        ),
        .testTarget(
            name: "JomloCollectionViewTests",
            dependencies: ["JomloCollectionView"],
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
        ),
    ]
)
