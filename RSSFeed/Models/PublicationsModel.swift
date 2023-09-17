//
//  PublicationsModel.swift
//  RSSFeed
//
//  Created by Admin on 14/09/23.
//

import Foundation

struct Publication: Identifiable {
    let id: String
    let rss: RSS?
    let url: URL
    let title: String
    var localImage: String?
    
    var active: Bool = false
}
