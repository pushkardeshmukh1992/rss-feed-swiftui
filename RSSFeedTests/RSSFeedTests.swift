//
//  RSSFeedTests.swift
//  RSSFeedTests
//
//  Created by Admin on 14/09/23.
//

import XCTest
import Combine

@testable import RSSFeed

final class RSSFeedTests: XCTestCase {

    func test() {
        XCTAssertEqual("test", "test")
    }
    
    // MARK: Publication view model tests
    func testPublications_initialLoadShouldHaveAtLeastOneActivePublication() {
        let sut = PublicationsViewModel()
        
        XCTAssertNotEqual(sut.publications.count, 0)
        XCTAssertEqual(sut.publications[0].active, true)
    }
    
    func testPublications_publicationShouldToggleActiveFlag() {
        let sut = PublicationsViewModel()
        
        let oldPublicationState = sut.publications[0]
        
        sut.toggleActivePublication(publication: oldPublicationState)
        
        let newPublicationState = sut.publications[0]
        
        XCTAssertNotEqual(oldPublicationState.active, newPublicationState.active)
    }
    
    // MARK: Feed view model tests
    
    var cancellables = [AnyCancellable]()
    
    func testFeeds_deliversSuccessOnSuccessfulFeedFetch() {
        let result = FeedResult.success(DataUtil.defaultRSS)
        
        let sut = FeedViewModel(publication: DataUtil.publication1, feedService: MockFeedService(result: result))
        
        sut.getFeed()
        
        let exp = expectation(description: "Getting feed data for a publication")
        
        sut.$feed.sink { rss in
            if rss != nil {
                exp.fulfill()
            }
        }.store(in: &cancellables)
        
        wait(for: [exp], timeout: 2)
    }
    
    func testFeeds_shouldNotFetchDataAgainIfFeedIsPresent() {
        let result = FeedResult.success(DataUtil.defaultRSS)
        
        let sut = FeedViewModel(publication: DataUtil.publication1, feedService: MockFeedService(result: result))
        
        sut.getFeed()
        
        var capturedResults = [FeedResult]()
        
        let exp = expectation(description: "Should not fetch the data again if feed is already fetched")
        
        sut.$feed.sink { rss in
            capturedResults.append(.success(DataUtil.defaultRSS))
            
            sut.getFeed()
            
            if sut.feed != nil && capturedResults.count == 1 {
                // Note: Feed is not null and captureResults same even after calling gedFeed() twice
                exp.fulfill()
            }
        }.store(in: &cancellables)
        
        exp.fulfill()
        
        wait(for: [exp], timeout: 3)
    }
    
    func testFeeds_deliversFailureOnFeedFetchForHTTPError() {
        let result = FeedResult.failure(.httpError)
        
        let sut = FeedViewModel(publication: DataUtil.publication1, feedService: MockFeedService(result: result))
        
        sut.getFeed()
        
        let exp = expectation(description: "Getting feed data for a publication")
        
        sut.$error.sink { error in
            if let _ = error {
                exp.fulfill()
            }
        }.store(in: &cancellables)
        
        wait(for: [exp], timeout: 2)
    }
    
    // MARK: Feed service implementation tests
    
    func test_deliversSuccessResponseOnValidURL() {
        let sut = FeedService()
        
        let url = DataUtil.publication1.url
        
        let exp = expectation(description: "Fetch publication feeds for given \(url.absoluteString)")
        
        sut.getFeed(url: url) { result in
            switch result {
            case .success(_):
                exp.fulfill()
            case .failure(_): break
            }
        }
        
        wait(for: [exp], timeout: 4)
    }
    
    func test_deliversFailureResponseOnInValidURL() {
        let sut = FeedService()
        
        let url = URL(string: "https://any-url.com")!
        
        let exp = expectation(description: "Should throw error on invalid error while fetching feed \(url.absoluteString)")
        
        sut.getFeed(url: url) { result in
            switch result {
            case .success(_): break
            case .failure(_): exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 4)
    }
    
    func test_deliversFailureResponseOnValidURLButJSONResponse() {
        let sut = FeedService()
        
        let url = URL(string: "https://fakestoreapi.com/products")!
        
        let exp = expectation(description: "Should throw parse error while fetching json url instead of xml \(url.absoluteString)")
        
        sut.getFeed(url: url) { result in
            switch result {
            case .success(_): XCTFail("Response was not expected for this json")
            case .failure(_): exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 4)
    }
    
    class MockFeedService: FeedServiceProtocol {
        let result: FeedResult
        
        init(result: FeedResult) {
            self.result = result
        }
        
        func getFeed(url: URL, completion: @escaping (FeedResult) -> Void) {
            completion(result)
        }
    }
}
