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
        
        guard let path = Bundle.main.path(forResource: "Example", ofType: "xml"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static file")
            return
        }
        
        let feed = try XMLDecoderUtil.getXMLDecoder().decode(RSS.self, from: data.dataMiddleware())
        
        let session = getSession(data: data, error: nil)
        let sut = FeedService()
        sut.getFeed(url: url, session: session) { result in
            XCTAssertEqual(result, .success(feed))
        }
    }
    
    func test_deliversFailureResponseOnInvalidURL() {
        let url = DataUtil.publication1.url
        let session = getSession(data: nil, error: .httpError)
        
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
        let session = getSession(data: FeedServiceTests.getInvalidData(), error: nil)

        let exp = expectation(description: "Feed service fetch should return error on invalid data response")

        let sut = FeedService()
        sut.getFeed(url: url, session: session) { result in
            switch result {
            case .success(_):
                XCTFail("Feed service returned success instead of failure")
            case .failure(let error):
                print(error)
                XCTAssertEqual(error, APIError.parseError)
                exp.fulfill()
            }
        }

        wait(for: [exp], timeout: 3)
    }
    
    func test_deliversFailureResponseOnEmptyData() {
        let url = DataUtil.publication1.url
        let session = getSession(data: nil, error: nil)

        let exp = expectation(description: "Feed service fetch should return error on invalid data response")

        let sut = FeedService()
        sut.getFeed(url: url, session: session) { result in
            switch result {
            case .success(_):
                XCTFail("Feed service returned success instead of failure")
            case .failure(let error):
                print(error)
                XCTAssertEqual(error, APIError.dataError)
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
    
    private func getSession(data: Data?, error: APIError?) -> URLSession {
        let session = URLSessionMock()
        session.data = data
        session.error = error
        return session
    }
    
    static func getInvalidData() -> Data {
        let json = ["items": ""]
        return try! JSONSerialization.data(withJSONObject: json)
    }

}


class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override func resume() {
        closure()
    }
}

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    var data: Data?
    var error: Error?
    
    override func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler
    ) -> URLSessionDataTask {
        let data = self.data
        let error = self.error

        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}
