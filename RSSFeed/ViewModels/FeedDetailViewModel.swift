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
        var bookmarksToSave = feedBookmarkService.get()
        bookmarksToSave.append(item)

        if feedBookmarkService.save(data: bookmarksToSave) {
            isBookmarked = hasBookmarked()
        }
    }
    
    func removeBookmark() {
        let bookmarks = feedBookmarkService.get().filter { $0.id != item.id }
        
        if feedBookmarkService.remove(feedItem: item) {
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
