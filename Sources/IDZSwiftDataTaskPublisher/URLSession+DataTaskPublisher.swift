//
//  URLSession+DataTaskPublisher.swift
//  CombinePlay_macOS
//
//  Created by idz on 6/11/19.
//  Copyright © 2019 iOS Developer Zone. 
//

import Foundation
import Combine

extension URLSession {
    public func dataTaskPublisher(for request: URLRequest) -> DataTaskPublisher {
        return DataTaskPublisher(request: request, session: self)
    }
}

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
