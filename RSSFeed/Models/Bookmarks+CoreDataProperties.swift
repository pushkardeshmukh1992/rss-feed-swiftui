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

    @NSManaged public var title: String?

}

extension Bookmarks : Identifiable {

}
