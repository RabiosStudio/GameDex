//
//  Matcher+Extension.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import Foundation
import SwiftyMocky
@testable import GameDex

extension Matcher {
    enum GetGamesEndpoint {
        static func matcher(lhs: GameDex.GetGamesEndpoint, rhs: GameDex.GetGamesEndpoint) -> Bool {
            lhs.path == rhs.path &&
            lhs.entryParameters?.count == rhs.entryParameters?.count &&
            lhs.method == rhs.method
        }
    }
    
    enum AlertViewModel {
        static func matcher(lhs: GameDex.AlertViewModel, rhs: GameDex.AlertViewModel) -> Bool {
            lhs.alertType == rhs.alertType &&
            lhs.description == rhs.description
        }
    }
    
    enum ContentViewFactory {
        static func matcher(lhs: GameDex.ContentViewFactory, rhs: GameDex.ContentViewFactory) -> Bool {
            lhs.contentView == rhs.contentView
        }
    }
}
