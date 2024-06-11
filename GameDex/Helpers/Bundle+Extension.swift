//
//  Bundle+Extension.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/06/2024.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
}
