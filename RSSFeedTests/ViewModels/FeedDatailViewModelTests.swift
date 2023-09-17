//
//  FeedDatailViewModelTests.swift
//  RSSFeedTests
//
//  Created by Admin on 17/09/23.
//

import XCTest
@testable import RSSFeed

final class FeedDatailViewModelTests: XCTestCase {
    func test_initiBookmarkShouldBeDisabled() {
        let mockFeedBookmarkService: FeedBookmarkServiceProtocol = MockFeedBookmarkService()
        
        let sut = FeedDetailsViewModel(item: DataUtil.feedItem, feedBookmarkService: mockFeedBookmarkService)
        
        XCTAssertEqual(sut.isBookmarked, false)
    }
    
    
    class MockFeedBookmarkService: FeedBookmarkServiceProtocol {
        var items = [Any]()
        
        func save<T>(data: T) {
            items.append(data)
        }
        
        func get() -> [RSSFeed.FeedItem] {
            var tempItems = [RSSFeed.FeedItem]()
            
            items.forEach { item in
                if let feedItem = item as? RSSFeed.FeedItem {
                    tempItems.append(feedItem)
                }
            }
            
            return tempItems
        }
    }
}
