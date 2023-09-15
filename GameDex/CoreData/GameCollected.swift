//
//  GameCollected.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 13/09/2023.
//

import Foundation
import CoreData

class GameCollected: NSManagedObject {
    
    @NSManaged var title: String
    @NSManaged var platformID: Int16
    @NSManaged var platformTitle: String
    @NSManaged var imageURL: String
    @NSManaged var summary: String
    @NSManaged var storageArea: String
    @NSManaged var rating: Int16
    @NSManaged var notes: String
    @NSManaged var acquisitionYear: String
    @NSManaged var gameCondition: String
    @NSManaged var gameCompleteness: String
    @NSManaged var gameRegion: String
    @NSManaged var gameID: String
    
    public static let entityName = "GameCollected"
    
    public class func fetchRequest() -> NSFetchRequest<GameCollected> {
        NSFetchRequest<GameCollected>(entityName: Self.entityName)
    }
}
