//
//  DataUtil.swift
//  RSSFeed
//
//  Created by Admin on 14/09/23.
//

import Foundation

enum DataUtil {
    static let defaultRSS = RSS(channel: Channel(title: "Channel", description: "Descriptions", link: "htts://www.google.com", image: ChannelImage(url: "https://cdn-images-1.medium.com/v2/format:png/1*TGH72Nnw24QL3iV9IOm4VA.png", title: "Channel image title", link: "https://any-channel-image.com"), items: [
        DataUtil.feedItem
    ]))
    
    static let publication1 = Publication(id: "1",
                                          rss: DataUtil.defaultRSS,
                                          url: URL(string: "https://medium.com/feed/backchannel")!,
                                          title: "Backchannel Tech Publication",
                                          localImage: "backchannel-channel",
                                          active: true
                                        )
    
    static let publication2 = Publication(id: "2",
                                          rss: RSS(channel: Channel(title: "Channel", description: "Descriptions", link: "htts://www.google.com", image: ChannelImage(url: "https://cdn-images-1.medium.com/v2/format:png/1*TGH72Nnw24QL3iV9IOm4VA.png", title: "Channel image title", link: "https://any-channel-image.com"), items: [])),
                                          url: URL(string: "https://medium.com/feed/the-economist")!,
                                          title: "The Economist Publication",
                                          localImage: "economist-channel"
    )
    
    static let publication3 = Publication(id: "3",
                                          rss: RSS(channel: Channel(title: "Channel", description: "Descriptions", link: "htts://www.google.com", image: ChannelImage(url: "https://cdn-images-1.medium.com/v2/format:png/1*TGH72Nnw24QL3iV9IOm4VA.png", title: "Channel image title", link: "https://any-channel-image.com"), items: [])),
                                          url: URL(string: "https://medium.com/feed/matter")!,
                                          title: "Matter Publications",
                                          localImage: "matter-channel"
    )
    
    static let feedItem = FeedItem(title: "Feed item title", linkString: "https://www.google.com", category: ["category1", "category2", "category1", "category2", "category1", "category2", "category1", "category2"], pubDate: Date(), creator: "", content: """
        <figure><img alt="" src="https://cdn-images-1.medium.com/max/1024/1*kvUxCePPMcrCCdoSXTJYsg.jpeg" /></figure><h4>We’re now officially and totally integrated into Wired. But we won’t be gone."
        """)
    
    static let initialPublication = [DataUtil.publication1]
    static let allPublications = [DataUtil.publication1, DataUtil.publication2, DataUtil.publication3]
}
