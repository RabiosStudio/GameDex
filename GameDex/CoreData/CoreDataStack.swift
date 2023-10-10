//
//  CoreDataStack.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 13/09/2023.
//

import Foundation
import CoreData

class CoreDataStack {
    static let persistentContainerName = "GameDex"
    
    static let model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: persistentContainerName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataStack.persistentContainerName, managedObjectModel: CoreDataStack.model)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo) for: \(storeDescription.description)")
            }
        }
        return container
    }()
    
    func saveContext() async -> DatabaseError? {
        if let error = await self.saveContext(self.viewContext) {
            return DatabaseError.saveError
        } else {
            return nil
        }
    }
    
    func saveContext(_ context: NSManagedObjectContext) async -> DatabaseError? {
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        do {
            try context.performAndWait {
                try context.save()
            }
        } catch {
            return DatabaseError.saveError
        }
        return nil
    }
}
