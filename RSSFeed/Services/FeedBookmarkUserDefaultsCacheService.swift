//
//  FeedBookmarkUserDefaultsCacheService.swift
//  RSSFeed
//
//  Created by Admin on 17/09/23.
//

import Foundation

protocol FeedBookmarkServiceProtocol {
    func save<T: Codable>(data: T) -> Bool
    func get() -> [FeedItem]
    func remove(feedItem: FeedItem) -> Bool
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

enum CacheTypes {
    case userDefaults
    case coreData
}

class FeedBookmarkUserDefaultsCacheService: FeedBookmarkServiceProtocol {
    let cacheKey: String
    
    init(cacheKey: String) {
        self.cacheKey = cacheKey
    }
    
    func save<T: Codable>(data: T) -> Bool {
        guard let data = data as? FeedItem else { return false }
        
        let encoder = JSONEncoder()
        
        do {
            var items = get()
            items.append(data)
            
            let encoded = try encoder.encode(items)
            UserDefaults.standard.set(encoded, forKey: cacheKey)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func get() -> [FeedItem] {
        if let data = UserDefaults.standard.object(forKey: cacheKey) as? Data {
            let decoder = JSONDecoder()
            
            if let object = try? decoder.decode([FeedItem].self, from: data) {
                return object
            }
        }
        
        return []
    }
    
    func remove(feedItem: FeedItem) -> Bool {
        let items = get().filter { $0.id != feedItem.id }
        
        UserDefaults.standard.removeObject(forKey: cacheKey)
        
        items.forEach { item in
            let _ = save(data: item)
        }
        
        return true
        
    }
}
