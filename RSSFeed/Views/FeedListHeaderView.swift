//
//  FeedListHeaderView.swift
//  RSSFeed
//
//  Created by Admin on 15/09/23.
//

import SwiftUI

struct FeedListHeaderView: View {
    var item: FeedItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.title)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(item.category, id: \.self) { category in
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(.gray)
                            
                            Text(category.uppercased())
                                .padding(.horizontal, 8)
                                .font(.system(.caption))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                        }
                        .frame(height: 32)
                        
                        
                    }
                }
                
            }
            
            Text(item.pubDate)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

struct FeedListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        FeedListHeaderView(item: DataUtil.feedItem)
    }
}
