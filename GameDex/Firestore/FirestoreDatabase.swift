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
        case userGame(String, String, String)
        case users
        case apiKey
        case searchGamesApi
        
        var path: String {
            switch self {
            case .searchPlatform:
                return "platforms"
            case let .userPlatforms(userId):
                return "users/\(userId)/platforms"
            case let .userGames(userId, platformId):
                return "users/\(userId)/platforms/\(platformId)/games"
            case let .userGame(userId, platformId, gameId):
                return "users/\(userId)/platforms/\(platformId)/games/\(gameId)"
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
        case acquisitionYear, description, email, gameCompleteness, gameCondition, gameRegion, id, image, imageUrl, key, lastUpdated, notes, physical, platform, rating, releaseDate, storageArea, title
    }
    
    private let database = Firestore.firestore()
    
    func getAvailablePlatforms() async -> Result<[Platform], DatabaseError> {
        do {
            let fetchedData = try await self.database.collection(Collections.searchPlatform.path).getDocuments()
            
            var platforms = [Platform]()
            for item in fetchedData.documents {
                let data = item.data()
                let title = item.documentID
                guard let id = data[Attributes.id.rawValue] as? Int,
                      let imageUrl = data[Attributes.imageUrl.rawValue] as? String,
                      let hasPhysicalGames = data[Attributes.physical.rawValue] as? Bool else {
                    return .failure(DatabaseError.fetchError)
                }
                
                if hasPhysicalGames {
                    let platform = Platform(
                        title: title,
                        id: id,
                        imageUrl: imageUrl,
                        games: nil
                    )
                    platforms.append(platform)
                }
            }
            return .success(platforms)
        } catch {
            return .failure(DatabaseError.fetchError)
        }
    }
    
    func getSinglePlatformCollection(userId: String, platform: Platform) async -> Result<Platform, DatabaseError> {
        do {
            let gamesPath = Collections.userGames(userId, "\(platform.id)").path
            let fetchedGames = try await self.database.collection(gamesPath).getDocuments()
            var savedGames = [SavedGame]()
            for item in fetchedGames.documents {
                let data = item.data()
                let id = item.documentID
                
                guard let title = data[Attributes.title.rawValue] as? String,
                      let description = data[Attributes.description.rawValue],
                      let platformId = data[Attributes.platform.rawValue] as? Int,
                      let imageUrl = data[Attributes.imageUrl.rawValue],
                      let lastUpdatedTimeStamp = data[Attributes.lastUpdated.rawValue] as? Timestamp,
                      let releaseTimeStamp = data[Attributes.releaseDate.rawValue] as? Timestamp,
                      let notes = data[Attributes.notes.rawValue],
                      let gameCondition = data[Attributes.gameCondition.rawValue],
                      let gameCompleteness = data[Attributes.gameCompleteness.rawValue],
                      let gameRegion = data[Attributes.gameRegion.rawValue],
                      let storageArea = data[Attributes.storageArea.rawValue],
                      let acquisitionYear = data[Attributes.acquisitionYear.rawValue],
                      let rating = data[Attributes.rating.rawValue] as? Int else {
                    return .failure(DatabaseError.fetchError)
                }
                
                let lastUpdatedDate = lastUpdatedTimeStamp.dateValue()
                let releasedDate = releaseTimeStamp.dateValue()
                let savedGame = SavedGame(
                    game: Game(
                        title: title,
                        description: String(describing: description),
                        id: id,
                        platformId: platformId,
                        imageUrl: String(describing: imageUrl),
                        releaseDate: releasedDate
                    ),
                    acquisitionYear: acquisitionYear as? String,
                    gameCondition: gameCondition as? String,
                    gameCompleteness: gameCompleteness as? String,
                    gameRegion: gameRegion as? String,
                    storageArea: storageArea as? String,
                    rating: rating,
                    notes: notes as? String,
                    lastUpdated: lastUpdatedDate
                )
                savedGames.append(savedGame)
            }
            
            let platform = Platform(
                title: platform.title,
                id: platform.id, 
                imageUrl: platform.imageUrl,
                games: savedGames
            )
            return .success(platform)
        } catch {
            return .failure(DatabaseError.fetchError)
        }
    }
    
    func getUserCollection(userId: String) async -> Result<[Platform], DatabaseError> {
        do {
            let platformsPath = Collections.userPlatforms(userId).path
            let fetchedPlatforms = try await self.database.collection(platformsPath).getDocuments()
            var platforms = [Platform]()
            for item in fetchedPlatforms.documents {
                let data = item.data()
                let platformStringId = item.documentID
                guard let title = data[Attributes.title.rawValue] as? String,
                      let imageUrl = data[Attributes.imageUrl.rawValue] as? String,
                      let platformId = Int(platformStringId) else {
                    return .failure(DatabaseError.fetchError)
                }
                
                let platform = Platform(
                    title: title,
                    id: platformId,
                    imageUrl: imageUrl,
                    games: nil
                )
                
                let fetchSinglePlatformResult = await self.getSinglePlatformCollection(userId: userId, platform: platform)
                switch fetchSinglePlatformResult {
                case .success(let platformResult):
                    platforms.append(platformResult)
                case .failure:
                    return .failure(DatabaseError.fetchError)
                }
            }
            return .success(platforms)
        } catch {
            return .failure(DatabaseError.fetchError)
        }
    }
    
    func saveUser(userId: String, userEmail: String) async -> DatabaseError? {
        guard await self.saveUserEmail(userId: userId, userEmail: userEmail) == nil else {
            return DatabaseError.saveError
        }
        if let error = await self.saveCollection(userId: userId, localDatabase: LocalDatabaseImpl()) {
            return error
        } else {
            return nil
        }
    }
    
    func saveUserEmail(userId: String, userEmail: String) async -> DatabaseError? {
        do {
            try await
            self.database.collection(Collections.users.path).document(userId).setData([
                Attributes.email.rawValue: userEmail.lowercased()
            ])
            return nil
        } catch {
            return DatabaseError.saveError
        }
    }
    
    func saveCollection(userId: String, localDatabase: LocalDatabase) async -> DatabaseError? {
        let fetchPlatformsResult = localDatabase.fetchAllPlatforms()
        switch fetchPlatformsResult {
        case .success(let platform):
            guard !platform.isEmpty else {
                return nil
            }
            let platforms = CoreDataConverter.convert(platformsCollected: platform)
            
            for platform in platforms {
                if let error = await self.saveGames(
                    userId: userId,
                    platform: platform
                ) {
                    return error
                }
            }
        case .failure(_):
            return DatabaseError.saveError
        }
        return nil
    }
    
    func gameIsInDatabase(userId: String, savedGame: SavedGame) async -> Result<Bool, DatabaseError> {
        do {
            let gamesPath = Collections.userGames(userId, "\(savedGame.game.platformId)").path
            let fetchedGames = try await self.database.collection(gamesPath).getDocuments()
            for item in fetchedGames.documents {
                let id = item.documentID
                if id == savedGame.game.id {
                    return .success(true)
                }
            }
            return .success(false)
        } catch {
            return .failure(DatabaseError.fetchError)
        }
    }
    
    func saveGame(userId: String, game: SavedGame, platform: Platform, editingEntry: Bool) async -> DatabaseError? {
        do {
            if !editingEntry {
                let fetchResult = await self.gameIsInDatabase(userId: userId, savedGame: game)
                switch fetchResult {
                case .success(let platform):
                    guard platform == false else {
                        return DatabaseError.itemAlreadySaved
                    }
                case .failure:
                    break
                }
            }
            
            try await self.database.collection(Collections.userPlatforms(userId).path).document("\(game.game.platformId)").setData([
                Attributes.title.rawValue: platform.title,
                Attributes.imageUrl.rawValue: platform.imageUrl
            ])
            
            let docData: [String: Any] = [
                Attributes.title.rawValue: game.game.title,
                Attributes.description.rawValue: game.game.description,
                Attributes.imageUrl.rawValue: game.game.imageUrl,
                Attributes.releaseDate.rawValue: game.game.releaseDate as Any,
                Attributes.platform.rawValue: game.game.platformId,
                Attributes.gameCondition.rawValue: game.gameCondition as Any,
                Attributes.gameCompleteness.rawValue: game.gameCompleteness as Any,
                Attributes.gameRegion.rawValue: game.gameRegion as Any,
                Attributes.storageArea.rawValue: game.storageArea as Any,
                Attributes.rating.rawValue: game.rating as Any,
                Attributes.notes.rawValue: game.notes as Any,
                Attributes.lastUpdated.rawValue: game.lastUpdated,
                Attributes.acquisitionYear.rawValue: game.acquisitionYear as Any
            ]
            try await self.database.collection(Collections.userGames(userId, "\(game.game.platformId)").path).document(game.game.id).setData(docData)
            return nil
        } catch {
            return DatabaseError.saveError
        }
    }
    
    func saveGames(userId: String, platform: Platform) async -> DatabaseError? {
        do {
            try await self.database.collection(Collections.userPlatforms(userId).path).document("\(platform.id)").setData([
                Attributes.title.rawValue: platform.title,
                Attributes.imageUrl.rawValue: platform.imageUrl
            ])
            
            guard let games = platform.games else {
                return nil
            }
            for item in games {
                let docData: [String: Any] = [
                    Attributes.title.rawValue: item.game.title,
                    Attributes.description.rawValue: item.game.description,
                    Attributes.imageUrl.rawValue: item.game.imageUrl,
                    Attributes.releaseDate.rawValue: item.game.releaseDate as Any,
                    Attributes.platform.rawValue: item.game.platformId,
                    Attributes.gameCondition.rawValue: item.gameCondition as Any,
                    Attributes.gameCompleteness.rawValue: item.gameCompleteness as Any,
                    Attributes.gameRegion.rawValue: item.gameRegion as Any,
                    Attributes.storageArea.rawValue: item.storageArea as Any,
                    Attributes.rating.rawValue: item.rating as Any,
                    Attributes.notes.rawValue: item.notes as Any,
                    Attributes.lastUpdated.rawValue: item.lastUpdated,
                    Attributes.acquisitionYear.rawValue: item.acquisitionYear as Any
                ]
                try await self.database.collection(Collections.userGames(userId, "\(platform.id)").path).document(item.game.id).setData(docData)
            }
            return nil
        } catch {
            return DatabaseError.saveError
        }
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
    
    func removeGame(userId: String, platform: Platform, savedGame: SavedGame) async -> DatabaseError? {
        do {
            let gamesPath = Collections.userGames(userId, "\(savedGame.game.platformId)").path
            let gameDoc = savedGame.game.id
            
            try await database.collection(gamesPath).document(gameDoc).delete()
            
            // once game is deleted, we have to check is the platform collection is empty. If yes, then we delete the plaform from database.
            
            let fetchPlatformResult = await self.getSinglePlatformCollection(userId: userId, platform: platform)
            switch fetchPlatformResult {
            case let .success(platformResult):
                guard platformResult.games?.count != .zero else {
                    let platformsPath = Collections.userPlatforms(userId).path
                    let platformDoc = platform.id
                    try await database.collection(platformsPath).document("\(platformDoc)").delete()
                    return nil
                }
                return nil
            case .failure:
                return DatabaseError.removeError
            }
        } catch {
            return DatabaseError.removeError
        }
    }
    
    func removeUser(userId: String) async -> DatabaseError? {
        do {
            let fetchedUserPlatforms = await self.getUserCollection(userId: userId)
            switch fetchedUserPlatforms {
            case .success(let platforms):
                for platform in platforms {
                    guard let games = platform.games else { break }
                    for game in games {
                        let gamesPath = Collections.userGames(userId, "\(platform.id)").path
                        let gameDoc = game.game.id
                        try await database.collection(gamesPath).document(gameDoc).delete()
                    }
                    let platformsPath = Collections.userPlatforms(userId).path
                    let platformDoc = platform.id
                    try await database.collection(platformsPath).document("\(platformDoc)").delete()
                }
                let userPath = Collections.users.path
                let userDoc = userId
                try await database.collection(userPath).document("\(userDoc)").delete()
                return nil
            case .failure(let error):
                return error
            }
        } catch {
            return DatabaseError.removeError
        }
    }
    
    func syncLocalAndCloudDatabases(userId: String, localDatabase: LocalDatabase) async -> DatabaseError? {
        
        // We ALWAYS fetch Firestore data and synced it to Coredata and not the other way around. Firestore is the truth !!
        
        let fetchCloudPlatformsResult = await self.getUserCollection(userId: userId)
        switch fetchCloudPlatformsResult {
        case .success(let platformsResult):
            guard await localDatabase.removeAll() == nil else {
                return DatabaseError.removeError
            }
            
            for platformResult in platformsResult {
                let platform = Platform(
                    title: platformResult.title,
                    id: platformResult.id, 
                    imageUrl: platformResult.imageUrl,
                    games: nil
                )
                guard let games = platformResult.games else {
                    return DatabaseError.removeError
                }
                for gameResult in games {
                    guard await localDatabase.add(newEntity: gameResult, platform: platform) == nil else {
                        return DatabaseError.saveError
                    }
                }
            }
            return nil
        case .failure(_):
            return DatabaseError.fetchError
        }
    }
}
