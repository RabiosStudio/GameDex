//
//  connectivityChecker.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 06/10/2023.
//

import Foundation
import Reachability

class ConnectivityCheckerImpl: ConnectivityChecker {

    func hasConnectivity() -> Bool {
        do {
            let reachability: Reachability = try Reachability()
            let networkStatus = reachability.connection
            
            switch networkStatus {
            case .unavailable:
                return false
            case .wifi, .cellular:
                return true
            case .none:
                return false
            }
        } catch {
            return false
        }
    }
}
