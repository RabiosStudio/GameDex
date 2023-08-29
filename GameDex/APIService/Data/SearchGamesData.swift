//
//  SearchGamesData.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import Foundation

// MARK: - SearchGamesData
struct SearchGamesData: Codable {
    let games: [RemoteGame]
}

// MARK: - Game
struct RemoteGame: Codable {
    let alternateTitles: [AlternateTitle]
    let description: String?
    let gameID: Int
    let genres: [Genre]
    let mobyScore: Double?
    let mobyURL: String
    let numVotes: Int
    let officialURL: String?
    let platforms: [RealeasedOnPlatform]
    let sampleCover: Sample?
    let sampleScreenshots: [Sample]
    let title: String

    enum CodingKeys: String, CodingKey {
        case alternateTitles = "alternate_titles"
        case description
        case gameID = "game_id"
        case genres
        case mobyScore = "moby_score"
        case mobyURL = "moby_url"
        case numVotes = "num_votes"
        case officialURL = "official_url"
        case platforms
        case sampleCover = "sample_cover"
        case sampleScreenshots = "sample_screenshots"
        case title
    }
}

// MARK: - AlternateTitle
struct AlternateTitle: Codable {
    let description, title: String
}

// MARK: - Genre
struct Genre: Codable {
//    let genreCategory: GenreCategory?
//    let genreCategoryID: Int?
//    let genreID: Int?
    let genreName: String

    enum CodingKeys: String, CodingKey {
//        case genreCategory = "genre_category"
//        case genreCategoryID = "genre_category_id"
//        case genreID = "genre_id"
        case genreName = "genre_name"
    }
}

enum GenreCategory: String, Codable {
    case artStyle = "Art Style"
    case basicGenres = "Basic Genres"
    case educationalCategories = "Educational Categories"
    case gameplay = "Gameplay"
    case interfaceControl = "Interface/Control"
    case narrativeThemeTopic = "Narrative Theme/Topic"
    case otherAttributes = "Other Attributes"
    case pacing = "Pacing"
    case perspective = "Perspective"
    case setting = "Setting"
    case sportsThemes = "Sports Themes"
    case vehicularThemes = "Vehicular Themes"
    case visualPresentation = "Visual Presentation"
}

// MARK: - Platform
struct RealeasedOnPlatform: Codable {
    let firstReleaseDate: String
    let platformID: Int
    let platformName: String

    enum CodingKeys: String, CodingKey {
        case firstReleaseDate = "first_release_date"
        case platformID = "platform_id"
        case platformName = "platform_name"
    }
}

// MARK: - Sample
struct Sample: Codable {
    let height: Int
    let image: String
    let platforms: [String]?
    let thumbnailImage: String
    let width: Int
    let caption: String?

    enum CodingKeys: String, CodingKey {
        case height, image, platforms
        case thumbnailImage = "thumbnail_image"
        case width, caption
    }
}
