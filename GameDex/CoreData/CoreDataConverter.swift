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
        platformCollected.imageUrl = platform.imageUrl
                
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
        gameCollected.imageUrl = gameDetails.game.imageUrl
        gameCollected.rating = Int16(gameDetails.rating ?? .zero)
        gameCollected.gameRegion = gameDetails.gameRegion?.rawValue
        gameCollected.gameCondition = gameDetails.gameCondition?.rawValue
        gameCollected.gameCompleteness = gameDetails.gameCompleteness?.rawValue
        gameCollected.acquisitionYear = gameDetails.acquisitionYear
        gameCollected.gameID = gameDetails.game.id
        gameCollected.releaseDate = gameDetails.game.releaseDate
        gameCollected.lastUpdated = gameDetails.lastUpdated
    
        return gameCollected
    }
    
    static func convert(platformCollected: PlatformCollected) -> Platform {
        let savedGames = platformCollected.gamesArray.map { aGame in
            var gameCondition: GameCondition?
            if let gameConditionText = aGame.gameCondition {
                gameCondition = GameCondition(rawValue: gameConditionText)
            }
            
            var gameCompleteness: GameCompleteness?
            if let gameCompletenessText = aGame.gameCompleteness {
                gameCompleteness = GameCompleteness(rawValue: gameCompletenessText)
            }
            
            var gameRegion: GameRegion?
            if let gameRegionText = aGame.gameRegion {
                gameRegion = GameRegion(rawValue: gameRegionText)
            }
            
            return SavedGame(
                game: Game(
                    title: aGame.title,
                    description: aGame.summary,
                    id: aGame.gameID,
                    platformId: Int(aGame.platform.id),
                    imageUrl: aGame.imageUrl,
                    releaseDate: aGame.releaseDate
                ),
                acquisitionYear: aGame.acquisitionYear,
                gameCondition: gameCondition,
                gameCompleteness: gameCompleteness,
                gameRegion: gameRegion,
                storageArea: aGame.storageArea,
                rating: Int(aGame.rating),
                notes: aGame.notes,
                lastUpdated: aGame.lastUpdated, 
                isPhysical: aGame.isPhysical
            )
        }
        let platform = Platform(
            title: platformCollected.title,
            id: Int(platformCollected.id), 
            imageUrl: platformCollected.imageUrl,
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
