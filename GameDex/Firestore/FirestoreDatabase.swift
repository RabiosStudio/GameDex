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
        case id
        case email
        case title
        case acquisitionYear
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
                      let notes = data[Attributes.notes.rawValue] as? String,
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
                        imageURL: String(describing: imageUrl),
                        releaseDate: releasedDate
                    ),
                    acquisitionYear: acquisitionYear as? String,
                    gameCondition: gameCondition as? String,
                    gameCompleteness: gameCompleteness as? String,
                    gameRegion: gameRegion as? String,
                    storageArea: storageArea as? String,
                    rating: rating,
                    notes: notes,
                    lastUpdated: lastUpdatedDate
                )
                savedGames.append(savedGame)
            }
            
            let platform = Platform(
                title: platform.title,
                id: platform.id,
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
                      let platformId = Int(platformStringId) else {
                    return .failure(DatabaseError.fetchError)
                }
                var platform = Platform(title: title, id: platformId, games: nil)
                
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
        do {
            try await
            self.database.collection(Collections.users.path).document(userId).setData([
                Attributes.email.rawValue: userEmail.lowercased()
            ])
            if let error = await self.saveCollection(userId: userId, localDatabase: LocalDatabaseImpl()) {
                return error
            } else {
                return nil
            }
        } catch {
            return DatabaseError.saveError
        }
    }
    
    func saveCollection(userId: String, localDatabase: LocalDatabase) async -> DatabaseError? {
        let fetchPlatformsResult = localDatabase.fetchAllPlatforms()
        switch fetchPlatformsResult {
        case .success(let result):
            guard !result.isEmpty else {
                return nil
            }
            let platforms = CoreDataConverter.convert(platformsCollected: result)
            
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
                let data = item.data()
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
    
    func saveGame(userId: String, game: SavedGame, platformName: String, editingEntry: Bool) async -> DatabaseError? {
        do {
            if !editingEntry {
                let fetchResult = await self.gameIsInDatabase(userId: userId, savedGame: game)
                switch fetchResult {
                case .success(let result):
                    guard result == false else {
                        return DatabaseError.itemAlreadySaved
                    }
                case .failure:
                    break
                }
            }
            
            try await self.database.collection(Collections.userPlatforms(userId).path).document("\(game.game.platformId)").setData([
                Attributes.title.rawValue: platformName
            ])
            
            let docData: [String: Any] = [
                Attributes.title.rawValue: game.game.title,
                Attributes.description.rawValue: game.game.description,
                Attributes.imageUrl.rawValue: game.game.imageURL,
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
                Attributes.title.rawValue: platform.title
            ])
            
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
}
