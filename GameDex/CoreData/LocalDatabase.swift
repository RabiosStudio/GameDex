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
    
    func add(newEntity: SavedGame, callback: @escaping (DatabaseError?) -> ()) {
        // Check if the item is already in database
        let request: NSFetchRequest<PlatformCollected> = PlatformCollected.fetchRequest()
        
        do {
            let platforms = try coreDataStack.viewContext.fetch(request)
            for platform in platforms {
                if platform.gamesArray.contains(
                    where: { aGame in
                        aGame.title == newEntity.game.title
                    }
                ) {
                    callback(DatabaseError.itemAlreadySaved)
                    return
                }
            }
        } catch {
            callback(DatabaseError.fetchError)
        }
        
        // Save the object in the following context
        _ = DataConverter.convert(gameDetails: newEntity, context: managedObjectContext)
        // Save the context
        coreDataStack.saveContext(managedObjectContext) { error in
            if error != nil {
                callback(DatabaseError.saveError)
            }
            callback(nil)
        }
    }
    
    func fetchAll() -> Result<[PlatformCollected], DatabaseError> {
        let request: NSFetchRequest<PlatformCollected> = PlatformCollected.fetchRequest()
        var fetchedPlatforms = [PlatformCollected]()
        
        do {
            let results = try managedObjectContext.fetch(request)
            return .success(results)
        } catch {
            return .failure(DatabaseError.fetchError)
        }
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
