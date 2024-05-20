//
//  String+Extension.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 14/05/2024.
//

import Foundation

extension String {
    func removeWhiteSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
}
