//
//  LocalDatabase.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 10/09/2023.
//

import Foundation
import CoreData

// sourcery: AutoMockable
protocol Database {
    func add(newEntity: SavedGame, callback: @escaping (DatabaseError?) -> ())
    func fetchAll() -> Result<[GameCollected], DatabaseError>
}

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
    
    func fetchAll() -> Result<[GameCollected], DatabaseError> {
        let request: NSFetchRequest<GameCollected> = GameCollected.fetchRequest()
        
        do {
            let results = try managedObjectContext.fetch(request)
            return .success(results)
        } catch {
            return .failure(DatabaseError.fetchError)
        }
    }
}
