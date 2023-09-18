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
    
    override func setUp() {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    func test_savesDataOnSuccessfullSave() {
        let sut = getSUT()
        
        let itemToSave = DataUtil.feedItem
        let _ = sut.save(data: itemToSave)
        let savedItems = sut.get()
        
        XCTAssertEqual([itemToSave], savedItems)
    }
    
    func test_shouldReturnEmptyOnInvalidEncodableData() {
        let sut = getSUT()
        
        let _ = sut.save(data: Double.infinity)
        let savedItems = sut.get()
        
        XCTAssertEqual(savedItems.count, 0)
    }
    
    func test_shouldReturnEmptyOnInvalidData() {
        let sut = getSUT()
        
        let _ = sut.save(data: getInvalidData())
        let savedItems = sut.get()
        
        XCTAssertEqual(savedItems.count, 0)
    }
    
    func test_shouldRemoveFeedItemFromCacheOnSuccessfullRemove() {
        let sut = getSUT()
        
        let _ = sut.save(data: DataUtil.feedItem)
        let _ = sut.save(data: DataUtil.feedItem2)
        
        let savedItems = sut.get()
        
        XCTAssertEqual(savedItems, [DataUtil.feedItem, DataUtil.feedItem2])
        
        let _ = sut.remove(feedItem: DataUtil.feedItem)
        
        XCTAssertEqual(sut.get(), [DataUtil.feedItem2])
    }
    
    func getSUT() -> FeedBookmarkUserDefaultsCacheService {
        return FeedBookmarkUserDefaultsCacheService(cacheKey: key)
    }
    
    func getInvalidData() -> Data {
        let json = ["items": ""]
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    
}
