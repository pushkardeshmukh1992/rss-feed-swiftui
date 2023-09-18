//
//  CategoryTransformer.swift
//  RSSFeed
//
//  Created by Admin on 18/09/23.
//

import Foundation

class CategoryTransformer: ValueTransformer {
    override func transformedValue(_ value: Any?) -> Any? {
        guard let categories = value as? [String] else { return nil }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: categories, requiringSecureCoding: true)
            return data
        } catch {
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        
        do {
            let data = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: data)
            return data
        } catch {
            return nil
        }
    }
}
