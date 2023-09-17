//
//  FeedDetailViewModel.swift
//  RSSFeed
//
//  Created by Admin on 15/09/23.
//

import Foundation

class FeedDetailsViewModel: ObservableObject {
    @Published var isBookmarked = false
    
    private let feedBookmarkService = FeedBookmarkService(cacheKey: "FeedItemBookMarks")
    
    let item: FeedItem
    
    init(item: FeedItem) {
        self.item = item
        isBookmarked = hasBookmarked()
    }
    
    func saveBookmark() {
        var bookmarks = feedBookmarkService.get()
        bookmarks.append(item)
        
        feedBookmarkService.save(data: bookmarks)
        isBookmarked = true
    }
    
    func removeBookmark() {
        let bookmarks = feedBookmarkService.get().filter { $0.id != item.id }
        
        feedBookmarkService.save(data: bookmarks)
        isBookmarked = false
    }
    
    func handleBookmark() {
        if !hasBookmarked() {
            saveBookmark()
        } else {
            removeBookmark()
        }
    }
    
    func hasBookmarked() -> Bool {
        let bookmarks = feedBookmarkService.get()
        
        return bookmarks.contains { $0.id == item.id }
    }
    
    func checkAndUpdateBookmark() {
        self.isBookmarked = hasBookmarked()
    }
}

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
