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

