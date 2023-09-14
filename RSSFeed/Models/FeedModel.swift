//
//  FeedModel.swift
//  RSSFeed
//
//  Created by Admin on 14/09/23.
//

import Foundation

struct RSSResponse: Codable {
    let rss: RSS
}

struct RSS: Codable {
    let channel: Channel
}

struct Channel: Codable {
    let title: String
    let description: String
    let link: String
    let image: ChannelImage
    let items: [FeedItem]
    
    enum CodingKeys: String, CodingKey {
        case title, description, link, image
        case items = "item"
    }
}

struct ChannelImage: Codable {
    let url: String
    let title: String
    let link: String
}

struct FeedItem: Codable, Identifiable {
    var id: String { title }
    let title: String
    let link: String
    let category: [String]
    let pubDate: String
    let creator: String
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case title, link, category, pubDate, creator
        case content = "description"
    }
}




