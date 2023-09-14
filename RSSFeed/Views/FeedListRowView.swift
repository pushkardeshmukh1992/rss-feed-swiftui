//
//  FeedListRowView.swift
//  RSSFeed
//
//  Created by Admin on 14/09/23.
//

import SwiftUI

struct FeedListRowView: View {
    var item: FeedItem
    
    var body: some View {
        Text(item.title)
    }
}

struct FeedListRowView_Previews: PreviewProvider {
    static var previews: some View {
        FeedListRowView(item: DataUtil.feedItem)
    }
}
