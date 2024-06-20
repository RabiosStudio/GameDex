//
//  StorageArea.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 20/06/2024.
//

import Foundation
import CoreData

public class StorageArea: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<StorageArea> {
        return NSFetchRequest<StorageArea>(entityName: "StorageArea")
    }
    
    @NSManaged public var name: String
}
