//
//  FeedListView.swift
//  RSSFeed
//
//  Created by Admin on 14/09/23.
//

import SwiftUI

struct FeedListView: View {
    var body: some View {
        VStack {
            List {
                FeedListRowView()
            }
            
        }
    }
}

struct FeedListView_Previews: PreviewProvider {
    static var previews: some View {
        FeedListView()
    }
}
