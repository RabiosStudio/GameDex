//
//  CloudDatabase.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 02/10/2023.
//

import Foundation

// sourcery: AutoMockable
protocol CloudDatabase {
    func getAvailablePlatforms() async throws -> [Platform]? 
}
