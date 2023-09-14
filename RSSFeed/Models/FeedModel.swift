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
    let title: ChannelTitle
}

struct ChannelTitle: Codable {
    let data: String
    
    enum EncodingKeys: String, CodingKey {
        case data = "__cdata"
    }
}

