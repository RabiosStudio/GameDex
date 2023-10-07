//
//  ConnectionManager.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 07/10/2023.
//

import Foundation

// sourcery: AutoMockable
protocol ConnectionManager {
    func hasConnectivity() -> Bool
}
