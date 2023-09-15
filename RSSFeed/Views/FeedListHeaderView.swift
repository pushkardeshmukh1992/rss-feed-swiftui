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
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(item.category, id: \.self) { category in
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color(ColorUtil.PrimaryLightBlackDarkWhite))
                            
                            Text(category.uppercased())
                                .padding(.horizontal, 8)
                                .font(.system(.caption))
                                .fontWeight(.bold)
                                .foregroundColor(Color(ColorUtil.PrimaryLightWhiteDarkBlack))
                            
                        }
                        .frame(height: 32)
                        
                        
                    }
                }
                
            }
            
            HStack {
                Text(item.creator)
                Text("• \(DateUtil.formatDate(date: item.pubDate))")
                    .font(.footnote)
                    .foregroundColor(Color(uiColor: UIColor.lightGray))
            }

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

struct FeedListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        FeedListHeaderView(item: DataUtil.feedItem)
    }
}
