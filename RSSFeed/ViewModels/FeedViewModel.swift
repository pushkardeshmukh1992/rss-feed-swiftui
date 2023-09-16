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
    let publication: Publication
    
    let feedService: FeedServiceProtocol
    
    @Published var feed: RSS?
    @Published var loading: Bool = false
    
    init(publication: Publication, feedService: FeedServiceProtocol = FeedService()) {
        self.publication = publication
        self.feedService = feedService
    }
    
    func getFeed() {
        guard feed == nil else { return }
        
        loading = true
        
        feedService.getFeed(url: publication.url) { [weak self] result in
            DispatchQueue.main.async {
                self?.loading = false
                switch result {
                case .success(let feed):
                    self?.feed = feed
                case .failure(_):
                    print("handle error")
                }
            }
        }
    }
}



