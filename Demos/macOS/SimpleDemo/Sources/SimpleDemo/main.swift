import Foundation
import IDZSwiftDataTaskPublisher


if #available(OSX 10.15, *) {
let request = URLRequest(url: URL(string: "http://example.com")!)
_ = URLSession.shared.dataTaskPublisher(for: request)
    .sink { print(String(data: $0.data, encoding: .utf8)!) }

dispatchMain()
}
else {
    fatalError("This demo requires macOS 10.15+ to run.")
}

