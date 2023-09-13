//
//  CoreDataStack.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 13/09/2023.
//

import Foundation
import CoreData

// tuto: https://www.kodeco.com/11349416-unit-testing-core-data-in-ios

class CoreDataStack {
    static let persistentContainerName = "GameDex"
    static let sharedInstance = CoreDataStack()
    
    static let model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: persistentContainerName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    init() {}
    
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
    
    func newDerivedContext() -> NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        return context
    }
    
    func saveContext(_ context: NSManagedObjectContext, callback: @escaping (Error?) -> ()) {
        if context != viewContext {
            saveDerivedContext(context, callback: { error in
                if let error {
                    callback(error)
                } else {
                    callback(nil)
                }
            })
            return
        }
        
        context.perform {
            do {
                try context.save()
                callback(nil)
            } catch let error as NSError {
                callback(error)
            }
        }
    }
    
    func saveDerivedContext(_ context: NSManagedObjectContext, callback: @escaping (Error?) -> ()) {
        context.perform {
            do {
                try context.save()
                callback(nil)
            } catch let error as NSError {
                callback(error)
            }
            self.saveContext(self.viewContext, callback: { error in
                if let error {
                    callback(error)
                } else {
                    callback(nil)
                }
            })
        }
    }
}
