//
//  FirestoreDatabase.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 28/09/2023.
//

import Foundation
import FirebaseFirestore

class FirestoreDatabase: CloudDatabase {
    
    private let firestoreSession: FirestoreSession
    
    init(firestoreSession: FirestoreSession = FirestoreSessionImpl()) {
        self.firestoreSession = firestoreSession
    }
    
    func getAvailablePlatforms() async -> Result<[Platform], DatabaseError> {
        let fetchedPlatformsResult = await self.firestoreSession.getData(mainPath: Collections.searchPlatform.path)
        
        var platforms = [Platform]()
        switch fetchedPlatformsResult {
        case .success(let fetchedPlatforms):
            for item in fetchedPlatforms {
                guard let id = item.data[Attributes.id.rawValue] as? Int,
                      let imageUrl = item.data[Attributes.imageUrl.rawValue] as? String,
                      let hasPhysicalGames = item.data[Attributes.physical.rawValue] as? Bool else {
                    return .failure(DatabaseError.fetchError)
                }
                
                if hasPhysicalGames {
                    let platform = Platform(
                        title: item.id,
                        id: id,
                        imageUrl: imageUrl,
                        games: nil
                    )
                    platforms.append(platform)
                }
            }
            return .success(platforms)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getSinglePlatformCollection(userId: String, platform: Platform) async -> Result<Platform, DatabaseError> {
        let fetchedGamesResult = await self.firestoreSession.getData(mainPath: Collections.userGames(userId, "\(platform.id)").path)
        switch fetchedGamesResult {
        case .success(let fetchedGames):
            var savedGames = [SavedGame]()
            for item in fetchedGames {
                guard let savedGame = self.convert(firestoreData: item) else {
                    return .failure(DatabaseError.fetchError)
                }
                savedGames.append(savedGame)
            }
            let platform = Platform(
                title: platform.title,
                id: platform.id,
                imageUrl: platform.imageUrl,
                games: savedGames
            )
            return .success(platform)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getUserCollection(userId: String) async -> Result<[Platform], DatabaseError> {
        let fetchedPlatformsResult = await self.firestoreSession.getData(mainPath: Collections.userPlatforms(userId).path)
        switch fetchedPlatformsResult {
        case .success(let fetchedPlatforms):
            var platforms = [Platform]()
            for item in fetchedPlatforms {
                guard let title = item.data[Attributes.title.rawValue] as? String,
                      let imageUrl = item.data[Attributes.imageUrl.rawValue] as? String,
                      let platformId = Int(item.id) else {
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
                case .success(let platform):
                    platforms.append(platform)
                case .failure:
                    return .failure(DatabaseError.fetchError)
                }
            }
            return .success(platforms)
        case .failure(let error):
            return .failure(error)
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
        let firestoreData = FirestoreData(id: userId, data: [Attributes.email.rawValue: userEmail.lowercased()])
        guard let error = await self.firestoreSession.setData(path: Collections.users.path, firestoreData: firestoreData) else {
            return nil
        }
        return error
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
        let fetchedGamesResult = await self.firestoreSession.getData(mainPath: Collections.userGames(userId, "\(savedGame.game.platformId)").path)
        switch fetchedGamesResult {
        case .success(let fetchedGames):
            for item in fetchedGames {
                if item.id == savedGame.game.id {
                    return .success(true)
                }
            }
            return .success(false)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func saveGame(userId: String, game: SavedGame, platform: Platform, editingEntry: Bool) async -> DatabaseError? {
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
        guard await self.savePlatform(userId: userId, platform: platform) == nil else {
            return DatabaseError.saveError
        }
        let gameData: FirestoreData = self.convert(game: game, platform: platform)
        guard await self.firestoreSession.setData(path: Collections.userGames(userId, "\(game.game.platformId)").path, firestoreData: gameData) == nil else {
            return DatabaseError.saveError
        }
        return nil
    }
    
    func savePlatform(userId: String, platform: Platform) async -> DatabaseError? {
        let platformData = FirestoreData(id: "\(platform.id)", data: [
            Attributes.title.rawValue: platform.title,
            Attributes.imageUrl.rawValue: platform.imageUrl
        ])
        guard await self.firestoreSession.setData(path: Collections.userPlatforms(userId).path, firestoreData: platformData) == nil else {
            return DatabaseError.saveError
        }
        return nil
    }
    
    func saveGames(userId: String, platform: Platform) async -> DatabaseError? {
        guard await self.savePlatform(userId: userId, platform: platform) == nil else {
            return DatabaseError.saveError
        }
        guard let games = platform.games else {
            return nil
        }
        for item in games {
            let gameData: FirestoreData = self.convert(game: item, platform: platform)
            guard let error = await self.firestoreSession.setData(path: Collections.userGames(userId, "\(platform.id)").path, firestoreData: gameData) else {
                return nil
            }
            return DatabaseError.saveError
        }
        return nil
    }
    
    func getApiKey() async -> Result<String, DatabaseError> {
        let fetchedApiKeyResult = await self.firestoreSession.getSingleData(path: Collections.apiKey.path, directory: Collections.searchGamesApi.path)
        switch fetchedApiKeyResult {
        case .success(let fetchedApiKey):
            guard let key = fetchedApiKey.data[Attributes.key.rawValue] as? String else {
                return .failure(DatabaseError.fetchError)
            }
            return .success(key)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func removePlatform(userId: String, platform: Platform) async -> DatabaseError? {
        guard await self.firestoreSession.deleteData(
            path: Collections.userPlatforms(userId).path,
            directory: "\(platform.id)"
        ) == nil else {
            return DatabaseError.removeError
        }
        return nil
    }
    
    func removeGame(userId: String, platform: Platform, savedGame: SavedGame) async -> DatabaseError? {
        guard await self.firestoreSession.deleteData(
            path: Collections.userGames(userId, "\(savedGame.game.platformId)").path,
            directory: savedGame.game.id
        ) == nil else {
            return DatabaseError.removeError
        }
        // once game is deleted, we have to check if the platform still has other games. If not, then we delete the plaform from database.
        let fetchPlatformResult = await self.getSinglePlatformCollection(userId: userId, platform: platform)
        switch fetchPlatformResult {
        case let .success(platform):
            guard platform.games?.count != .zero else {
                guard let error = await self.removePlatform(userId: userId, platform: platform) else {
                    return nil
                }
                return error
            }
            return nil
        case .failure:
            return DatabaseError.removeError
        }
    }
    
    func removeUser(userId: String) async -> DatabaseError? {
        let fetchedUserPlatforms = await self.getUserCollection(userId: userId)
        switch fetchedUserPlatforms {
        case .success(let platforms):
            for platform in platforms {
                guard let games = platform.games else { break }
                for game in games {
                    guard await self.removeGame(userId: userId, platform: platform, savedGame: game) == nil else {
                        return DatabaseError.removeError
                    }
                }
                guard await self.removePlatform(userId: userId, platform: platform) == nil else {
                    return DatabaseError.removeError
                }
            }
            guard await self.firestoreSession.deleteData(path: Collections.users.path, directory: userId) == nil else {
                return DatabaseError.removeError
            }
            return nil
        case .failure(let error):
            return error
        }
    }
    
    func syncLocalAndCloudDatabases(userId: String, localDatabase: LocalDatabase) async -> DatabaseError? {
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

// MARK: - Data convertion
extension FirestoreDatabase {
    func convert(game: SavedGame, platform: Platform) -> FirestoreData {
        let gameData: [String: Any] = [
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
        return FirestoreData(id: game.game.id, data: gameData)
    }
    
    func convert(firestoreData: FirestoreData) -> SavedGame? {
        guard let title = firestoreData.data[Attributes.title.rawValue] as? String,
              let description = firestoreData.data[Attributes.description.rawValue],
              let platformId = firestoreData.data[Attributes.platform.rawValue] as? Int,
              let imageUrl = firestoreData.data[Attributes.imageUrl.rawValue],
              let lastUpdatedTimeStamp = firestoreData.data[Attributes.lastUpdated.rawValue] as? Timestamp,
              let releaseTimeStamp = firestoreData.data[Attributes.releaseDate.rawValue] as? Timestamp,
              let notes = firestoreData.data[Attributes.notes.rawValue],
              let gameCondition = firestoreData.data[Attributes.gameCondition.rawValue],
              let gameCompleteness = firestoreData.data[Attributes.gameCompleteness.rawValue],
              let gameRegion = firestoreData.data[Attributes.gameRegion.rawValue],
              let storageArea = firestoreData.data[Attributes.storageArea.rawValue],
              let acquisitionYear = firestoreData.data[Attributes.acquisitionYear.rawValue],
              let rating = firestoreData.data[Attributes.rating.rawValue] as? Int else {
            return nil
        }
        
        let lastUpdatedDate = lastUpdatedTimeStamp.dateValue()
        let releasedDate = releaseTimeStamp.dateValue()
        return SavedGame(
            game: Game(
                title: title,
                description: String(describing: description),
                id: firestoreData.id,
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
    }
}

// MARK: - Private enums
private extension FirestoreDatabase {
    enum Collections {
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
    
    enum Attributes: String {
        case acquisitionYear, description, email, gameCompleteness, gameCondition, gameRegion, id, image, imageUrl, key, lastUpdated, notes, physical, platform, rating, releaseDate, storageArea, title
    }
}
