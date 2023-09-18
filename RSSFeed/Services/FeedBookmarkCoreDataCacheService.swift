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
//                bookmark.linkString
//                FeedItem(title: <#T##String#>, linkString: <#T##String#>, category: <#T##[String]#>, pubDate: <#T##Date#>, creator: <#T##String#>, content: <#T##String#>)
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
                FeedItem(title: bookmark.title ?? "", linkString: "", category: [], pubDate: Date(), creator: "Pushkar Deshmukh", content: "Hi")
            }

            return feedItems
        } catch {
            print("error fetching bookmarks")
        }

        return []
    }
}
