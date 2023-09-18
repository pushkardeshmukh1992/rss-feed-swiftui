//
//  FeedItemsListView.swift
//  RSSFeed
//
//  Created by Admin on 17/09/23.
//

import SwiftUI

struct FeedItemsListView: View {
    
    @State var items = [FeedItem]()
        
    let service = BookmarkCacheService.getActiveService()
    
    var body: some View {
        NavigationView {
            ScrollView {
                if items.count == 0 {
                    Text("You don't have bookmarks yet. \n\n Bookmark articles for quick catch-up!")
                        .multilineTextAlignment(.center)
                        .padding(24)
                    
                } else {
                    ForEach(items) { item in
                        NavigationLink {
                            FeedDetailsView(feedDetailsViewModel: FeedDetailsViewModel(item: item, feedBookmarkService: service))
                                
                        } label: {
                            FeedListRowView(item: item)
                        }
                        .buttonStyle(.plain)
                    }
                }
                
            }
            .onAppear() {
                getCachedItems()
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle("Bookmarks", displayMode: .inline)
        }
    }
    
    func getCachedItems() {
        items = service.get()
    }
}

struct FeedItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        FeedItemsListView()
    }
}
