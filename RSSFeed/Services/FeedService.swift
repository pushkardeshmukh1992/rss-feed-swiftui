//
//  FeedService.swift
//  RSSFeed
//
//  Created by Admin on 16/09/23.
//

import Foundation
import XMLCoder

enum APIError: Error {
    case httpError
    case dataError
    case parseError
}

class FeedService {
    func getFeed(url: URL, completion: @escaping( _ result: Result<RSS, APIError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.httpError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                let feed = try FeedService.getXMLDecoder().decode(RSS.self, from: data.dataMiddleware())
                completion(.success(feed))
                
            } catch {
                completion(.failure(.parseError))
            }
        }.resume()
    }
    
    static func getXMLDecoder() -> XMLDecoder {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
        
        let decoder = XMLDecoder()
        decoder.shouldProcessNamespaces = true
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
}
