//
//  FeedListView.swift
//  RSSFeed
//
//  Created by Admin on 14/09/23.
//

import SwiftUI

struct FeedListView: View {
    @StateObject var feedViewModel = FeedViewModel()
    
    var body: some View {
        VStack {
            List {
                FeedListRowView()
            }
            
        }.onAppear() {
            feedViewModel.getFeed()
        }
    }
}

struct FeedListView_Previews: PreviewProvider {
    static var previews: some View {
        FeedListView()
    }
}
