//
//  PlatformSupportedNames.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 14/05/2024.
//

import Foundation
import CoreData

public class PlatformSupportedNames: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlatformSupportedNames> {
        return NSFetchRequest<PlatformSupportedNames>(entityName: "PlatformSupportedNames")
    }

    @NSManaged public var name: String
    @NSManaged public var platform: PlatformCollected
}
