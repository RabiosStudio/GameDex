//
//  FirestoreDatabase.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 28/09/2023.
//

import Foundation
import FirebaseFirestore

class FirestoreDatabase: CloudDatabase {
    
    private enum Collections {
        case searchPlatform
        case userPlatforms(String)
        case userGames(String, String)
        case users
        case apiKey
        case searchGamesApi
        
        var path: String {
            switch self {
            case .searchPlatform:
                return "platforms"
            case .userPlatforms(let userEmail):
                return "users/\(userEmail)/platforms"
            case .userGames(let userEmail, let platformTitle):
                return "users/\(userEmail)/platforms/\(platformTitle)/games"
            case .users:
                return "users"
            case .apiKey:
                return "api-key"
            case .searchGamesApi:
                return "Giant Bomb"
            }
        }
    }
    
    private enum Attributes: String {
        case id
        case email
        case title
        case description
        case imageUrl
        case releaseDate
        case platform
        case gameCondition
        case gameCompleteness
        case gameRegion
        case storageArea
        case rating
        case notes
        case lastUpdated
        case key
    }
    
    private let database = Firestore.firestore()
    
    func getAvailablePlatforms() async -> Result<[Platform], DatabaseError> {
        do {
            let fetchedData = try await self.database.collection(Collections.searchPlatform.path).getDocuments()
            
            var platforms = [Platform]()
            for item in fetchedData.documents {
                let data = item.data()
                let title = item.documentID
                guard let id = data[Attributes.id.rawValue] as? Int else {
                    return .failure(DatabaseError.fetchError)
                }
                let platform = Platform(
                    title: title,
                    id: id,
                    games: nil
                )
                platforms.append(platform)
            }
            return .success(platforms)
        } catch {
            return .failure(DatabaseError.fetchError)
        }
    }
    
    func saveUser(userEmail: String) async -> DatabaseError? {
        do {
            try await
            self.database.collection(Collections.users.path).document(userEmail).setData([
                Attributes.email.rawValue: userEmail.lowercased()
            ])
            if let error = await self.saveCollection(userEmail: userEmail, localDatabase: LocalDatabaseImpl()) {
                return error
            } else {
                return nil
            }
        } catch {
            return DatabaseError.saveError
        }
    }
    
    func saveCollection(userEmail: String, localDatabase: LocalDatabase) async -> DatabaseError? {
        let fetchPlatformsResult = localDatabase.fetchAllPlatforms()
        switch fetchPlatformsResult {
        case .success(let result):
            guard !result.isEmpty else {
                return nil
            }
            let platforms = CoreDataConverter.convert(platformsCollected: result)
            
            for platform in platforms {
                do {
                    try await self.database.collection(Collections.userPlatforms(userEmail).path).document(platform.title).setData([
                        Attributes.id.rawValue: platform.id,
                        Attributes.title.rawValue: platform.title
                    ])
                    if let error = await self.saveGame(
                        userEmail: userEmail,
                        platform: platform,
                        localDatabase: localDatabase
                    ) {
                        return error
                    }
                } catch {
                    return DatabaseError.saveError
                }
            }
        case .failure(_):
            return DatabaseError.saveError
        }
        return nil
    }
    
    func saveGame(userEmail: String, platform: Platform, localDatabase: LocalDatabase) async -> DatabaseError? {
        guard let games = platform.games else {
            return nil
        }
        for item in games {
            let docData: [String: Any] = [
                Attributes.title.rawValue: item.game.title,
                Attributes.description.rawValue: item.game.description,
                Attributes.imageUrl.rawValue: item.game.imageURL,
                Attributes.releaseDate.rawValue: item.game.releaseDate as Any,
                Attributes.platform.rawValue: item.game.platformId,
                Attributes.gameCondition.rawValue: item.gameCondition as Any,
                Attributes.gameCompleteness.rawValue: item.gameCompleteness as Any,
                Attributes.gameRegion.rawValue: item.gameRegion as Any,
                Attributes.storageArea.rawValue: item.storageArea as Any,
                Attributes.rating.rawValue: item.rating as Any,
                Attributes.notes.rawValue: item.notes as Any,
                Attributes.lastUpdated.rawValue: item.lastUpdated
            ]
            do {
                try await self.database.collection(Collections.userGames(userEmail, platform.title).path).document(item.game.title).setData(docData)
            } catch {
                return DatabaseError.saveError
            }
        }
        return nil
    }
    
    func getApiKey() async -> Result<String, DatabaseError> {
        do {
            let doc = self.database.collection(Collections.apiKey.path).document(Collections.searchGamesApi.path)

            let fetchedData = try await doc.getDocument()
            let documentData = fetchedData.data()
            guard let key = documentData?[Attributes.key.rawValue] as? String else {
                return .failure(DatabaseError.fetchError)
            }
            return .success(key)
        } catch {
            return .failure(DatabaseError.fetchError)
        }
    }
}
