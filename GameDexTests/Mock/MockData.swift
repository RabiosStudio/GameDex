//
//  MockData.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 14/09/2023.
//

import Foundation
@testable import GameDex
import CoreData
import FirebaseFirestore

enum MockData {
    static let platforms: [Platform] = [
        Platform(title: "Atari 2600", id: 28, imageUrl: "imageUrl", games: MockData.savedGames),
        Platform(title: "Dreamcast", id: 8, imageUrl: "imageUrl", games: MockData.savedGames),
        Platform(title: "Game Boy Color", id: 11, imageUrl: "imageUrl", games: MockData.savedGames),
        Platform(title: "Jaguar", id: 17, imageUrl: "imageUrl", games: MockData.savedGames),
        Platform(title: "SNES", id: 15, imageUrl: "imageUrl", games: MockData.savedGames)
    ]
    
    static let platform = Platform(title: "Game Boy Advance", id: 4, imageUrl: "imageUrl", games: MockData.savedGames)
    
    static let platformWithNoGames = Platform(title: "Game Boy Advance", id: 4, imageUrl: "imageUrl", games: nil)
    
    static let searchGamesResultEmpty = SearchGamesData(offset: .zero, statusCode: 1, results: [])
    
    static let searchGamesResultWithoutReleaseDate = SearchGamesData(
        offset: .zero, statusCode: 1,
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
                originalReleaseDate: nil,
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
                originalReleaseDate: nil,
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
        imageUrl: "imageURL",
        releaseDate: Date.now
    )
    
    static let games = [
        MockData.game,
        Game(title: "Title",
             description: "description",
             id: "id",
             platformId: 8,
             imageUrl: "imageURL",
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
            notes: nil,
            lastUpdated: Date()
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
            notes: nil,
            lastUpdated: Date()
        ),
        SavedGame(
            game: MockData.games[1],
            acquisitionYear: "2000",
            gameCondition: GameCondition.mint.value,
            gameCompleteness: GameCompleteness.loose.value,
            gameRegion: GameRegion.pal.rawValue,
            storageArea: "Living room",
            rating: 4,
            notes: nil,
            lastUpdated: Date()
        )
    ]
    
    static let platformsCollected: [PlatformCollected] = [
        CoreDataConverter.convert(
            platform: MockData.platforms[0],
            context: TestCoreDataStack().viewContext
        ),
        CoreDataConverter.convert(
            platform: MockData.platforms[1],
            context: TestCoreDataStack().viewContext
        ),
        CoreDataConverter.convert(
            platform: MockData.platforms[2],
            context: TestCoreDataStack().viewContext
        ),
        CoreDataConverter.convert(
            platform: MockData.platforms[3],
            context: TestCoreDataStack().viewContext
        ),
        CoreDataConverter.convert(
            platform: MockData.platforms[4],
            context: TestCoreDataStack().viewContext
        )
    ]
    
    static let platformCollected = CoreDataConverter.convert(platform: MockData.platform, context: CoreDataStack().viewContext)
    
    static let searchGameQuery = "Title"
    
    static let userId = "userId"
    
    static let email = "email"
    
    static let password = "password"
    
    static let firestoreEmptyData = [FirestoreData]()
    
    static let firestoreAPIPlatformsCorrectData = [
        FirestoreData(
            id: "Game Boy Advance",
            data: ["id": 4, "imageUrl": "imageUrl", "physical": true]
        ),
        FirestoreData(
            id: "Google Stadia",
            data: ["id": 175, "imageUrl": "imageUrl", "physical": false]
        ),
        FirestoreData(
            id: "Game Cube",
            data: ["id": 23, "imageUrl": "imageUrl", "physical": true]
        )
    ]
    static let firestoreAPIPlatformsIncorrectData = [
        FirestoreData(
            id: "Game Boy Advance",
            data: ["id": 4]
        ),
        FirestoreData(
            id: "Google Stadia",
            data: ["id": 175]
        ),
        FirestoreData(
            id: "Game Cube",
            data: ["id": 23]
        )
    ]
    static let firestoreAPIPlatformsResultConverted = [
        Platform(title: "Game Boy Advance", id: 4, imageUrl: "imageUrl", games: nil),
        Platform(title: "Game Cube", id: 23, imageUrl: "imageUrl", games: nil)
    ]
    
    static let timeStamp = Timestamp(seconds: 1255392000, nanoseconds: 0)
    static let dateValue = MockData.timeStamp.dateValue()
    
    static let firestorePlatformsCorrectData = [
        FirestoreData(
            id: "4",
            data: ["title": "title",
                  "imageUrl": "imageUrl"]
        )
    ]
    
    static let firestoreGamesCorrectData = [
        FirestoreData(
            id: "gameId",
            data: ["title": "gameTitle", "description": "gameDescription", "platform": 4, "imageUrl": "gameImageUrl", "lastUpdated": MockData.timeStamp, "releaseDate": MockData.timeStamp, "notes": "gameNotes", "gameCondition": "gameCondition", "gameCompleteness": "gameCompleteness", "gameRegion": "gameRegion", "storageArea": "gameStorageArea", "acquisitionYear": "gameAcquisitionYear", "rating": 5]
        ),
        FirestoreData(
            id: "gameId",
            data: ["title": "gameTitle", "description": "gameDescription", "platform": 4, "imageUrl": "gameImageUrl", "lastUpdated": MockData.timeStamp, "releaseDate": MockData.timeStamp, "notes": "gameNotes", "gameCondition": "gameCondition", "gameCompleteness": "gameCompleteness", "gameRegion": "gameRegion", "storageArea": "gameStorageArea", "acquisitionYear": "gameAcquisitionYear", "rating": 5]
        )
    ]
    
    static let firestoreGamesIncorrectData = [
        FirestoreData(id: "gameId", data: ["title": "gameTitle"]),
        FirestoreData(id: "gameId", data: ["title": "gameTitle"])
    ]
    
    static let firestoreGamesResultConverted = [
        SavedGame(
            game: Game(title: "gameTitle", description: "gameDescription", id: "gameId", platformId: 4, imageUrl: "gameImageUrl", releaseDate: MockData.dateValue),
            acquisitionYear: "gameAcquisitionYear",
            gameCondition: "gameCondition",
            gameCompleteness: "gameCompleteness",
            gameRegion: "gameRegion",
            storageArea: "gameStorageArea",
            rating: 5,
            notes: "gameNotes",
            lastUpdated: MockData.dateValue
        ),
        SavedGame(
            game: Game(title: "gameTitle", description: "gameDescription", id: "gameId", platformId: 4, imageUrl: "gameImageUrl", releaseDate: MockData.dateValue),
            acquisitionYear: "gameAcquisitionYear",
            gameCondition: "gameCondition",
            gameCompleteness: "gameCompleteness",
            gameRegion: "gameRegion",
            storageArea: "gameStorageArea",
            rating: 5,
            notes: "gameNotes",
            lastUpdated: MockData.dateValue
        )
    ]
    
    static let firestoreCorrectApiKey = FirestoreData(id: "key", data: ["key": "apiKey"])
    static let firestoreIncorrectApiKey = FirestoreData(id: "key", data: ["wrongKeyAttributes": "apiKey"])
    
    static let userPlatformsPath = "users/userId/platforms"
    static let userGamesPath = "users/userId/platforms/4/games"
    static let userPath = "users"
}
