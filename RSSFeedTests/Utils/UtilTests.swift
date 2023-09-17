//
//  UtilTests.swift
//  RSSFeedTests
//
//  Created by Admin on 17/09/23.
//

import XCTest
@testable import RSSFeed

class UtilTests: XCTestCase {
    // 1515009605.0
    // 04 Jan, 1:30 AM
    
    func test_dateFormat() {
        let date = Date(timeIntervalSince1970: 1515009605.0)
        
        let formattedString = DateUtil.formatDate(date: date)
        
        XCTAssertEqual(formattedString, "04 Jan, 1:30 AM")
    }

}
