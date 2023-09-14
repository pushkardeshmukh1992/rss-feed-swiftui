//
//  FeedDetailsView.swift
//  RSSFeed
//
//  Created by Admin on 14/09/23.
//

import SwiftUI

struct FeedDetailsView: View {
    var item: FeedItem
    
    var body: some View {
        Text(item.title)
    }
}

struct FeedDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FeedDetailsView(item: DataUtil.feedItem)
    }
}
