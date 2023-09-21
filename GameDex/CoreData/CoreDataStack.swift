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
            } // Load the PersistentStores. In the closure, we catch the error and description of the store.
        }
        return container
    }() // Using "lazy" tells the app to allocate memory for this property only when it's used. Smooth out memory usage over time.
    
    func saveContext(callback: @escaping (Error?) -> ()) {
        self.saveContext(viewContext, callback: { error in
            if let error {
                callback(error)
            } else {
                callback(nil)
            }
        })
    }

    func saveContext(_ context: NSManagedObjectContext, callback: @escaping (Error?) -> ()) {
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.perform {
            do {
                try context.save()
                callback(nil)
            } catch let error as NSError {
                callback(error)
            }
        }
    }
}
