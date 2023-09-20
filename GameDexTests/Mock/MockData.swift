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
    
    static let platform = Platform(title: "Game Boy Advance", id: 4)
    
    static let searchGamesData = SearchGamesData(
        offset: .zero,
        statusCode: 1,
        results: [
            GameData(
                deck: "description",
                guid: "id",
                image: Image(mediumUrl: "mediumSize",
                             screenUrl: "BigSize",
                             imageTags: "imageTags"),
                imageTags: [
                    ImageTag(
                        apiDetailUrl: "",
                        name: "",
                        total: 1
                    )
                ],
                name: "The Legend of Zelda: The Minish Cap",
                originalReleaseDate: Date.now,
                platforms: [
                    PlatformInfo(
                        id: 4,
                        name: "Game Boy Advance",
                        abbreviation: "GBA"
                    )
                ],
                siteDetailUrl: "url"),
            GameData(
                deck: "description",
                guid: "id",
                image: Image(mediumUrl: "mediumSize",
                             screenUrl: "BigSize",
                             imageTags: "imageTags"),
                imageTags: [
                    ImageTag(
                        apiDetailUrl: "",
                        name: "",
                        total: 1
                    )
                ],
                name: "The Legend of Zelda: A link to the past",
                originalReleaseDate: Date.now,
                platforms: [
                    PlatformInfo(
                        id: 4,
                        name: "Game Boy Advance",
                        abbreviation: "GBA"
                    )
                ],
                siteDetailUrl: "url")
        ]
    )
    
    static let game = Game(
        title: "The Legend of Zelda: The Minish Cap",
        description: "description",
        id: "id",
        platform: Platform(
            title: "Game Boy Advance",
            id: 4
        ),
        imageURL: "imageURL",
        releaseDate: Date.now
    )
    
    static let games = [
        Game(title: "The Legend of Zelda: The Minish Cap",
             description: "description",
             id: "id",
             platform: Platform(
                title: "Game Boy Advance",
                id: 4
             ),
             imageURL: "imageURL",
             releaseDate: Date.now
            ),
        Game(title: "The Legend of Zelda: A link to the past",
             description: "description",
             id: "id",
             platform: Platform(
                title: "Game Boy Advance",
                id: 4
             ),
             imageURL: "imageURL",
             releaseDate: Date.now
            )
    ]
    
    static let savedGame = SavedGame(
            game: MockData.games[0],
            acquisitionYear: "2005",
            gameCondition: GameCondition.good.value,
            gameCompleteness: GameCompleteness.complete.value,
            gameRegion: GameRegion.pal.rawValue,
            storageArea: "Living room",
            rating: 5,
            notes: nil
        )
    
    static let savedGames = [
        SavedGame(
            game: MockData.games[0],
            acquisitionYear: "2005",
            gameCondition: GameCondition.good.value,
            gameCompleteness: GameCompleteness.complete.value,
            gameRegion: GameRegion.pal.rawValue,
            storageArea: "Living room",
            rating: 5,
            notes: nil
        ),
        SavedGame(
            game: MockData.games[1],
            acquisitionYear: "2000",
            gameCondition: GameCondition.mint.value,
            gameCompleteness: GameCompleteness.loose.value,
            gameRegion: GameRegion.pal.rawValue,
            storageArea: "Living room",
            rating: 4,
            notes: nil
        )
    ]
    
    static let gamesCollected = [
        DataConverter.convert(
            gameDetails: MockData.savedGames[0],
            context: CoreDataStack().viewContext
        ),
        DataConverter.convert(
            gameDetails: MockData.savedGames[1],
            context: CoreDataStack().viewContext
        )
    ]
    
    static let searchGameQuery = "Zelda"
}
