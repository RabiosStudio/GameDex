//
//  DataConverter.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation
import CoreData

enum DataConverter {
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
                platform: platform.title,
                imageURL: remoteGame.image.mediumURL
            )
        }
    }
    
    static func convert(gameDetails: SavedGame, context: NSManagedObjectContext) -> GameCollected {
        let gameCollected = GameCollected(context: context)
        gameCollected.title = gameDetails.game.title
        gameCollected.summary = gameDetails.game.description
        gameCollected.storageArea = gameDetails.storageArea ?? ""
        gameCollected.notes = gameDetails.notes ?? ""
        gameCollected.imageURL = gameDetails.game.imageURL
        gameCollected.rating = Int16(gameDetails.rating ?? .zero)
        gameCollected.gameRegion = gameDetails.gameRegion ?? ""
        gameCollected.gameCondition = gameDetails.gameCondition ?? ""
        gameCollected.gameCompleteness = gameDetails.gameCompleteness ?? ""
        gameCollected.acquisitionYear = gameDetails.acquisitionYear ?? ""
        gameCollected.stringID = gameDetails.game.id
        gameCollected.platform = gameDetails.game.platform
        return gameCollected
    }
    
    // from CoreData "GameCollected" to SavedGame
    static func convert(gamesCollected: [GameCollected]) -> [SavedGame] {
        return gamesCollected.map { gameCollected in
            return SavedGame(
                game: Game(
                    title: gameCollected.title,
                    description: gameCollected.summary,
                    id: gameCollected.stringID,
                    platform: gameCollected.platform,
                    imageURL: gameCollected.imageURL
                ),
                acquisitionYear: gameCollected.acquisitionYear,
                gameCondition: gameCollected.gameCondition,
                gameCompleteness: gameCollected.gameCompleteness,
                gameRegion: gameCollected.gameRegion,
                storageArea: gameCollected.storageArea,
                rating: Int(gameCollected.rating),
                notes: gameCollected.notes
            )
        }
    }
}
