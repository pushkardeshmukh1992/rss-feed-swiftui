//
//  FeedViewModel.swift
//  RSSFeed
//
//  Created by Admin on 14/09/23.
//

import Foundation
import XMLCoder
import Combine

class FeedViewModel: ObservableObject {
    func getFeed() {
        guard let url = URL(string: "https://medium.com/feed/backchannel") else { return }
        
        let decoder = XMLDecoder()
        decoder.shouldProcessNamespaces = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data  {
                do {
                    let feed = try decoder.decode(RSS.self, from: data.dataMiddleware())
                    print(feed)
                } catch {
                    print(error)
                }

            }
        }.resume()
    }
}



