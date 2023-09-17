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
        let sut = FeedBookmarkService(cacheKey: "TestBookmark")
        
        let itemsToSave = [DataUtil.feedItem]
        sut.save(data: itemsToSave)
        let savedItems = sut.get()
        
        XCTAssertEqual(itemsToSave, savedItems)
    }
}
