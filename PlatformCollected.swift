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
    @NSManaged public var imageUrl: String
    @NSManaged public var games: NSSet?
    @NSManaged public var supportedNames: NSSet

    public var gamesArray: [GameCollected] {
        let set = games as? Set<GameCollected> ?? []
        
        return set.sorted {
            $0.title < $1.title
        }
    }
    
    public var supportedNamesArray: [PlatformSupportedNames] {
        let set = supportedNames as? Set<PlatformSupportedNames> ?? []
        return set.sorted {
            $0.name < $1.name
        }
    }
}

// MARK: Generated accessors for games
extension PlatformCollected {

    @objc(addGamesObject:)
    @NSManaged public func addToGames(_ value: GameCollected)

    @objc(removeGamesObject:)
    @NSManaged public func removeFromGames(_ value: GameCollected)

    @objc(addGames:)
    @NSManaged public func addToGames(_ values: NSSet)

    @objc(removeGames:)
    @NSManaged public func removeFromGames(_ values: NSSet)

}
