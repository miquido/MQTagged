// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "MQTagged",
	platforms: [
		.iOS(.v14),
		.macOS(.v11),
		.macCatalyst(.v14),
		.tvOS(.v14),
		.watchOS(.v7),
	],
	products: [
		.library(
			name: "MQTagged",
			targets: ["MQTagged"]
		)
	],
	dependencies: [],
	targets: [
		.target(
			name: "MQTagged",
			dependencies: []
		)
	]
)
