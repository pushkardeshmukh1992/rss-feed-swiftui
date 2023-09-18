//
//  FeedBookmarkService.swift
//  RSSFeed
//
//  Created by Admin on 17/09/23.
//

import Foundation

protocol FeedBookmarkServiceProtocol {
    func save<T: Codable>(data: T) -> Bool
    func get() -> [FeedItem]
}

class FeedBookmarkService: FeedBookmarkServiceProtocol {
    let cacheKey: String
    
    init(cacheKey: String) {
        self.cacheKey = cacheKey
    }
    
    func save<T: Codable>(data: T) -> Bool {
        let encoder = JSONEncoder()
        
        do {
            let encoded = try encoder.encode(data)
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
}
