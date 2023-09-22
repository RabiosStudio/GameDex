//
//  CoreDataConverter.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 21/09/2023.
//

import Foundation
import CoreData

enum CoreDataConverter {
    
    // MARK: - Data to local CoreData managed objects
    
    static func convert(platform: Platform, context: NSManagedObjectContext) -> PlatformCollected {
        let platformCollected = PlatformCollected(context: context)
        platformCollected.id = Int16(platform.id)
        platformCollected.title = platform.title
                
        guard let platformGames = platform.games else {
            return platformCollected
        }
        
        let gamesCollected = platformGames.map { aGame in
            let gameCollected = CoreDataConverter.convert(gameDetails: aGame, context: context)
            return gameCollected
        }
        
        platformCollected.games = NSSet(array: gamesCollected)
        return platformCollected
    }
    
    static func convert(
        gameDetails: SavedGame,
        context: NSManagedObjectContext
    ) -> GameCollected {
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
    
        return gameCollected
    }
    
    static func convert(platformCollected: PlatformCollected) -> Platform {
        let savedGames = platformCollected.gamesArray.map { aGame in
            SavedGame(
                game: Game(
                    title: aGame.title,
                    description: aGame.summary,
                    id: aGame.gameID,
                    platformId: Int(aGame.platform.id),
                    imageURL: aGame.imageURL,
                    releaseDate: aGame.releaseDate
                ),
                acquisitionYear: aGame.acquisitionYear,
                gameCondition: aGame.gameCondition,
                gameCompleteness: aGame.gameCompleteness,
                gameRegion: aGame.gameRegion,
                storageArea: aGame.storageArea,
                rating: Int(aGame.rating),
                notes: aGame.notes
            )
        }
        let platform = Platform(
            title: platformCollected.title,
            id: Int(platformCollected.id),
            games: savedGames
        )
        return platform
    }
    
    static func convert(platformsCollected: [PlatformCollected]) -> [Platform] {
        return platformsCollected.map { platformCollected in
            CoreDataConverter.convert(platformCollected: platformCollected)
        }
    }
}
