//
//  FeedDetailViewTestCases.swift
//  RSSFeedTests
//
//  Created by Admin on 17/09/23.
//

import XCTest
@testable import RSSFeed

final class BookmarkServiceTests: XCTestCase {
    let key = "TestBookMark"
    
    func test_savesDataOnSuccessfullSave() {
        let sut = FeedBookmarkUserDefaultsCacheService(cacheKey: key)
        
        let itemsToSave = [DataUtil.feedItem]
        sut.save(data: itemsToSave)
        let savedItems = sut.get()
        
        XCTAssertEqual(itemsToSave, savedItems)
    }
    
    func test_shouldReturnEmptyOnInvalidEncodableData() {
//        let key = "TestBookmark2"
        let sut = FeedBookmarkUserDefaultsCacheService(cacheKey: key)
        
        sut.save(data: Double.infinity)
        let savedItems = sut.get()
        
        XCTAssertEqual(savedItems.count, 0)
    }
    
    func test_shouldReturnEmptyOnInvalidData() {
//        let key = "TestBookmark3"
        let sut = FeedBookmarkUserDefaultsCacheService(cacheKey: key)
        
        sut.save(data: getInvalidData())
        let savedItems = sut.get()
        
        XCTAssertEqual(savedItems.count, 0)
    }
    
    func getInvalidData() -> Data {
        let json = ["items": ""]
        return try! JSONSerialization.data(withJSONObject: json)
    }
}
