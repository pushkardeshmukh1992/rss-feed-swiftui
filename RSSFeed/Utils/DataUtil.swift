//
//  DataUtil.swift
//  RSSFeed
//
//  Created by Admin on 14/09/23.
//

import Foundation

enum DataUtil {
    static let publication1 = Publication(id: "1",
                                          rss: RSS(channel: Channel(title: "Channel", description: "Descriptions", link: "htts://www.google.com", image: ChannelImage(url: "https://cdn-images-1.medium.com/v2/format:png/1*TGH72Nnw24QL3iV9IOm4VA.png", title: "Channel image title", link: "https://any-channel-image.com"), items: [])),
                                          url: URL(string: "https://medium.com/feed/backchannel")!,
                                          title: "Backchannel Tech Publication")
    
    static let feedItem = FeedItem(title: "Feed item title", link: "https://www.google.com", category: ["category1", "category2"], pubDate: "", creator: "", content: "")
}
