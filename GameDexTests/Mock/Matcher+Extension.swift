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
    enum GetPlatformsEndpoint {
        static func matcher(lhs: GameDex.GetPlatformsEndpoint, rhs: GameDex.GetPlatformsEndpoint) -> Bool {
            lhs.path == rhs.path &&
            lhs.entryParameters?.count == rhs.entryParameters?.count &&
            lhs.method == rhs.method
        }
    }
    
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
            lhs.cancelButtonTitle == rhs.cancelButtonTitle &&
            lhs.description == rhs.description &&
            lhs.okButtonTitle == rhs.okButtonTitle
        }
    }
    
    enum ContentViewFactory {
        static func matcher(lhs: GameDex.ContentViewFactory, rhs: GameDex.ContentViewFactory) -> Bool {
            lhs.bottomView == rhs.bottomView
        }
    }
}
