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
        VStack(alignment: .leading) {
            FeedListHeaderView(item: item)
            
            HStack {
                Text("VIEW ARTICLE")
                    .font(.footnote)
                
                Spacer()
                
                Button {
                    print("TODO open link")
                    
                } label: {
                    Image(systemName: "link")
                        .accentColor(.gray)
                }
            }
            .padding(.vertical, 4)
            
            Color.gray.frame(height: 2)
                .padding(.horizontal, -16)
                .padding(.top, 6)

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
}

struct FeedListRowView_Previews: PreviewProvider {
    static var previews: some View {
        FeedListRowView(item: DataUtil.feedItem)
    }
}


