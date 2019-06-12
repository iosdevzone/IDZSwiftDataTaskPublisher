# IDZSwiftDataTaskPublisher
A (probably very naïve) attempt at implementing the `dataTaskPublisher(for: URLRequest)` extension on `URLSession` mentioned in WWDC 2019, Session 712.

There's not much to using it:

```swift
import Foundation
import IDZSwiftDataTaskPublisher

let request = URLRequest(url: URL(string: "http://example.com")!)
_ = URLSession.shared.dataTaskPublisher(for: request)
    .sink { print(String(data: $0.data, encoding: .utf8)!) }

dispatchMain()
```

Downloads and prints the HTML for http://example.com.

