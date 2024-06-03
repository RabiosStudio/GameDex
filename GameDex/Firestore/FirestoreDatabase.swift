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
        let fetchedPlatformsResult = await self.firestoreSession.getData(mainPath: Collections.searchPlatform.path, condition: nil)
        
        var platforms = [Platform]()
        switch fetchedPlatformsResult {
        case let .success(fetchedPlatforms):
            for item in fetchedPlatforms {
                guard let id = item.data[Attributes.id.rawValue] as? Int,
                      let imageUrl = item.data[Attributes.imageUrl.rawValue] as? String,
                      let hasPhysicalGames = item.data[Attributes.physical.rawValue] as? Bool,
                      let supportedNames = item.data[Attributes.supportedNames.rawValue] as? [String] else {
                    return .failure(DatabaseError.fetchError)
                }
                
                if hasPhysicalGames {
                    let platform = Platform(
                        title: item.id,
                        id: id,
                        imageUrl: imageUrl,
                        games: nil, 
                        supportedNames: supportedNames
                    )
                    platforms.append(platform)
                }
            }
            return .success(platforms)
        case let .failure(error):
            return .failure(error)
        }
    }
    
    func getSinglePlatformCollection(userId: String, platform: Platform) async -> Result<Platform, DatabaseError> {
        let fetchedGamesResult = await self.firestoreSession.getData(mainPath: Collections.userGames(userId, "\(platform.id)").path, condition: nil)
        switch fetchedGamesResult {
        case let .success(fetchedGames):
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
                games: savedGames, 
                supportedNames: platform.supportedNames
            )
            return .success(platform)
        case let .failure(error):
            return .failure(error)
        }
    }
    
    func getUserCollection(userId: String) async -> Result<[Platform], DatabaseError> {
        let fetchedPlatformsResult = await self.firestoreSession.getData(mainPath: Collections.userPlatforms(userId).path, condition: nil)
        switch fetchedPlatformsResult {
        case let .success(fetchedPlatforms):
            var platforms = [Platform]()
            for item in fetchedPlatforms {
                guard let title = item.data[Attributes.title.rawValue] as? String,
                      let imageUrl = item.data[Attributes.imageUrl.rawValue] as? String,
                      let platformId = Int(item.id),
                      let supportedNames = item.data[Attributes.supportedNames.rawValue] as? [String] else {
                    return .failure(DatabaseError.fetchError)
                }
                
                let platform = Platform(
                    title: title,
                    id: platformId,
                    imageUrl: imageUrl,
                    games: nil, 
                    supportedNames: supportedNames
                )
                
                let fetchSinglePlatformResult = await self.getSinglePlatformCollection(userId: userId, platform: platform)
                switch fetchSinglePlatformResult {
                case let .success(platform):
                    platforms.append(platform)
                case .failure:
                    return .failure(DatabaseError.fetchError)
                }
            }
            return .success(platforms)
        case let .failure(error):
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
        case let .success(platformsFetched):
            guard !platformsFetched.isEmpty else {
                return nil
            }
            let platforms = CoreDataConverter.convert(platformsCollected: platformsFetched)
            
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
        let fetchedGamesResult = await self.firestoreSession.getData(mainPath: Collections.userGames(userId, "\(savedGame.game.platformId)").path, condition: nil)
        switch fetchedGamesResult {
        case let .success(fetchedGames):
            for item in fetchedGames {
                guard let fetchedGameId = item.data[Attributes.id.rawValue] as? String,
                      fetchedGameId != savedGame.game.id else {
                    guard let gameFormatNumber  = item.data[Attributes.isPhysical.rawValue] as? Int,
                          let savedGameFormatNumber = savedGame.isPhysical ? 1 : .zero,
                          gameFormatNumber != savedGameFormatNumber else {
                        return .success(true)
                    }
                    continue
                }
            }
            return .success(false)
        case let .failure(error):
            return .failure(error)
        }
    }
    
    func replaceGame(userId: String, newGame: SavedGame, oldGame: SavedGame, platform: Platform) async -> DatabaseError? {
        let fetchGameUUIDResult = await self.getGameUUID(userId: userId, newGame: newGame, oldGame: oldGame)
        switch fetchGameUUIDResult {
        case let .success(fetchedGameUUID):
            let gameUUID = fetchedGameUUID
            let gameData: FirestoreData = self.convert(game: newGame, gameUUID: gameUUID, platform: platform)
            guard await self.firestoreSession.setData(path: Collections.userGames(userId, "\(newGame.game.platformId)").path, firestoreData: gameData) == nil else {
                return DatabaseError.saveError
            }
        case let .failure(error):
            return error
        }
        return nil
    }
    
    func saveGame(userId: String, game: SavedGame, platform: Platform) async -> DatabaseError? {
        let gameIsInDatabaseFetchResult = await self.gameIsInDatabase(userId: userId, savedGame: game)
        switch gameIsInDatabaseFetchResult {
        case let .success(gameIsInDatabase):
            guard gameIsInDatabase == false else {
                return DatabaseError.itemAlreadySaved
            }
        case .failure:
            break
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
    
    func getGameUUID(
        userId: String,
        newGame: SavedGame? = nil,
        oldGame: SavedGame
    ) async -> Result<String?, DatabaseError> {
        let query = FirestoreQuery(
            key: Attributes.id.rawValue,
            value: oldGame.game.id
        )
        let fetchedGamesResult = await self.firestoreSession.getData(mainPath: Collections.userGames(userId, "\(oldGame.game.platformId)").path, condition: query)
        switch fetchedGamesResult {
        case let .success(fetchedGames):
            guard fetchedGames.count <= 1 else {
                // If there are more than 1 game with the same ID, it means that the game was saved with different game formats
                for fetchedGame in fetchedGames {
                    guard let newGame else {
                        // No newGame defined, so the user is not trying to edit a game but deleting it instead.
                        let result = self.isSameGame(savedGame: oldGame, firestoreGameData: fetchedGame)
                        if result {
                            return .success(fetchedGame.id)
                        } else {
                            break
                        }
                    }
                    let fetchedGameFormatNumber  = fetchedGame.data[Attributes.isPhysical.rawValue] as? Int
                    let newGameFormatNumber = newGame.isPhysical ? 1 : .zero
                    let oldGameFormatNumber = oldGame.isPhysical ? 1 : .zero
                    
                    if fetchedGameFormatNumber == newGameFormatNumber && fetchedGameFormatNumber ==  oldGameFormatNumber {
                        // The game format was not updated, we simply return the game UUID
                        return .success(fetchedGame.id)
                    }
                }
                // The format was updated but the collection already contains 2 formats of this game
                return .failure(DatabaseError.itemAlreadySaved)
            }
            // Zero or one game in collection with matching ID
            return fetchedGames.isEmpty ? .failure(DatabaseError.fetchError) : .success(fetchedGames.first?.id)
        case .failure:
            return .failure(DatabaseError.fetchError)
        }
    }
    
    func isSameGame(savedGame: SavedGame, firestoreGameData: FirestoreData) -> Bool {
        let fetchedGame = self.convert(firestoreData: firestoreGameData)
        return fetchedGame == savedGame
    }
    
    func savePlatform(userId: String, platform: Platform) async -> DatabaseError? {
        let platformData = FirestoreData(id: "\(platform.id)", data: [
            Attributes.title.rawValue: platform.title,
            Attributes.imageUrl.rawValue: platform.imageUrl,
            Attributes.supportedNames.rawValue: platform.supportedNames
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
            guard await self.firestoreSession.setData(path: Collections.userGames(userId, "\(platform.id)").path, firestoreData: gameData) == nil else {
                return DatabaseError.saveError
            }
        }
        return nil
    }
    
    func getApiKey() async -> Result<String, DatabaseError> {
        let fetchedApiKeyResult = await self.firestoreSession.getSingleData(path: Collections.apiKey.path, directory: Collections.searchGamesApi.path)
        switch fetchedApiKeyResult {
        case let .success(fetchedApiKey):
            guard let key = fetchedApiKey.data[Attributes.key.rawValue] as? String else {
                return .failure(DatabaseError.fetchError)
            }
            return .success(key)
        case let .failure(error):
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
        let fetchGameUUIDResult = await self.getGameUUID(userId: userId, oldGame: savedGame)
        switch fetchGameUUIDResult {
        case let .success(fetchedGameUUID):
            guard let gameUUID = fetchedGameUUID,
                  await self.firestoreSession.deleteData(
                      path: Collections.userGames(userId, "\(savedGame.game.platformId)").path,
                      directory: gameUUID
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
        case let .failure(error):
            return error
        }
    }
    
    func removePlatformAndGames(userId: String, platform: Platform) async -> DatabaseError? {
        guard let games = platform.games else {
            return nil
        }
        for game in games {
            guard await self.removeGame(userId: userId, platform: platform, savedGame: game) == nil else {
                return DatabaseError.removeError
            }
        }
        return nil
    }
    
    func removeUser(userId: String) async -> DatabaseError? {
        let fetchedUserPlatforms = await self.getUserCollection(userId: userId)
        switch fetchedUserPlatforms {
        case let .success(platforms):
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
        case let .failure(error):
            return error
        }
    }
    
    func syncLocalAndCloudDatabases(userId: String, localDatabase: LocalDatabase) async -> DatabaseError? {
        let fetchCloudPlatformsResult = await self.getUserCollection(userId: userId)
        switch fetchCloudPlatformsResult {
        case let .success(platformsResult):
            guard await localDatabase.removeAll() == nil else {
                return DatabaseError.removeError
            }
            for platformResult in platformsResult {
                let platform = Platform(
                    title: platformResult.title,
                    id: platformResult.id,
                    imageUrl: platformResult.imageUrl,
                    games: nil, 
                    supportedNames: platformResult.supportedNames
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
    func convert(game: SavedGame, gameUUID: String? = nil, platform: Platform) -> FirestoreData {
        let gameData: [String: Any] = [
            Attributes.id.rawValue: game.game.id,
            Attributes.title.rawValue: game.game.title,
            Attributes.description.rawValue: game.game.description,
            Attributes.imageUrl.rawValue: game.game.imageUrl,
            Attributes.releaseDate.rawValue: game.game.releaseDate as Any,
            Attributes.platform.rawValue: game.game.platformId,
            Attributes.gameCondition.rawValue: game.gameCondition?.rawValue as Any,
            Attributes.gameCompleteness.rawValue: game.gameCompleteness?.rawValue as Any,
            Attributes.gameRegion.rawValue: game.gameRegion?.rawValue as Any,
            Attributes.storageArea.rawValue: game.storageArea as Any,
            Attributes.rating.rawValue: game.rating as Any,
            Attributes.notes.rawValue: game.notes as Any,
            Attributes.lastUpdated.rawValue: game.lastUpdated,
            Attributes.acquisitionYear.rawValue: game.acquisitionYear as Any,
            Attributes.isPhysical.rawValue: game.isPhysical as Bool
        ]
        return FirestoreData(id: gameUUID ?? UUID().uuidString, data: gameData)
    }
    
    func convert(firestoreData: FirestoreData) -> SavedGame? {
        guard let title = firestoreData.data[Attributes.title.rawValue] as? String,
              let description = firestoreData.data[Attributes.description.rawValue],
              let platformId = firestoreData.data[Attributes.platform.rawValue] as? Int,
              let imageUrl = firestoreData.data[Attributes.imageUrl.rawValue],
              let lastUpdatedTimeStamp = firestoreData.data[Attributes.lastUpdated.rawValue] as? Timestamp,
              let releaseTimeStamp = firestoreData.data[Attributes.releaseDate.rawValue] as? Timestamp,
              let notes = firestoreData.data[Attributes.notes.rawValue],
              let storageArea = firestoreData.data[Attributes.storageArea.rawValue],
              let acquisitionYear = firestoreData.data[Attributes.acquisitionYear.rawValue],
              let rating = firestoreData.data[Attributes.rating.rawValue] as? Int,
              let isPhysical = firestoreData.data[Attributes.isPhysical.rawValue] as? Bool,
              let id = firestoreData.data[Attributes.id.rawValue] as? String else {
            return nil
        }
        
        var gameCondition: GameCondition?
        if let gameConditionText = firestoreData.data[Attributes.gameCondition.rawValue] as? String {
            gameCondition = GameCondition(rawValue: gameConditionText)
        }
        
        var gameCompleteness: GameCompleteness?
        if let gameCompletenessText = firestoreData.data[Attributes.gameCompleteness.rawValue] as? String {
            gameCompleteness = GameCompleteness(rawValue: gameCompletenessText)
        }
        
        var gameRegion: GameRegion?
        if let gameRegionText = firestoreData.data[Attributes.gameRegion.rawValue] as? String {
            gameRegion = GameRegion(rawValue: gameRegionText)
        }
        
        let lastUpdatedDate = lastUpdatedTimeStamp.dateValue()
        let releasedDate = releaseTimeStamp.dateValue()
        return SavedGame(
            game: Game(
                title: title,
                description: String(describing: description),
                id: id,
                platformId: platformId,
                imageUrl: String(describing: imageUrl),
                releaseDate: releasedDate
            ),
            acquisitionYear: acquisitionYear as? String,
            gameCondition: gameCondition,
            gameCompleteness: gameCompleteness,
            gameRegion: gameRegion,
            storageArea: storageArea as? String,
            rating: rating,
            notes: notes as? String,
            lastUpdated: lastUpdatedDate, 
            isPhysical: isPhysical
        )
    }
}

// MARK: - Private enums
private extension FirestoreDatabase {
    enum Collections {
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
            case let .userPlatforms(userId):
                return "users/\(userId)/platforms"
            case let .userGames(userId, platformId):
                return "users/\(userId)/platforms/\(platformId)/games"
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
        case acquisitionYear, description, email, gameCompleteness, gameCondition, gameRegion, id, image, imageUrl, key, lastUpdated, notes, physical, platform, rating, releaseDate, storageArea, title, isPhysical, supportedNames
    }
}
