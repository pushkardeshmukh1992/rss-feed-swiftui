//
//  DataUtil.swift
//  RSSFeed
//
//  Created by Admin on 14/09/23.
//

import Foundation

enum DataUtil {
    static let publication1 = Publication(id: "1", rss: nil, url: URL(string: "https://medium.com/feed/backchannel")!, title: "Backchannel Tech Publication")
    
    static let feedItem = FeedItem(title: "Feed item title", link: "https://www.google.com", category: ["category1", "category2"], pubDate: "", creator: "", content: "")
}
