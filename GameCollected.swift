//
//  GameCollected.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 20/09/2023.
//
//

import Foundation
import CoreData

public class GameCollected: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameCollected> {
        return NSFetchRequest<GameCollected>(entityName: "GameCollected")
    }

    @NSManaged public var acquisitionYear: String?
    @NSManaged public var gameCompleteness: String?
    @NSManaged public var gameCondition: String?
    @NSManaged public var gameID: String
    @NSManaged public var gameRegion: String?
    @NSManaged public var imageURL: String
    @NSManaged public var notes: String?
    @NSManaged public var rating: Int16
    @NSManaged public var releaseDate: Date?
    @NSManaged public var storageArea: String?
    @NSManaged public var summary: String
    @NSManaged public var title: String
    @NSManaged public var lastUpdated: Date
    @NSManaged public var platform: PlatformCollected
}
