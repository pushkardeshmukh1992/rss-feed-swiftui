//
//  FeedServiceTests.swift
//  RSSFeedTests
//
//  Created by Admin on 16/09/23.
//

import XCTest
@testable import RSSFeed

class FeedServiceTests: XCTestCase {
    func test_deliversSuccessResponseOnValidURL() throws {
        let url = DataUtil.publication1.url
        let session = getSession()
        
        guard let path = Bundle.main.path(forResource: "Example", ofType: "xml"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static file")
            return
        }
        
        let feed = try XMLDecoderUtil.getXMLDecoder().decode(RSS.self, from: data.dataMiddleware())
    
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response!, data, nil)
        }
        
        let sut = FeedService()
        sut.getFeed(url: url, session: session) { result in
            XCTAssertEqual(result, .success(feed))
        }
    }
    
    func test_deliversFailureResponseOnInvalidURL() {
        let url = DataUtil.publication1.url
        let session = getSession()
        
        MockURLSessionProtocol.loadingHandler = {
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response!, nil, APIError.httpError)
        }
        
        let exp = expectation(description: "Feed service fetch should return on network failure")
        
        let sut = FeedService()
        sut.getFeed(url: url, session: session) { result in
            switch result {
            case .success(_):
                XCTFail("Feed service returned success instead of failure")
            case .failure(let error):
                XCTAssertEqual(error, APIError.httpError)
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 3)
    }
    
    func test_deliversFailureResponseOnInvalidData() {
        let url = DataUtil.publication1.url
        let session = getSession()

        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response!, FeedServiceTests.getInvalidData(), nil)
        }

        let exp = expectation(description: "Feed service fetch should return error on invalid data response")

        let sut = FeedService()
        sut.getFeed(url: url, session: session) { result in
            switch result {
            case .success(_):
                XCTFail("Feed service returned success instead of failure")
            case .failure(let error):
                print(error)
//                XCTAssertEqual(error, APIError.dataError)
                exp.fulfill()
            }
        }

        wait(for: [exp], timeout: 3)
    }
    
    private func getSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        
        return URLSession(configuration: configuration)
    }
    
    static func getInvalidData() -> Data {
        let json = ["items": ""]
        return try! JSONSerialization.data(withJSONObject: json)
    }

}
