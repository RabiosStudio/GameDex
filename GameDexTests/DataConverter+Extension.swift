//
//  DataConverter+Extension.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 20/09/2023.
//

import Foundation
@testable import GameDex
import CoreData

extension DataConverter {
    static func convert(gameDetails: SavedGame, context: NSManagedObjectContext) -> PlatformCollected {
        let platformCollected = PlatformCollected(context: context)
        platformCollected.id = Int16(gameDetails.game.platform.id)
        platformCollected.title = gameDetails.game.platform.title
        return platformCollected
    }
}
