SHELL = sh
.ONESHELL:
.SHELLFLAGS = -e

clean:
	swift package reset

build:
	swift build

lint:
	swift run --configuration release --package-path ./FormatTool --build-path ./.toolsCache -- swift-format lint --configuration ./FormatTool/formatterConfig.json --parallel --recursive ./Package.swift ./Sources

format:
	swift run --configuration release --package-path ./FormatTool --build-path ./.toolsCache -- swift-format format --configuration ./FormatTool/formatterConfig.json --parallel --recursive ./Package.swift ./Sources --in-place
