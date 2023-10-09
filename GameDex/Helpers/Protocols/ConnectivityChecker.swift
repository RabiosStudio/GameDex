//
//  ConnectivityChecker.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 07/10/2023.
//

import Foundation

// sourcery: AutoMockable
protocol ConnectivityChecker {
    func hasConnectivity() -> Bool
}
