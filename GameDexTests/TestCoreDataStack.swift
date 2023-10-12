//
//  TestCoreDataStack.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 11/10/2023.
//

import Foundation
import CoreData
@testable import GameDex

class TestCoreDataStack: CoreDataStack {
    
    override init() {
        super.init()
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(
            name: CoreDataStack.persistentContainerName,
            managedObjectModel: CoreDataStack.model)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        persistentContainer = container
    }
}
