//
//  DateFormatter.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 19/09/2023.
//

import Foundation

extension DateFormatter {
    static let date: DateFormatter = {
        let formatter = DateFormatter(dateFormat: "yyyy-MM-dd")
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
