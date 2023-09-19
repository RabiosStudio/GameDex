//
//  Date+Extension.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 19/09/2023.
//

import Foundation

extension Date {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
}
