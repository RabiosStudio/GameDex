//
//  LocalDatabase.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 10/09/2023.
//

import Foundation

class LocalDatabase {
    
    static func fetchAll<T: SavedData>(databaseKey: DatabaseKey) -> Result<[T], DatabaseError> {
        guard let data = UserDefaults.standard.data(forKey: databaseKey.rawValue) else {
            return .success([T]())
        }
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([T].self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(DatabaseError.fetchError)
        }
    }
    
    static func add<T: SavedData>(newEntity: T) -> Result<String, DatabaseError> {
        let fetchAllResult: Result<[T], DatabaseError> = LocalDatabase.fetchAll(
            databaseKey: newEntity.databaseKey
        )
        switch fetchAllResult {
        case .success(var allDataFetched):
            do {
                allDataFetched.append(newEntity)
                let encoder = JSONEncoder()
                let encodedData = try encoder.encode(allDataFetched)
                UserDefaults.standard.set(encodedData, forKey: newEntity.databaseKey.rawValue)
                return .success(L10n.success)
            } catch {
                return .failure(DatabaseError.saveError)
            }
        case .failure(_):
            return .failure(DatabaseError.saveError)
        }
    }
    
    static func replace<T: SavedData>(newEntity: T) -> Result<String, DatabaseError> {
        let fetchAllResult: Result<[T], DatabaseError> = LocalDatabase.fetchAll(
            databaseKey: newEntity.databaseKey
        )
        switch fetchAllResult {
        case .success(var allDataFetched):
            do {
                guard let index = allDataFetched.firstIndex(where: { currentEntity in
                    newEntity.id == currentEntity.id
                }) else {
                    return .failure(DatabaseError.replaceError)
                }
                allDataFetched.remove(at: index)
                allDataFetched.append(newEntity)
                let encoder = JSONEncoder()
                let encodedData = try encoder.encode(allDataFetched)
                UserDefaults.standard.set(encodedData, forKey: newEntity.databaseKey.rawValue)
                return .success(L10n.success)
            } catch {
                return .failure(DatabaseError.replaceError)
            }
        case .failure(_):
            return .failure(DatabaseError.replaceError)
        }
    }
}
