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
            if feedViewModel.loading {
                ProgressView()
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        AsyncImage(url: feedViewModel.feed?.channel.image.imageURL) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        
                        Text(feedViewModel.feed?.channel.title ?? "Heading")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text(feedViewModel.feed?.channel.description ?? "Subheading")
                            .font(.subheadline)
                    }
                    .padding(.horizontal, 16)
                    
                    ForEach(feedViewModel.feed?.channel.items ?? []) { item in
                        
                        NavigationLink {
                            FeedDetailsView(item: item)
                                
                        } label: {
                            FeedListRowView(item: item)
                        }
                        .buttonStyle(.plain)
                        
                        
                    }
                    .padding(.top, 16)
                   
                   
                }
            }
        }.task {
            feedViewModel.getFeed()
        }
    }
}

struct FeedListView_Previews: PreviewProvider {
    static var previews: some View {
        FeedListView(feedViewModel: FeedViewModel(publication: DataUtil.publication1))
    }
}
