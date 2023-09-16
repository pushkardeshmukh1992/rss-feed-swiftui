//
//  MockURLSessionProtocol.swift
//  RSSFeedTests
//
//  Created by Admin on 16/09/23.
//

import Foundation
import XCTest

class MockURLSessionProtocol: URLProtocol {
    
    static var loadingHandler: (() -> (HTTPURLResponse, Data?, Error?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLSessionProtocol.loadingHandler else {
            XCTFail("Loading handler is not set")
            return
        }
        
        let (response, data, error) = handler()
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let error = error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {

    }
}
