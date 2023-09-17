//
//  PublicationsViewModelTestCases.swift
//  RSSFeedTests
//
//  Created by Admin on 17/09/23.
//

import XCTest
import Combine

@testable import RSSFeed

final class PublicationsViewModelTestCases: XCTestCase {
    // MARK: Publication view model tests
    func testPublications_initialLoadShouldHaveAtLeastOneActivePublication() {
        let sut = PublicationsViewModel()
        
        let active = sut.isAnyPublicationActive()
        XCTAssertNotEqual(sut.publications.count, 0)
        XCTAssertEqual(active, true)
    }
    
    func testPublications_publicationShouldToggleActiveFlag() {
        let sut = PublicationsViewModel()
        
        let oldPublicationState = sut.publications[0]
        
        sut.toggleActivePublication(publication: oldPublicationState)
        
        let newPublicationState = sut.publications[0]
        
        XCTAssertNotEqual(oldPublicationState.active, newPublicationState.active)
    }
}
