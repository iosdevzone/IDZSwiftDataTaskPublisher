# IDZSwiftDataTaskPublisher
A (probably very naïve) attempt at implementing the `dataTaskPublisher(for: URLRequest)` extension on `URLSession` mentioned in WWDC 2019, Session 712. You can see a demo of it at https://developer.apple.com/videos/play/wwdc2019/712/ around 20:32.

There's not much to using it:

```swift
import Foundation
import IDZSwiftDataTaskPublisher

let request = URLRequest(url: URL(string: "http://example.com")!)
_ = URLSession.shared.dataTaskPublisher(for: request)
    .sink { print(String(data: $0.data, encoding: .utf8)!) }

dispatchMain()
```

This example downloads and prints the HTML for http://example.com.

# Using the Package

The package supports the Swift Package Manager. Just add
```swift
.package(url: "https://github.com/iosdevzone/IDZSwiftDataTaskPublisher", from: "0.1.0"),
```
to your `Package.swift`

# Building the Demo Program

There's a simple demo include in the repository. Change to `Demos/macOS/SimpleDemo` directory then use `swift build` to build it and `swift run` to run it. You should be treated to glorious HTML text on your terminal. 



