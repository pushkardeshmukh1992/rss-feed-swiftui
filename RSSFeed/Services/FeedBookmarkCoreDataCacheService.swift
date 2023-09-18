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

    func save(feedItem: FeedItem) -> Bool {
        if let bookmark: Bookmarks = NSEntityDescription.insertNewObject(forEntityName: EntityConstant.bookmarks, into: container.viewContext) as? Bookmarks {
            bookmark.title = feedItem.title
            bookmark.linkString = feedItem.linkString
            bookmark.pubDate = feedItem.pubDate
            bookmark.creator = feedItem.creator
            bookmark.content = feedItem.content
            bookmark.category = feedItem.category as NSArray
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
    
    func remove(feedItem: FeedItem) -> Bool {
        let fetchRequest = Bookmarks.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "title == %@", feedItem.title)
        
        let results = try? container.viewContext.fetch(fetchRequest)
        
        if let results = results, let match = results.first {
            container.viewContext.delete(match)
            
            do {
                try container.viewContext.save()
                return true
            } catch {
                return false
            }
        } else {
            return false
        }
    }
}
