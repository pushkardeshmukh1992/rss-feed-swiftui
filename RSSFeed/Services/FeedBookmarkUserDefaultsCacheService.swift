//
//  FeedBookmarkUserDefaultsCacheService.swift
//  RSSFeed
//
//  Created by Admin on 17/09/23.
//

import Foundation

protocol FeedBookmarkServiceProtocol {
    func save(feedItem: FeedItem) -> Bool
    func get() -> [FeedItem]
    func remove(feedItem: FeedItem) -> Bool
}

class FeedBookmarkUserDefaultsCacheService: FeedBookmarkServiceProtocol {
    let cacheKey: String
    
    init(cacheKey: String) {
        self.cacheKey = cacheKey
    }
    
    func save(feedItem: FeedItem) -> Bool {
        do {
            var items = get()
            items.append(feedItem)
            
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(items)
            UserDefaults.standard.set(encoded, forKey: cacheKey)
            return true
        } catch {
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
            let _ = save(feedItem: item)
        }
        
        return true
        
    }
}
