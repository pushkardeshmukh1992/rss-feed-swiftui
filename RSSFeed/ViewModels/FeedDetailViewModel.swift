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
    
    init(item: FeedItem, feedBookmarkService: FeedBookmarkServiceProtocol) {
        self.item = item
        self.feedBookmarkService = feedBookmarkService
        
        checkAndUpdateBookmark()
    }
    
    func saveBookmark() {
        var bookmarks = feedBookmarkService.get()
        bookmarks.append(item)

        if feedBookmarkService.save(data: bookmarks) {
            isBookmarked = hasBookmarked()
        }
    }
    
    func removeBookmark() {
        let bookmarks = feedBookmarkService.get().filter { $0.id != item.id }
        
        if feedBookmarkService.save(data: bookmarks) {
            isBookmarked = hasBookmarked()
        }
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
