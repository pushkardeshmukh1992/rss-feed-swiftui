//
//  XMLDecoderUtil.swift
//  RSSFeed
//
//  Created by Admin on 16/09/23.
//

import Foundation
import XMLCoder

enum XMLDecoderUtil {
    static func getXMLDecoder() -> XMLDecoder {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
        
        let decoder = XMLDecoder()
        decoder.shouldProcessNamespaces = true
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
}
