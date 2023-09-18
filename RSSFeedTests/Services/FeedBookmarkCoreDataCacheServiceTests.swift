//
//  FeedBookmarkCoreDataCacheServiceTests.swift
//  RSSFeedTests
//
//  Created by Admin on 18/09/23.
//

import XCTest
@testable import RSSFeed

final class FeedBookmarkCoreDataCacheServiceTests: XCTestCase {

    func test_savesDataOnSuccessfullSaveOperation() {
        let sut = getSUT()
        
        let itemToSave = DataUtil.feedItem
        let _ = sut.save(feedItem: itemToSave)
        
        XCTAssertEqual([itemToSave], sut.get())
    }
    
    func test_removesDataOnSuccessfullRemoveOperation() {
        let sut = getSUT()
        
        let itemToSave = DataUtil.feedItem
        let _ = sut.save(feedItem: itemToSave)
        
        XCTAssertEqual([itemToSave], sut.get())
        
        let _ = sut.remove(feedItem: itemToSave)
        XCTAssertEqual(sut.get().count, 0)
    }
    
    func getSUT() -> FeedBookmarkCoreDataCacheService {
        return FeedBookmarkCoreDataCacheService(inMemory: true)
    }
}
