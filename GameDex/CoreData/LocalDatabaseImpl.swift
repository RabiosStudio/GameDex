//
//  LocalDatabase.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 10/09/2023.
//

import Foundation
import CoreData

class LocalDatabaseImpl: LocalDatabase {
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    init(managedObjectContext: NSManagedObjectContext = CoreDataStack().viewContext, coreDataStack: CoreDataStack = CoreDataStack()) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
}

extension LocalDatabaseImpl {
    func add(
        newEntity: SavedGame,
        platform: Platform
    ) async -> DatabaseError? {
        let localPlatformResult = self.getPlatform(platformId: platform.id)
        switch localPlatformResult {
        case let .success(platformResult):
            guard let platformResult else {
                let newLocalPlatform = CoreDataConverter.convert(
                    platform: platform,
                    context: self.managedObjectContext
                )
                newLocalPlatform.addToGames(
                    CoreDataConverter.convert(
                        gameDetails: newEntity,
                        context: self.managedObjectContext
                    )
                )
                guard await self.coreDataStack.saveContext(self.managedObjectContext) == nil else {
                    return DatabaseError.saveError
                }
                return nil
            }
            if platformResult.gamesArray.contains(
                where: { aGame in
                    aGame.title == newEntity.game.title
                }
            ) {
                return DatabaseError.itemAlreadySaved
            } else {
                platformResult.addToGames(
                    CoreDataConverter.convert(
                        gameDetails: newEntity,
                        context: self.managedObjectContext
                    )
                )
                // Save the context
                guard await self.coreDataStack.saveContext(self.managedObjectContext) == nil else {
                    return DatabaseError.saveError
                }
                return nil
            }
        case .failure:
            return DatabaseError.fetchError
        }
    }
    
    func getPlatform(platformId: Int) -> Result<PlatformCollected?, DatabaseError> {
        let convertedPlatformID = Int16(platformId)
        let fetchRequest: NSFetchRequest<PlatformCollected>
        fetchRequest = PlatformCollected.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id == %d", convertedPlatformID
        )
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            guard let platformWithId = results.first else {
                return .success(nil)
            }
            return .success(platformWithId)
        } catch {
            return .failure(DatabaseError.fetchError)
        }
    }
    
    func fetchAllPlatforms() -> Result<[PlatformCollected], DatabaseError> {
        let request: NSFetchRequest<PlatformCollected> = PlatformCollected.fetchRequest()
        do {
            let results = try managedObjectContext.fetch(request)
            return .success(results)
        } catch {
            return .failure(DatabaseError.fetchError)
        }
    }
    
    func getGame(gameId: String) -> Result<GameCollected?, DatabaseError> {
        let fetchRequest: NSFetchRequest<GameCollected>
        fetchRequest = GameCollected.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "gameID == %@", gameId
        )
        
        do {
            let results = try self.managedObjectContext.fetch(fetchRequest)
            guard let gameWithId = results.first else {
                return .success(nil)
            }
            return .success(gameWithId)
        } catch {
            return .failure(DatabaseError.fetchError)
        }
    }
    
    func replace(savedGame: SavedGame) async -> DatabaseError? {
        let gameResult = getGame(gameId: savedGame.game.id)
        switch gameResult {
        case let .success(gameToReplace):
            guard let gameToReplace else {
                return DatabaseError.fetchError
            }
            gameToReplace.acquisitionYear = savedGame.acquisitionYear
            gameToReplace.gameCompleteness = savedGame.gameCompleteness?.rawValue
            gameToReplace.gameCondition = savedGame.gameCondition?.rawValue
            gameToReplace.gameRegion = savedGame.gameRegion?.rawValue
            gameToReplace.lastUpdated = savedGame.lastUpdated
            gameToReplace.notes = savedGame.notes
            gameToReplace.rating = Int16(savedGame.rating ?? .zero)
            gameToReplace.storageArea = savedGame.storageArea
            
            // Save the context
            guard await self.coreDataStack.saveContext(self.managedObjectContext) == nil else {
                return DatabaseError.saveError
            }
            return nil
        case let .failure(error):
            return error
        }
    }
    
    func remove(savedGame: SavedGame) async -> DatabaseError? {
        // Remove the object in the following context
        let gameResult = getGame(gameId: savedGame.game.id)
        
        switch gameResult {
        case .success(let gameToRemove):
            guard let gameToRemove else {
                return DatabaseError.removeError
            }
            // We also need to make sure that there are still other games in associated to the platform, otherwise we also need to delete the platform from database.
            let fetchedPlatform = self.getPlatform(platformId: Int(gameToRemove.platform.id))
            
            switch fetchedPlatform {
            case .success(let platformResult):
                guard let platformResult else {
                    return DatabaseError.removeError
                }
                // Delete game and save context
                platformResult.removeFromGames(gameToRemove)
                self.managedObjectContext.delete(gameToRemove)
                do {
                    try managedObjectContext.save()
                    
                    // if there are no more games associated to the platform, we delete it and we save the context.
                    if platformResult.gamesArray.isEmpty {
                        self.managedObjectContext.delete(platformResult)
                        try managedObjectContext.save()
                    }
                    return nil
                } catch {
                    return DatabaseError.removeError
                }
            case .failure(_):
                return DatabaseError.removeError
            }
            
        case .failure(_):
            return DatabaseError.removeError
        }
    }
    
    func removeAll() async -> DatabaseError? {
        let fetchPlatformsResult = self.fetchAllPlatforms()
        switch fetchPlatformsResult {
        case .success(let result):
            for item in result {
                managedObjectContext.delete(item)
            }
            do {
                try managedObjectContext.save()
                return nil
            } catch {
                return DatabaseError.removeError
            }
        case .failure:
            return DatabaseError.removeError
        }
    }
    
    func remove(platform: Platform) async -> DatabaseError? {
        // Remove the object in the following context
        let fetchedPlatformResult = self.getPlatform(platformId: platform.id)
        
        switch fetchedPlatformResult {
        case .success(let fetchedPlatform):
            guard let fetchedPlatform else {
                return DatabaseError.removeError
            }
            managedObjectContext.delete(fetchedPlatform)
            do {
                try managedObjectContext.save()
                return nil
            } catch {
                return DatabaseError.removeError
            }
        case .failure(_):
            return DatabaseError.removeError
        }
    }
}
