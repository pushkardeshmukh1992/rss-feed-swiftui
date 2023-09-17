//
//  FeedDetailViewTestCases.swift
//  RSSFeedTests
//
//  Created by Admin on 17/09/23.
//

import XCTest
@testable import RSSFeed

final class BookmarkServiceTests: XCTestCase {
    
    func test_savesDataOnSuccessfullSave() {
        let sut = FeedBookmarkService(cacheKey: "TestBookmark1")
        
        let itemsToSave = [DataUtil.feedItem]
        sut.save(data: itemsToSave)
        let savedItems = sut.get()
        
        XCTAssertEqual(itemsToSave, savedItems)
    }
    
    func test_shouldReturnEmptyOnInvalidEncodableData() {
        let sut = FeedBookmarkService(cacheKey: "TestBookmark2")
        
        sut.save(data: Double.infinity)
        let savedItems = sut.get()
        
        XCTAssertEqual(savedItems.count, 1)
    }
}
