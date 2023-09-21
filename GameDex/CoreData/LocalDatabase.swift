//
//  LocalDatabase.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 10/09/2023.
//

import Foundation
import CoreData

class LocalDatabase: Database {
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    init(managedObjectContext: NSManagedObjectContext = CoreDataStack().viewContext, coreDataStack: CoreDataStack = CoreDataStack()) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
}

extension LocalDatabase {
    func add(
        newEntity: SavedGame,
        platform: Platform,
        callback: @escaping (DatabaseError?) -> ()
    ) {
        let localPlatformResult = getPlatform(platformId: platform.id)
        switch localPlatformResult {
        case let .success(platformResult):
            guard let platformResult else {
                let newLocalPlatform = CoreDataConverter.convert(
                    platform: platform,
                    context: managedObjectContext
                )
                newLocalPlatform.addToGames(
                    CoreDataConverter.convert(
                        gameDetails: newEntity,
                        context: managedObjectContext
                    )
                )
                coreDataStack.saveContext(managedObjectContext) { error in
                    if error != nil {
                        callback(DatabaseError.saveError)
                    }
                    callback(nil)
                }
                return
            }
            if platformResult.gamesArray.contains(
                where: { aGame in
                    aGame.title == newEntity.game.title
                }
            ) {
                callback(DatabaseError.itemAlreadySaved)
                return
            } else {
                platformResult.addToGames(
                    CoreDataConverter.convert(
                        gameDetails: newEntity,
                        context: managedObjectContext
                    )
                )
                // Save the context
                coreDataStack.saveContext(managedObjectContext) { error in
                    if error != nil {
                        callback(DatabaseError.saveError)
                    }
                    callback(nil)
                }
            }
        case .failure(_):
            callback(.fetchError)
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
    
    func fetchGames(from platform: PlatformCollected) -> Result<[GameCollected], DatabaseError> {
        return .success(platform.gamesArray)
    }
    
    func getGame(gameId: String) -> Result<GameCollected?, DatabaseError> {
        let fetchRequest: NSFetchRequest<GameCollected>
        fetchRequest = GameCollected.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "gameID == %@", gameId
        )
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            guard let gameWithId = results.first else {
                return .success(nil)
            }
            return .success(gameWithId)
        } catch {
            return .failure(DatabaseError.fetchError)
        }
    }
    
    func replace(savedGame: SavedGame, callback: @escaping (DatabaseError?) -> ()) {
        // Remove the object in the following context
        let gameResult = getGame(gameId: savedGame.game.id)
        
        switch gameResult {
        case .success(let gameToReplace):
            guard let gameToReplace else {
                callback(DatabaseError.removeError)
                return
            }
            // Delete object
            managedObjectContext.delete(gameToReplace)
            
            let platform = CoreDataConverter.convert(platformCollected: gameToReplace.platform)
            
            // Add updated object
            self.add(newEntity: savedGame, platform: platform) { error in
                if error != nil {
                    callback(DatabaseError.fetchError)
                } else {
                    callback(nil)
                }
            }
        case .failure(_):
            callback(DatabaseError.replaceError)
            return
        }
    }
    
    func remove(savedGame: SavedGame, callback: @escaping (DatabaseError?) -> ()) {
        // Remove the object in the following context
        let gameResult = getGame(gameId: savedGame.game.id)
        
        switch gameResult {
        case .success(let gameToRemove):
            guard let gameToRemove else {
                callback(DatabaseError.removeError)
                return
            }
            // We also need to make sure that there are still other games in associated to the platform, otherwise we also need to delete the platform from database.
            let fetchedPlatform = self.getPlatform(platformId: Int(gameToRemove.platform.id))
            
            switch fetchedPlatform {
            case .success(let platformResult):
                guard let platformResult else {
                    callback(.removeError)
                    return
                }
                // Delete game and save context
                platformResult.removeFromGames(gameToRemove)
                managedObjectContext.delete(gameToRemove)
                do {
                    try managedObjectContext.save()
                    
                    // if there are no more games associated to the platform, we delete it and we save the context.
                    if platformResult.gamesArray.isEmpty {
                        managedObjectContext.delete(platformResult)
                        try managedObjectContext.save()
                    }
                    callback(nil)
                } catch {
                    callback(DatabaseError.removeError)
                    return
                }
            case .failure(_):
                callback(DatabaseError.removeError)
                return
            }
            
        case .failure(_):
            callback(DatabaseError.removeError)
            return
        }
    }
}
