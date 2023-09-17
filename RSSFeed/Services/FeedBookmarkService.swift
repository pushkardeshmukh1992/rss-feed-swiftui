//
//  FeedBookmarkService.swift
//  RSSFeed
//
//  Created by Admin on 17/09/23.
//

import Foundation

class FeedBookmarkService {
    let cacheKey: String
    
    init(cacheKey: String) {
        self.cacheKey = cacheKey
    }
    
    func save<T: Codable>(data: T) {
        let encoder = JSONEncoder()
        
        do {
            let encoded = try encoder.encode(data)
            UserDefaults.standard.set(encoded, forKey: cacheKey)
        } catch {
            print(error)
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
