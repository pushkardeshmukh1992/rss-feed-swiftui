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

protocol FeedServiceProtocol {
    func getFeed(url: URL, completion: @escaping( _ result: Result<RSS, APIError>) -> Void)
}

class FeedService: FeedServiceProtocol {
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
                let feed = try XMLDecoderUtil.getXMLDecoder().decode(RSS.self, from: data.dataMiddleware())
                completion(.success(feed))
                
            } catch {
                completion(.failure(.parseError))
            }
        }.resume()
    }
    
    
}
