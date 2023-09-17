//
//  ContentView.swift
//  RSSFeed
//
//  Created by Admin on 14/09/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PublicationsListView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            FeedItemsListView()
                .tabItem {
                    Label("Bookmarks", systemImage: "bookmark")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
