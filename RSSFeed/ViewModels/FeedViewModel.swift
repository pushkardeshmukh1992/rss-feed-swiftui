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
    
    @Published var feed: RSS?
    @Published var loading: Bool = false
    
    init(publication: Publication) {
        self.publication = publication
    }
    
    func getFeed() {
        guard feed == nil else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
        
        let decoder = XMLDecoder()
        decoder.shouldProcessNamespaces = true
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        loading = true
        
        URLSession.shared.dataTask(with: publication.url) { [weak self] data, response, error in
            DispatchQueue.main.async { [weak self] in
                self?.loading = false
            }
            
            if let data = data  {
                do {
                    
                    let feed = try decoder.decode(RSS.self, from: data.dataMiddleware())
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.feed = feed
                    }
                    
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}



