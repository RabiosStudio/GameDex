//
//  SearchGamesData.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import Foundation

// MARK: - SearchGamesData
struct SearchGamesData: Codable {
    let offset: Int
    let statusCode: Int
    let results: [GameData]
}

// MARK: - GameData
struct GameData: Codable {
    let deck: String
    let guid: String
    let image: Image
    let imageTags: [ImageTag]
    let name: String
    let originalReleaseDate: Date?
    let platforms: [PlatformInfo]
    let siteDetailUrl: String
}

// MARK: - Image
struct Image: Codable {
    let mediumUrl: String
    let screenUrl: String
    let imageTags: String
}

// MARK: - ImageTag
struct ImageTag: Codable {
    let apiDetailUrl: String
    let name: String
    let total: Int
}

// MARK: - Platform
struct PlatformInfo: Codable {
    let id: Int
    let name: String
    let abbreviation: String
}
