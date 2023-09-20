//
//  PlatformCollected.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 20/09/2023.
//
//

import Foundation
import CoreData

public class PlatformCollected: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlatformCollected> {
        return NSFetchRequest<PlatformCollected>(entityName: "PlatformCollected")
    }

    @NSManaged public var id: Int16
    @NSManaged public var title: String
    @NSManaged public var game: NSSet?

    public var gamesArray: [GameCollected] {
        let set = game as? Set<GameCollected> ?? []
        
        return set.sorted {
            $0.title < $1.title
        }
    }
}

// MARK: Generated accessors for games
extension PlatformCollected {

    @objc(addGameObject:)
    @NSManaged public func addToGame(_ value: GameCollected)

    @objc(removeGameObject:)
    @NSManaged public func removeFromGame(_ value: GameCollected)

    @objc(addGame:)
    @NSManaged public func addToGame(_ values: NSSet)

    @objc(removeGame:)
    @NSManaged public func removeFromGame(_ values: NSSet)

}
