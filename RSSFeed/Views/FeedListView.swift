//
//  FeedListView.swift
//  RSSFeed
//
//  Created by Admin on 14/09/23.
//

import SwiftUI

struct FeedListView: View {
    @StateObject var feedViewModel: FeedViewModel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(feedViewModel.feed?.channel.title ?? "Heading")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(feedViewModel.feed?.channel.description ?? "Subheading")
                    .font(.subheadline)
            }
            .padding(.horizontal, 16)
            
            List {
                ForEach(feedViewModel.feed?.channel.items ?? []) { item in
                    FeedListRowView(item: item)
                }
            }
            
        }.onAppear() {
            feedViewModel.getFeed()
        }
    }
}

struct FeedListView_Previews: PreviewProvider {
    static var previews: some View {
        FeedListView(feedViewModel: FeedViewModel(publication: DataUtil.publication1))
    }
}
