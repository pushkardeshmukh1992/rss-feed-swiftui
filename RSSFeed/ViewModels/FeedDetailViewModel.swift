//
//  FeedDetailViewModel.swift
//  RSSFeed
//
//  Created by Admin on 15/09/23.
//

import Foundation

class FeedDetailsViewModel: ObservableObject {
    @Published var isBookmarked = false
    
    let feedBookmarkService: FeedBookmarkServiceProtocol
    
    let item: FeedItem
    
    init(item: FeedItem, feedBookmarkService: FeedBookmarkServiceProtocol = FeedBookmarkService(cacheKey: "FeedItemBookMarks")) {
        self.item = item
        self.feedBookmarkService = feedBookmarkService
        
        isBookmarked = hasBookmarked()
    }
    
    func saveBookmark() {
        var bookmarks = feedBookmarkService.get()
        bookmarks.append(item)

        feedBookmarkService.save(data: bookmarks)
        isBookmarked = hasBookmarked()
    }
    
    func removeBookmark() {
        let bookmarks = feedBookmarkService.get().filter { $0.id != item.id }
        
        feedBookmarkService.save(data: bookmarks)
        isBookmarked = hasBookmarked()
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
