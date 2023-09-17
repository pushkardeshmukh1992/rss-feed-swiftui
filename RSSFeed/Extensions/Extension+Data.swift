//
//  Extension+Data.swift
//  RSSFeed
//
//  Created by Admin on 14/09/23.
//

import Foundation

extension Data {
    func dataMiddleware() -> Data? {
        let stringData = String(data: self, encoding: .utf8)?
            .replacingOccurrences(of: "<content:encoded>", with: "<description>", options: .regularExpression)
            .replacingOccurrences(of: "</content:encoded>", with: "</description>", options: .regularExpression)
        
        return stringData?.data(using: .utf8)
    }
}
