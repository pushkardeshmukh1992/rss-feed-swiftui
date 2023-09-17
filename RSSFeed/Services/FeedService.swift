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

typealias FeedResult = Result<RSS, APIError>

protocol FeedServiceProtocol {
    func getFeed(url: URL, session: URLSession, completion: @escaping( _ result: FeedResult) -> Void)
}

extension FeedServiceProtocol {
    func getFeed(url: URL, session: URLSession = URLSession.shared, completion: @escaping( _ result: FeedResult) -> Void) {
        getFeed(url: url, session: session, completion: completion)
    }
}

class FeedService: FeedServiceProtocol {
    func getFeed(url: URL, session: URLSession = URLSession.shared, completion: @escaping( _ result: FeedResult) -> Void) {
        
        session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.httpError))
                return
            }
            
            guard let data = data, let tempData = data.dataMiddleware() else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                let feed = try XMLDecoderUtil.getXMLDecoder().decode(RSS.self, from: tempData)
                completion(.success(feed))
                
            } catch {
                completion(.failure(.parseError))
            }
        }.resume()
    }
    
    
}
