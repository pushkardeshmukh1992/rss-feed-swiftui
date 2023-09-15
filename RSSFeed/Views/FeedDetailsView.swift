//
//  FeedDetailsView.swift
//  RSSFeed
//
//  Created by Admin on 14/09/23.
//

import SwiftUI
import WebKit

struct FeedDetailsView: View {
    var item: FeedItem
    
    var body: some View {
        Text(item.title)
    }
}

struct FeedDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FeedDetailsView(item: DataUtil.feedItem)
    }
}

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
