# MQTagged

[![Platforms](https://img.shields.io/badge/platform-iOS%20|%20iPadOS%20|%20macOS-gray.svg?style=flat)]()
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![SwiftVersion](https://img.shields.io/badge/Swift-5.6-brightgreen.svg)]()

MQTagged provides a `Tagged` structure that helps differentiating between values of the same type.

## Summary

Let's have an example of a function that authorizes a user based on two string parameters:

```swift
func authorize(_ username: String, _ password: String) {
	...
}
```

It is possible to call the function with swapped arguments without any compiler warning. Using a `typealias` also does not solves the issue:

```swift
typealias Username = String
typealias Password = String

func authorize(_ username: Username, _ password: Password) {
	...
}

let username: Username = "user@name.com"
let password: Password = "pa55w0rD"

authorize(username, password)
authorize(password, username) // It's wrong but still compiles.
```

`typealias` doesn't cause compiler warning or error when type names are not matching since resolved type is the same. MQTagged solution to this problem is to use `Tag` type:

```swift
enum UsernameTag {}
enum PasswordTag {}

typealias Username = Tagged<String, UsernameTag>
typealias Password = Tagged<String, PasswordTag>

func authorize(_ username: Username, _ password: Password) {
	...
}
```

Now any call with swapped parameters won't compile.

```swift
let username: Username = "user@name.com"
let password: Password = "pa55w0rD"

authorize(username, password)
authorize(password, username) // This won't compile.
```

## Installation
`MQTagged` can be integrated throught Swift Package Manager. In your `Package.swift` file add the following `dependency`:

```swift
dependencies: [
  .package(
    url: "https://gitlab.com/miquido/dev/ios/mqtagged.git",
    .upToNextMajor("0.1.0")
  )
]
```

## License

Copyright 2022 Miquido

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
