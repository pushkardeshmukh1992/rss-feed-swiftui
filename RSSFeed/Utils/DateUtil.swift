//
//  DateUtil.swift
//  RSSFeed
//
//  Created by Admin on 15/09/23.
//

import Foundation

enum DateUtil {
    static func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, h:mm a"
        return dateFormatter.string(from: date)
    }
}
