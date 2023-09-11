//
//  DatabaseError.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 11/09/2023.
//

import Foundation

enum DatabaseError: Error {
    case saveError
    case fetchError
    case replaceError
}
