//
//  FeedDetailsView.swift
//  RSSFeed
//
//  Created by Admin on 14/09/23.
//

import SwiftUI
import WebKit

struct FeedDetailsView: View {
    @StateObject var feedDetailsViewModel: FeedDetailsViewModel
    
    var body: some View {
        VStack {
            FeedListHeaderView(item: feedDetailsViewModel.item)
                .padding(.horizontal, 16)
            
            HTMLStringView(htmlContent: feedDetailsViewModel.item.content)
                .padding(.vertical, 8)
            
        }
        .navigationBarItems(trailing: VStack {
            Button {
                feedDetailsViewModel.handleBookmark()
            } label: {
                Image(systemName: feedDetailsViewModel.isBookmarked ? "bookmark.fill" : "bookmark")
            }
        })
        .onAppear() {
            feedDetailsViewModel.checkAndUpdateBookmark()
        }
    }
}

struct FeedDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FeedDetailsView(feedDetailsViewModel: FeedDetailsViewModel(item: DataUtil.feedItem))
    }
}

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}

