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
                    aGame.title == newEntity.game.title && aGame.isPhysical == newEntity.isPhysical
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
    
    func getGame(savedGame: SavedGame) -> Result<GameCollected?, DatabaseError> {
        let fetchRequest: NSFetchRequest<GameCollected>
        fetchRequest = GameCollected.fetchRequest()
        
        let predicateGameID = NSPredicate(format: "gameID == %@", savedGame.game.id)
        let predicateGameFormat = NSPredicate(format: "isPhysical == %@", NSNumber(value: savedGame.isPhysical))
        let predicate = NSCompoundPredicate(type: .and, subpredicates: [predicateGameID, predicateGameFormat])

        fetchRequest.predicate = predicate
        
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
        let gameResult = self.getGame(savedGame: savedGame)
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
            gameToReplace.rating = Int16(savedGame.rating)
            gameToReplace.storageArea = savedGame.storageArea
            gameToReplace.isPhysical = savedGame.isPhysical
            
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
        let gameResult = getGame(savedGame: savedGame)
        
        switch gameResult {
        case let .success(gameToRemove):
            guard let gameToRemove else {
                return DatabaseError.removeError
            }
            // We also need to make sure that there are still other games in associated to the platform, otherwise we also need to delete the platform from database.
            let fetchedPlatform = self.getPlatform(platformId: Int(gameToRemove.platform.id))
            
            switch fetchedPlatform {
            case let .success(platformResult):
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
        case let .success(result):
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
        case let .success(fetchedPlatform):
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
    
    func add(storageArea: String) async -> DatabaseError? {
        let _ = CoreDataConverter.convert(storageAreaName: storageArea, context: self.managedObjectContext)
        guard await self.coreDataStack.saveContext(self.managedObjectContext) == nil else {
            return DatabaseError.saveError
        }
        return nil
    }
    
    func get(storageArea: String) -> Result<StorageArea?, DatabaseError> {
        let fetchRequest: NSFetchRequest<StorageArea>
        fetchRequest = StorageArea.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", storageArea)
        do {
            let results = try self.managedObjectContext.fetch(fetchRequest)
            guard let storageAreaName = results.first else {
                return .success(nil)
            }
            return .success(storageAreaName)
        } catch {
            return .failure(DatabaseError.fetchError)
        }
    }
    
    func fetchAllStorageAreas() -> Result<[String], DatabaseError> {
        let request: NSFetchRequest<StorageArea> = StorageArea.fetchRequest()
        do {
            let results = try managedObjectContext.fetch(request)
            var storageAreas: [String] = []
            for result in results {
                let storageArea = CoreDataConverter.convert(storageArea: result)
                storageAreas.append(storageArea)
            }
            return .success(storageAreas)
        } catch {
            return .failure(DatabaseError.fetchError)
        }
    }
    
    func replaceStorageArea(oldValue: String, newValue: String) async -> DatabaseError? {
        let storageAreaResult = self.get(storageArea: oldValue)
        switch storageAreaResult {
        case let .success(storageAreaToReplace):
            guard let storageAreaToReplace else {
                return DatabaseError.fetchError
            }
            storageAreaToReplace.name = newValue
            // Save the context
            guard await self.coreDataStack.saveContext(self.managedObjectContext) == nil else {
                return DatabaseError.saveError
            }
            return nil
        case let .failure(error):
            return error
        }
    }
    
    func getGamesStoredIn(storageArea: String) async -> Result<[GameCollected], DatabaseError> {
        let fetchRequest: NSFetchRequest<GameCollected>
        fetchRequest = GameCollected.fetchRequest()
        let predicate = NSPredicate(format: "storageArea == %@", storageArea)
        fetchRequest.predicate = predicate
        
        do {
            let results = try self.managedObjectContext.fetch(fetchRequest)
            return .success(results)
        } catch {
            return .failure(DatabaseError.fetchError)
        }
    }
    
    func remove(storageArea: String) async -> DatabaseError? {
        // Remove the object in the following context
        let storageAreaResult = self.get(storageArea: storageArea)
        
        switch storageAreaResult {
        case let .success(storageAreaToRemove):
            guard let storageAreaToRemove else {
                return nil
            }
            // Delete the object and save context
            self.managedObjectContext.delete(storageAreaToRemove)
            do {
                try managedObjectContext.save()
                
                // We need to remove the storage area from all associated games stored in CoreData
                let fetchedGamesResult = await self.getGamesStoredIn(storageArea: storageArea)
                switch fetchedGamesResult {
                case let .success(gamesResults):
                    guard !gamesResults.isEmpty else {
                        return nil
                    }
                    for game in gamesResults {
                        game.storageArea = nil
                        // Save the context
                        guard await self.coreDataStack.saveContext(self.managedObjectContext) == nil else {
                            return DatabaseError.saveError
                        }
                        return nil
                    }
                case let .failure(error):
                    return error
                }
                return nil
            } catch {
                return DatabaseError.removeError
            }
        case .failure:
            return DatabaseError.removeError
        }
    }
}
