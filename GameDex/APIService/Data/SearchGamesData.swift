//
//  SearchGamesData.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import Foundation

// MARK: - SearchGamesData
struct SearchGamesData: Codable {
    let error: String
    let offset: Int
    let statusCode: Int
    let results: [GameData]
    
    enum CodingKeys: String, CodingKey {
        case error
        case offset
        case statusCode = "status_code"
        case results
    }
}

// MARK: - GameData
struct GameData: Codable {
    let deck: String
    let guid: String
    let image: Image
    let imageTags: [ImageTag]
    let name: String
    let originalReleaseDate: String
    let platforms: [PlatformInfo]
    let siteDetailURL: String
    
    enum CodingKeys: String, CodingKey {
        case deck
        case guid
        case image
        case imageTags = "image_tags"
        case name
        case originalReleaseDate = "original_release_date"
        case platforms
        case siteDetailURL = "site_detail_url"
    }
}

// MARK: - Image
struct Image: Codable {
    let mediumURL: String
    let screenURL: String
    let smallURL: String
    let thumbURL: String
    let originalURL: String
    let imageTags: String
    
    enum CodingKeys: String, CodingKey {
        case mediumURL = "medium_url"
        case screenURL = "screen_url"
        case smallURL = "small_url"
        case thumbURL = "thumb_url"
        case originalURL = "original_url"
        case imageTags = "image_tags"
    }
}

// MARK: - ImageTag
struct ImageTag: Codable {
    let apiDetailURL: String
    let name: String
    let total: Int
    
    enum CodingKeys: String, CodingKey {
        case apiDetailURL = "api_detail_url"
        case name
        case total
    }
}

// MARK: - Platform
struct PlatformInfo: Codable {
    let id: Int
    let name: String
    let abbreviation: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case abbreviation
    }
}
