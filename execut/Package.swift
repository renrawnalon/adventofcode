// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "execut",
  dependencies: [
    .package(url: "https://github.com/apple/swift-package-manager.git", from: "0.1.0"),
  ],
  targets: [
    .target(name: "execut", dependencies: ["Utility"]),
  ]
)
