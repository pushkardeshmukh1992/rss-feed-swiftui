//
//  FeedDatailViewModelTests.swift
//  RSSFeedTests
//
//  Created by Admin on 17/09/23.
//

import XCTest
@testable import RSSFeed

final class FeedDatailViewModelTests: XCTestCase {
    let key = "FeedDatailViewModelTests"
    
    override func setUp() {
        UserDefaults.standard.setValue(nil, forKey: key)
    }
    
    func test_initiBookmarkShouldBeDisabled() {
        let bookmarkService = FeedBookmarkService(cacheKey: key)
        
        let sut = FeedDetailsViewModel(item: DataUtil.feedItem, feedBookmarkService: bookmarkService)
        
        XCTAssertEqual(sut.isBookmarked, false)
    }
    
    func test_saveBookmarkShouldAddBookmark() {
        let bookmarkService = FeedBookmarkService(cacheKey: key)
        
        let sut = FeedDetailsViewModel(item: DataUtil.feedItem, feedBookmarkService: bookmarkService)
        
        sut.saveBookmark()
        
        XCTAssertEqual(sut.isBookmarked, true)
    }
    
    func test_removeBookmarkShouldRemoveBookmark() {
        let bookmarkService = FeedBookmarkService(cacheKey: key)
        
        let sut = FeedDetailsViewModel(item: DataUtil.feedItem, feedBookmarkService: bookmarkService)
        
        sut.removeBookmark()
        
        XCTAssertEqual(sut.isBookmarked, false)
    }
    
    func test_handleBookmarkActionShouldAddOrRemoveBookmark() {
        let bookmarkService = FeedBookmarkService(cacheKey: key)
        
        let sut = FeedDetailsViewModel(item: DataUtil.feedItem, feedBookmarkService: bookmarkService)
        
        sut.isBookmarked = false
        sut.handleBookmark()
        XCTAssertEqual(sut.isBookmarked, true)
        
        sut.handleBookmark()
        XCTAssertEqual(sut.isBookmarked, false)
    }
}
