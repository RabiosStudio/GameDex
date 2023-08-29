//
//  SearchPlatformsData.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 24/08/2023.
//

import Foundation

// MARK: - SearchPlatformsData
struct SearchPlatformsData: Codable {
    let error: String
    let offset: Int
    let numberOfPageResults: Int
    let numberOfTotalResults: Int
    let statusCode: Int
    let results: [PlatformData]
    let version: String
    
    enum CodingKeys: String, CodingKey {
        case error
        case offset
        case numberOfPageResults = "number_of_page_results"
        case numberOfTotalResults = "number_of_total_results"
        case statusCode = "status_code"
        case results
        case version
    }
}

// MARK: - PlatformData
struct PlatformData: Codable {
    let id: Int
    let name: String
}
