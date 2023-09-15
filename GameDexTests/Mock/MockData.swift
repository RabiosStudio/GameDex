//
//  MockData.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 14/09/2023.
//

import Foundation
@testable import GameDex

enum MockData {
    
    static let searchPlaformsData = SearchPlatformsData(
        offset: .zero,
        numberOfPageResults: 5,
        numberOfTotalResults: 5,
        statusCode: 1,
        results: [
            PlatformData(id: 28, name: "Atari 2600"),
            PlatformData(id: 8, name: "Dreamcast"),
            PlatformData(id: 11, name: "Game Boy Color"),
            PlatformData(id: 17, name: "Jaguar"),
            PlatformData(id: 15, name: "SNES")
        ])
    
    static let platforms: [Platform] = [
        Platform(title: "Atari 2600", id: 28),
        Platform(title: "Dreamcast", id: 8),
        Platform(title: "Game Boy Color", id: 11),
        Platform(title: "Jaguar", id: 17),
        Platform(title: "SNES", id: 15)
    ]
    
    static let game = Game(
        title: "The Legend of Zelda: The Minish Cap",
        description: "description",
        id: "id",
        platform: "Game Boy Advance",
        imageURL: "imageURL"
    )
    
    static let games = [
        Game(title: "The Legend of Zelda: The Minish Cap",
             description: "description",
             id: "id",
             platform: "Game Boy Advance",
             imageURL: "imageURL"),
        Game(title: "The Legend of Zelda: A link to the past",
             description: "description",
             id: "id",
             platform: "Game Boy Advance",
             imageURL: "imageURL")
        ]
    
    static let platform = Platform(title: "Game Boy Advance", id: 4)
    static let searchQuery = "Zelda"
    static let searchGamesData = SearchGamesData(
        offset: .zero,
        statusCode: 1,
        results: [
            GameData(
                deck: "description",
                guid: "id",
                image: Image(mediumURL: "mediumSize",
                             screenURL: "BigSize",
                             imageTags: "imageTags"),
                imageTags: [ImageTag(apiDetailURL: "", name: "", total: 1)],
                name: "The Legend of Zelda: The Minish Cap",
                originalReleaseDate: "releaseDate",
                platforms: [PlatformInfo(id: 4, name: "Game Boy Advance", abbreviation: "GBA")],
                siteDetailURL: "url"),
            GameData(
                deck: "description",
                guid: "id",
                image: Image(mediumURL: "mediumSize",
                             screenURL: "BigSize",
                             imageTags: "imageTags"),
                imageTags: [ImageTag(apiDetailURL: "", name: "", total: 1)],
                name: "The Legend of Zelda: A link to the past",
                originalReleaseDate: "releaseDate",
                platforms: [PlatformInfo(id: 4, name: "Game Boy Advance", abbreviation: "GBA")],
                siteDetailURL: "url")
        ]
    )
}
