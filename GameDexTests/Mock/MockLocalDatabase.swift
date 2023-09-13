//
//  MockLocalDatabase.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 13/09/2023.
//

import Foundation
@testable import GameDex

class MockLocalDatabase: LocalDatabase {
    let data: [SavedData]?
    let response: String?
    
    init(data: [SavedData]?, response: String?) {
        self.data = data
        self.response = response
    }
    
    override func fetchAll<T: SavedData>(databaseKey: DatabaseKey) -> Result<[T], DatabaseError> {
        guard let bla = data as? [T] else {
            return .failure(DatabaseError.fetchError)
        }
        return .success(bla)
    }
    
    override func add<T: SavedData>(newEntity: T) -> Result<String, DatabaseError> {
        guard let response else {
            return .failure(DatabaseError.saveError)
        }
        return .success(response)
    }
    
    override func replace<T: SavedData>(newEntity: T) -> Result<String, DatabaseError> {
        guard let response else {
            return .failure(DatabaseError.replaceError)
        }
        return .success(response)
    }
}
