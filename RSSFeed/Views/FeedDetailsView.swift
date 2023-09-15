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
    @State var webViewHeight: CGFloat = 0
    
    var body: some View {
        VStack {
            FeedListRowView(item: item)
            HTMLStringView(htmlContent: item.content)
        }
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
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}

