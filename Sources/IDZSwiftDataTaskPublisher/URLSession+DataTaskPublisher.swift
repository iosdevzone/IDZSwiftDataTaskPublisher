//
//  URLSession+DataTaskPublisher.swift
//  CombinePlay_macOS
//
//  Created by idz on 6/11/19.
//
// MIT License
//   
//  Copyright © 2019 iOS Developer Zone. (ww.iosdeveloperzone.com)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension URLSession {
    public func dataTaskPublisher(for request: URLRequest) -> DataTaskPublisher {
        return DataTaskPublisher(request: request, session: self)
    }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public class DataTaskPublisher : Publisher {
    
    // Publisher Conformance
    public typealias Output = (data: Data, reponse: URLResponse)
    public typealias Failure = URLError
    public func receive<S>(subscriber: S) where S : Subscriber, DataTaskPublisher.Failure == S.Failure,
        DataTaskPublisher.Output == S.Input
    {
        _subject.receive(subscriber: subscriber)
        _task?.resume()
    }
    
    // Let PassthroughSubject do most of the heavy lifting
    private let _subject = PassthroughSubject<Output, Failure>()
    private func completionHandler(_ data: Data?, _ response: URLResponse?, error: Error?) {
        if let error = error as? URLError {
            self._subject.send(completion: Subscribers.Completion<URLError>.failure(error))
        }
        else {
            self._subject.send((data: data!, reponse: response!))
            
        }
    }
    
    private var _task: URLSessionDataTask? = nil
    fileprivate init(request: URLRequest, session: URLSession) {
        _task = session.dataTask(with: request, completionHandler: self.completionHandler)        
    }
}
