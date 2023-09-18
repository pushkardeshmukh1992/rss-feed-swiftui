//
//  FeedDetailViewModel.swift
//  RSSFeed
//
//  Created by Admin on 15/09/23.
//

import Foundation

class FeedDetailsViewModel: ObservableObject {
    @Published var isBookmarked = false
    
    let bookmarkService: FeedBookmarkServiceProtocol
    
    let item: FeedItem
    
    init(item: FeedItem, feedBookmarkService: FeedBookmarkServiceProtocol) {
        self.item = item
        self.bookmarkService = feedBookmarkService
        
        checkAndUpdateBookmark()
    }
    
    func saveBookmark() {
        var bookmarksToSave = bookmarkService.get()
        bookmarksToSave.append(item)

        if bookmarkService.save(data: bookmarksToSave) {
            isBookmarked = hasBookmarked()
        }
    }
    
    func removeBookmark() {
        if bookmarkService.remove(feedItem: item) {
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
        let bookmarks = bookmarkService.get()
        
        return bookmarks.contains { $0.id == item.id }
    }
    
    func checkAndUpdateBookmark() {
        self.isBookmarked = hasBookmarked()
    }
}
