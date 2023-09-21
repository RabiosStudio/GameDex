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
        let localPlatformResult = getPlatform(platformId: Int16(platform.id))
        switch localPlatformResult {
        case let .success(platformResult):
            guard let platformResult else {
                let newLocalPlatform = DataConverter.convert(
                    platform: platform,
                    context: managedObjectContext
                )
                newLocalPlatform.addToGames(
                    DataConverter.convert(
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
                    DataConverter.convert(
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
    
    func getPlatform(platformId: Int16) -> Result<PlatformCollected?, DatabaseError> {
        let fetchRequest: NSFetchRequest<PlatformCollected>
        fetchRequest = PlatformCollected.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id == %d", platformId
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
    
    func replace(savedGame: SavedGame, callback: @escaping (DatabaseError?) -> ()) {
        // Remove the object in the following context
        let request: NSFetchRequest<GameCollected> = GameCollected.fetchRequest()
        
        // We first fetch the data stored, then we compare our recipe to it, so that we remove only this specific object
        if let games = try? coreDataStack.viewContext.fetch(request) {
            guard let index = games.firstIndex(where: { aGame in
                aGame.title == savedGame.game.title &&
                aGame.summary == savedGame.game.description &&
                aGame.platform.id == savedGame.game.platform.id
            }) else {
                callback(DatabaseError.fetchError)
                return
            }
            let gameToReplace = games[index]
            coreDataStack.viewContext.delete(gameToReplace)
            
            self.add(newEntity: savedGame) { error in
                if error != nil {
                    callback(DatabaseError.fetchError)
                } else {
                    callback(nil)
                }
            }
        }
    }
    
    func remove(savedGame: SavedGame, callback: @escaping (DatabaseError?) -> ()) {
        // Remove the object in the following context
        let request: NSFetchRequest<GameCollected> = GameCollected.fetchRequest()
        
        // We first fetch the data stored, then we compare our recipe to it, so that we remove only this specific object
        if let games = try? coreDataStack.viewContext.fetch(request) {
            guard let index = games.firstIndex(where: { aGame in
                aGame.title == savedGame.game.title &&
                aGame.summary == savedGame.game.description &&
                aGame.platform.id == savedGame.game.platform.id
            }) else {
                callback(DatabaseError.removeError)
                return
            }
            let gameToRemove = games[index]
            coreDataStack.viewContext.delete(gameToRemove)
            // Save the context
            coreDataStack.saveContext(managedObjectContext) { error in
                if error != nil {
                    callback(DatabaseError.removeError)
                } else {
                    callback(nil)
                }
            }
            callback(nil)
        }
        callback(DatabaseError.removeError)
    }
}
