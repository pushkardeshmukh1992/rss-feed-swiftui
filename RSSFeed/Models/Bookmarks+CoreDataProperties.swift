//
//  Bookmarks+CoreDataProperties.swift
//  RSSFeed
//
//  Created by Admin on 18/09/23.
//
//

import Foundation
import CoreData

extension Bookmarks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bookmarks> {
        return NSFetchRequest<Bookmarks>(entityName: "Bookmarks")
    }

    @NSManaged public var title: String
    @NSManaged public var pubDate: Date
    @NSManaged public var linkString: String
    @NSManaged public var creator: String
    @NSManaged public var content: String
    @NSManaged public var category: NSArray

}

extension Bookmarks : Identifiable {

}
