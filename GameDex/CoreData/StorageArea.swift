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
    @NSManaged public var games: NSSet?
    
    public var gamesArray: [GameCollected] {
        let set = games as? Set<GameCollected> ?? []
        return Array(set)
    }
}

// MARK: Generated accessors for games
extension StorageArea {

    @objc(addGamesObject:)
    @NSManaged public func addToGames(_ value: GameCollected)

    @objc(removeGamesObject:)
    @NSManaged public func removeFromGames(_ value: GameCollected)

    @objc(addGames:)
    @NSManaged public func addToGames(_ values: NSSet)

    @objc(removeGames:)
    @NSManaged public func removeFromGames(_ values: NSSet)

}
