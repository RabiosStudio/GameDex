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
    
    enum CodingKeys: String, CodingKey {
        case offset
        case numberOfPageResults = "number_of_page_results"
        case numberOfTotalResults = "number_of_total_results"
        case statusCode = "status_code"
        case results
    }
}

// MARK: - PlatformData
struct PlatformData: Codable {
    let id: Int
    let name: String
}
