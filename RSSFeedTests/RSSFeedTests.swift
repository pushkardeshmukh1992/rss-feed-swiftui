//
//  RSSFeedTests.swift
//  RSSFeedTests
//
//  Created by Admin on 14/09/23.
//

import XCTest
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
    
    func testFeeds_successfullyFetchFeedOnSuccess() {
        let sub = FeedViewModel(publication: DataUtil.publication1, feedService: MockFeedService())
    }
    
    class MockFeedService: FeedServiceProtocol {
        func getFeed(url: URL, completion: @escaping (Result<RSSFeed.RSS, RSSFeed.APIError>) -> Void) {
            
        }
    }
}
