//
//  UtilTests.swift
//  RSSFeedTests
//
//  Created by Admin on 17/09/23.
//

import XCTest
@testable import RSSFeed

class UtilTests: XCTestCase {
    func test_dateFormat() {
        let date = Date(timeIntervalSince1970: 1515009605.0)
        
        let formattedString = DateUtil.formatDate(date: date)
        
        XCTAssertEqual(formattedString, "04 Jan, 1:30 AM")
    }
    
    func test_channelStruct_ifImageURLComputedPropertyIsGenerated() {
        let rss = DataUtil.publication1
        let urlString = rss.rss?.channel.image.url
        
        XCTAssertEqual(urlString, rss.rss?.channel.image.imageURL.absoluteString)
        
    }

}
