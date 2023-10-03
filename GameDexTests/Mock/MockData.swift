//
//  MockData.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 14/09/2023.
//

import Foundation
@testable import GameDex
import CoreData

enum MockData {
    static let platforms: [Platform] = [
        Platform(title: "Atari 2600", id: 28, games: MockData.savedGames),
        Platform(title: "Dreamcast", id: 8, games: MockData.savedGames),
        Platform(title: "Game Boy Color", id: 11, games: MockData.savedGames),
        Platform(title: "Jaguar", id: 17, games: MockData.savedGames),
        Platform(title: "SNES", id: 15, games: MockData.savedGames)
    ]
    
    static let platform = Platform(title: "Game Boy Advance", id: 4, games: MockData.savedGames)
    
    static let platformWithNoGames = Platform(title: "Game Boy Advance", id: 4, games: nil)
    
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
                name: "Title",
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
                name: "Title",
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
        title: "Title",
        description: "description",
        id: "id",
        platformId: 4,
        imageURL: "imageURL",
        releaseDate: Date.now
    )
    
    static let games = [
        MockData.game,
        Game(title: "Title",
             description: "description",
             id: "id",
             platformId: 8,
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
    
    static let platformsCollected: [PlatformCollected] = [
        CoreDataConverter.convert(
            platform: MockData.platform,
            context: CoreDataStack().viewContext
        ),
        CoreDataConverter.convert(
            platform: MockData.platform,
            context: CoreDataStack().viewContext
        )
    ]
    
    static let platformCollected = CoreDataConverter.convert(platform: MockData.platform, context: CoreDataStack().viewContext)
    
    static let searchGameQuery = "Title"
}
