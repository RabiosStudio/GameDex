//
//  DataConverter.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation
import CoreData

enum DataConverter {
    
    // MARK: API data to Local data
    
    static func convert(remotePlatforms: [PlatformData]) -> [Platform] {
        return remotePlatforms.map { remotePlatform in
            return Platform(
                title: remotePlatform.name,
                id: remotePlatform.id
            )
        }
    }
    
    static func convert(remoteGames: [GameData], platform: Platform) -> [Game] {
        return remoteGames.map { remoteGame in
            return Game(
                title: remoteGame.name,
                description: remoteGame.deck,
                id: remoteGame.guid,
                platform: platform,
                imageURL: remoteGame.image.mediumUrl,
                releaseDate: remoteGame.originalReleaseDate
            )
        }
    }
    
    // MARK: Local data to CoreData managed objects
    
    static func convert(gameDetails: SavedGame, context: NSManagedObjectContext) -> GameCollected {
        let platformCollected = PlatformCollected(context: context)
        platformCollected.id = Int16(gameDetails.game.platform.id)
        platformCollected.title = gameDetails.game.platform.title
        
        let gameCollected = GameCollected(context: context)
        gameCollected.title = gameDetails.game.title
        gameCollected.summary = gameDetails.game.description
        gameCollected.storageArea = gameDetails.storageArea
        gameCollected.notes = gameDetails.notes
        gameCollected.imageURL = gameDetails.game.imageURL
        gameCollected.rating = Int16(gameDetails.rating ?? .zero)
        gameCollected.gameRegion = gameDetails.gameRegion
        gameCollected.gameCondition = gameDetails.gameCondition
        gameCollected.gameCompleteness = gameDetails.gameCompleteness
        gameCollected.acquisitionYear = gameDetails.acquisitionYear
        gameCollected.gameID = gameDetails.game.id
        gameCollected.releaseDate = gameDetails.game.releaseDate
        platformCollected.addToGame(gameCollected)
        return gameCollected
    }
    
    static func convert(platformCollected: PlatformCollected) -> Platform {
        let platform = Platform(
            title: platformCollected.title,
            id: Int(platformCollected.id)
        )
        return platform
    }
    
    static func convert(platformCollected: [PlatformCollected]) -> [[SavedGame]] {
        return platformCollected.map { platformCollected in
            
            var savedGames: [SavedGame] = []
            
            for game in platformCollected.gamesArray {
                savedGames.append(
                    SavedGame(
                        game: Game(
                            title: game.title,
                            description: game.summary,
                            id: game.gameID,
                            platform: DataConverter.convert(platformCollected: platformCollected),
                            imageURL: game.imageURL,
                            releaseDate: game.releaseDate
                        ),
                        acquisitionYear: game.acquisitionYear,
                        gameCondition: game.gameCondition,
                        gameCompleteness: game.gameCompleteness,
                        gameRegion: game.gameRegion,
                        storageArea: game.storageArea,
                        rating: Int(game.rating),
                        notes: game.notes
                    )
                )
            }
            return savedGames
        }
    }
}
