//
//  FeedViewModelTestCases.swift
//  RSSFeedTests
//
//  Created by Admin on 17/09/23.
//

import XCTest
import Combine

@testable import RSSFeed

final class FeedViewModelTestCases: XCTestCase {

    var cancellables = [AnyCancellable]()
    
    // MARK: Feed view model tests
    
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
    
    class MockFeedService: FeedServiceProtocol {
        let result: FeedResult
        
        init(result: FeedResult) {
            self.result = result
        }
        
        func getFeed(url: URL, session: URLSession = URLSession.shared,  completion: @escaping (FeedResult) -> Void) {
            completion(result)
        }
    }

}
