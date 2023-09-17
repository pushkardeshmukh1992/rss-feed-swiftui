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

struct RSS: Codable, Equatable {
    static func == (lhs: RSS, rhs: RSS) -> Bool {
        return lhs.channel.title == rhs.channel.title
    }
    
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
    
    var imageURL: URL {
        return URL(string: url)!
    }
}

struct FeedItem: Codable, Identifiable, Equatable {
    var id: String { title }
    let title: String
    let linkString: String
    let category: [String]
    let pubDate: Date
    let creator: String
    let content: String
    
    var url: URL? {
        return URL(string: linkString)
    }
    
    enum CodingKeys: String, CodingKey {
        case title, category, pubDate, creator
        case linkString = "link"
        case content = "description"
    }
}




