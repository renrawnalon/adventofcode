// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "2020day4",
  products: [
    .executable(name: "go", targets: ["2020day4"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1")
  ],
  targets: [
    .target(
      name: "2020day4",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ]),
    .testTarget(
      name: "2020day4Tests",
      dependencies: ["2020day4"]),
  ]
)
