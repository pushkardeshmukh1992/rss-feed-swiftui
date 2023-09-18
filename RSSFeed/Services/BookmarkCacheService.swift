//
//  BookmarkCacheService.swift
//  RSSFeed
//
//  Created by Admin on 18/09/23.
//

import Foundation

enum CacheTypes {
    case userDefaults
    case coreData
}

class BookmarkCacheService {
    static func getActiveService() -> FeedBookmarkServiceProtocol {
        if CacheConstants.activeCache == .coreData {
            return FeedBookmarkCoreDataCacheService()
        } else {
            return FeedBookmarkUserDefaultsCacheService(cacheKey: CacheConstants.bookmarkCacheKey)
        }
    }
}


