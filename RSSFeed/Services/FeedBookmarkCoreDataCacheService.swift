//
//  FeedBookmarkCoreDataCacheService.swift
//  RSSFeed
//
//  Created by Admin on 18/09/23.
//

import Foundation
import CoreData

class FeedBookmarkCoreDataCacheService: FeedBookmarkServiceProtocol {

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        ValueTransformer.setValueTransformer(CategoryTransformer(), forName: NSValueTransformerName("CategoryTransformer"))
        container = NSPersistentContainer(name: "RSSFeedCoreData")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func save<T>(data: T) -> Bool {
        // 1. TODO: Convert T into array of FeedItem i.e. [FeedItem]
        // 2. TODO: Convert [FeedItem] to [Bookmarks]
        // 3. TODO: Save each Bookmarks in db

        guard let feedItems = data as? [FeedItem] else { return false }

        let _ = feedItems.compactMap { feedItem in
            if let bookmark: Bookmarks = NSEntityDescription.insertNewObject(forEntityName: "Bookmarks", into: container.viewContext) as? Bookmarks {
                bookmark.title = feedItem.title
                bookmark.linkString = feedItem.linkString
                bookmark.pubDate = feedItem.pubDate
                bookmark.creator = feedItem.creator
                bookmark.content = feedItem.content
                bookmark.category = feedItem.category as NSArray
                
                return bookmark
            }
            return nil
        }
        
        do {
            try container.viewContext.save()
            return true
        } catch {
            print(error)
            return false
        }
    }

    func get() -> [FeedItem] {
        let fetchRequest = Bookmarks.fetchRequest()

        do {
            let bookmarks = try container.viewContext.fetch(fetchRequest)

            let feedItems = bookmarks.map { bookmark in
                FeedItem(title: bookmark.title, linkString: bookmark.linkString, category: (bookmark.category as? [String]) ?? [], pubDate: bookmark.pubDate, creator: bookmark.creator, content: bookmark.content)
            }

            return feedItems
        } catch {
            print("error fetching bookmarks")
        }

        return []
    }
}
