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
    func saveUser(
        userEmail: String,
        callback: @escaping (DatabaseError?) -> ()
    )
    func saveCollection(
        userEmail: String,
        platforms: [Platform],
        callback: @escaping (DatabaseError?) -> ()
    )
}
