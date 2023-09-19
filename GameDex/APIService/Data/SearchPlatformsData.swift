//
//  SearchPlatformsData.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 24/08/2023.
//

import Foundation

// MARK: - SearchPlatformsData
struct SearchPlatformsData: Codable {
    let offset: Int
    let numberOfPageResults: Int
    let numberOfTotalResults: Int
    let statusCode: Int
    let results: [PlatformData]
}

// MARK: - PlatformData
struct PlatformData: Codable {
    let id: Int
    let name: String
}
