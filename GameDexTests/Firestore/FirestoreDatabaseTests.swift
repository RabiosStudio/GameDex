//
//  FirestoreDatabaseTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 21/10/2023.
//

import XCTest
@testable import GameDex

final class FirestoreDatabaseTests: XCTestCase {
    func test_getAvailablePlatforms_GivenNoError_ThenShouldReturnPlatforms() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.getData(mainPath: .any, willReturn: .success(MockData.firestoreAPIPlatformsCorrectData)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let result = await firestoreDatabase.getAvailablePlatforms()
        
        // THEN
        XCTAssertEqual(result, .success(MockData.firestoreAPIPlatformsResultConverted))
    }
    
    func test_getAvailablePlatforms_GivenReturnDataAttributesError_ThenShouldReturnDatabaseFetchError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.getData(mainPath: .any, willReturn: .success(MockData.firestoreAPIPlatformsIncorrectData)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let result = await firestoreDatabase.getAvailablePlatforms()
        
        // THEN
        XCTAssertEqual(result, .failure(DatabaseError.fetchError))
    }
    
    func test_getAvailablePlatforms_GivenErrorFetchingData_ThenShouldReturnDatabaseFetchError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.getData(mainPath: .any, willReturn: .failure(DatabaseError.fetchError)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let result = await firestoreDatabase.getAvailablePlatforms()
        
        // THEN
        XCTAssertEqual(result, .failure(DatabaseError.fetchError))
    }
    
    func test_getSinglePlatformCollection_GivenNoError_ThenShouldReturnPlatform() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.getData(mainPath: .any, willReturn: .success(MockData.firestoreGamesCorrectData)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let result = await firestoreDatabase.getSinglePlatformCollection(userId: "userId", platform: MockData.platform)
        let expectedPlatformResult = Platform(title: MockData.platform.title, id: MockData.platform.id, imageUrl: MockData.platform.imageUrl, games: MockData.firestoreGamesResultConverted, supportedNames: MockData.platform.supportedNames)
        
        // THEN
        XCTAssertEqual(result, .success(expectedPlatformResult))
    }
    
    func test_getSinglePlatformCollection_GivenErrorConvertingData_ThenShouldReturnFetchError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.getData(mainPath: .any, willReturn: .success(MockData.firestoreGamesIncorrectData)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let result = await firestoreDatabase.getSinglePlatformCollection(userId: "userId", platform: MockData.platform)
        
        // THEN
        XCTAssertEqual(result, .failure(DatabaseError.fetchError))
    }
    
    func test_getSinglePlatformCollection_GivenFetchError_ThenShouldReturnFetchError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.getData(mainPath: .any, willReturn: .failure(DatabaseError.fetchError)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let result = await firestoreDatabase.getSinglePlatformCollection(userId: "userId", platform: MockData.platform)
        
        // THEN
        XCTAssertEqual(result, .failure(DatabaseError.fetchError))
    }
    
    func test_getUserCollection_GivenFetchError_ThenShouldReturnDatabaseFetchError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.getData(mainPath: .any, willReturn: .failure(DatabaseError.fetchError)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let result = await firestoreDatabase.getUserCollection(userId: "userId")
        
        // THEN
        XCTAssertEqual(result, .failure(DatabaseError.fetchError))
    }
    
    func test_getUserCollection_GivenErrorConvertingData_ThenShouldReturnFetchError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.getData(mainPath: .any, willReturn: .success(MockData.firestoreGamesIncorrectData)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let result = await firestoreDatabase.getUserCollection(userId: "userId")
        
        // THEN
        XCTAssertEqual(result, .failure(DatabaseError.fetchError))
    }
    
    func test_saveUserEmail_GivenNoError_ThenShouldReturnNil() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.setData(path: .any, firestoreData: .any, willReturn: nil))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.saveUserEmail(userId: "userId", userEmail: "userEmail")
        
        // THEN
        XCTAssertNil(error)
    }
    
    func test_saveUserEmail_GivenSaveError_ThenShouldReturnDatabaseSaveError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.setData(path: .any, firestoreData: .any, willReturn: DatabaseError.saveError))
        
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.saveUserEmail(userId: "userId", userEmail: "userEmail")
        
        // THEN
        XCTAssertEqual(error, DatabaseError.saveError)
    }
    
    func test_saveUser_GivenNoError_ThenShouldReturnNil() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.setData(path: .any, firestoreData: .any, willReturn: nil))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.saveUser(userId: "userId", userEmail: "userEmail")
        
        // THEN
        XCTAssertNil(error)
    }
    
    func test_saveUser_GivenErrorSavingUserEmail_ThenShouldReturnDatabaseSaveError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.setData(path: "users", firestoreData: .any, willReturn: DatabaseError.saveError))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.saveUser(userId: "userId", userEmail: "userEmail")
        
        // THEN
        XCTAssertEqual(error, DatabaseError.saveError)
    }
    
    func test_gameIsInDatabase_GivenNoErrorFetchingDataAndGameIdIsFound_ThenShouldReturnTrue() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.getData(mainPath: .any, willReturn: .success(MockData.firestoreGamesCorrectData)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let result = await firestoreDatabase.gameIsInDatabase(userId: "userId", savedGame: MockData.firestoreGamesResultConverted[0])
        
        // THEN
        XCTAssertEqual(result, .success(true))
    }
    
    func test_gameIsInDatabase_GivenNoErrorFetchingDataAndGameIdIsNotFound_ThenShouldReturnFalse() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.getData(mainPath: .any, willReturn: .success(MockData.firestoreGamesCorrectData)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        let newSavedGame = SavedGame(game: Game(title: "title", description: "description", id: "wrongid", platformId: 1, imageUrl: "url", releaseDate: Date.now), acquisitionYear: nil, gameCondition: nil, gameCompleteness: nil, gameRegion: nil, storageArea: nil, rating: 0, notes: nil, lastUpdated: Date.now, isPhysical: true)
        
        // WHEN
        let result = await firestoreDatabase.gameIsInDatabase(userId: "userId", savedGame: newSavedGame)
        
        // THEN
        XCTAssertEqual(result, .success(false))
    }
    
    func test_gameIsInDatabase_GivenErrorFetchingData_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.getData(mainPath: .any, willReturn: .failure(DatabaseError.fetchError)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let result = await firestoreDatabase.gameIsInDatabase(userId: "userId", savedGame: MockData.firestoreGamesResultConverted[0])
        
        // THEN
        XCTAssertEqual(result, .failure(DatabaseError.fetchError))
    }
    
    func test_getApiKey_GivenNoError_ThenShouldReturnKeyAsAString() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.getSingleData(path: .any, directory: .any, willReturn: .success(MockData.firestoreCorrectApiKey)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let result = await firestoreDatabase.getApiKey()
        
        // THEN
        XCTAssertEqual(result, .success("apiKey"))
    }
    
    func test_getApiKey_GivenErrorWithFetchedKey_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.getSingleData(path: .any, directory: .any, willReturn: .success(MockData.firestoreIncorrectApiKey)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let result = await firestoreDatabase.getApiKey()
        
        // THEN
        XCTAssertEqual(result, .failure(DatabaseError.fetchError))
    }
    
    func test_getApiKey_GivenFetchError_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.getSingleData(path: .any, directory: .any, willReturn: .failure(DatabaseError.fetchError)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let result = await firestoreDatabase.getApiKey()
        
        // THEN
        XCTAssertEqual(result, .failure(DatabaseError.fetchError))
    }
    
    func test_savePlatform_GivenNoError_ThenShouldReturnNil() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.setData(path: .any, firestoreData: .any, willReturn: nil))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.savePlatform(userId: "userId", platform: MockData.platform)
        
        // THEN
        XCTAssertNil(error)
    }
    
    func test_savePlatform_GivenErrorSavingPlatform_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.setData(path: .any, firestoreData: .any, willReturn: DatabaseError.saveError))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.savePlatform(userId: "userId", platform: MockData.platform)
        
        // THEN
        XCTAssertEqual(error, DatabaseError.saveError)
    }

    func test_saveGame_GivenEditingEntryTrueAndNoError_ThenShouldReturnNil() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.setData(path: .any, firestoreData: .any, willReturn: nil))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.saveGame(userId: "userId", game: MockData.savedGame, platform: MockData.platform, editingEntry: true)
        
        // THEN
        XCTAssertNil(error)
    }
    
    func test_saveGame_GivenEditingEntryFalseAndNoError_ThenShouldReturnNil() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.getData(mainPath: .any, willReturn: .success(MockData.firestoreGamesCorrectData)))
        firestoreSession.given(.setData(path: .any, firestoreData: .any, willReturn: nil))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.saveGame(userId: "userId", game: MockData.savedGame, platform: MockData.platform, editingEntry: false)
        
        // THEN
        XCTAssertNil(error)
    }
    
    func test_saveGame_GivenEditingEntryFalseAndItemAlreadySaved_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.getData(mainPath: .any, willReturn: .success(MockData.firestoreGamesCorrectData)))
        firestoreSession.given(.setData(path: .any, firestoreData: .any, willReturn: nil))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.saveGame(userId: "userId", game: MockData.firestoreGamesResultConverted[0], platform: MockData.platform, editingEntry: false)
        
        // THEN
        XCTAssertEqual(error, DatabaseError.itemAlreadySaved)
    }
    
    func test_saveGame_GivenEditingEntryTrueAndErrorSavingPlatform_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.setData(path: .value(MockData.userPlatformsPath), firestoreData: .any, willReturn: DatabaseError.saveError))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.saveGame(userId: "userId", game: MockData.savedGame, platform: MockData.platform, editingEntry: true)
        
        // THEN
        XCTAssertEqual(error, DatabaseError.saveError)
    }
    
    func test_saveGame_GivenEditingEntryTrueAndErrorSavingGames_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.setData(path: .value(MockData.userPlatformsPath), firestoreData: .any, willReturn: nil))
        firestoreSession.given(.setData(path: .value(MockData.userGamesPath), firestoreData: .any, willReturn: DatabaseError.saveError))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.saveGame(userId: "userId", game: MockData.savedGame, platform: MockData.platform, editingEntry: true)
        
        // THEN
        XCTAssertEqual(error, DatabaseError.saveError)
    }
    
    func test_saveGames_GivenNoError_ThenShouldReturnNil() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.setData(path: .any, firestoreData: .any, willReturn: nil))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.saveGames(userId: "userId", platform: MockData.platform)
        
        // THEN
        XCTAssertNil(error)
    }
    
    func test_saveGames_GivenErrorSavingPlatform_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.setData(path: .value(MockData.userPlatformsPath), firestoreData: .any, willReturn: DatabaseError.saveError))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.saveGames(userId: "userId", platform: MockData.platform)
        
        // THEN
        XCTAssertEqual(error, DatabaseError.saveError)
    }
    
    func test_saveGames_GivenNoErrorAndEmptyCollection_ThenShouldReturnNil() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.setData(path: .value(MockData.userPlatformsPath), firestoreData: .any, willReturn: nil))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        let emptyCollection = Platform(title: "title", id: 1, imageUrl: "url", games: nil, supportedNames: ["supported name"])
        
        // WHEN
        let error = await firestoreDatabase.saveGames(userId: "userId", platform: emptyCollection)
        
        // THEN
        XCTAssertNil(error)
    }
    
    func test_saveGames_GivenErrorSavingGames_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.setData(path: .value(MockData.userPlatformsPath), firestoreData: .any, willReturn: nil))
        firestoreSession.given(.setData(path: .value(MockData.userGamesPath), firestoreData: .any, willReturn: DatabaseError.saveError))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.saveGames(userId: "userId", platform: MockData.platform)
        
        // THEN
        XCTAssertEqual(error, DatabaseError.saveError)
    }
    
    func test_saveCollection_GivenNoError_ThenShouldReturnNil() async {
        // GIVEN
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllPlatforms(willReturn: .success(MockData.platformsCollected)))
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.setData(path: .any, firestoreData: .any, willReturn: nil))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.saveCollection(userId: "userId", localDatabase: localDatabase)
        
        // THEN
        XCTAssertNil(error)
    }
    
    func test_saveCollection_GivenErrorFetchingLocalData_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllPlatforms(willReturn: .failure(DatabaseError.fetchError)))
        let firestoreSession = FirestoreSessionMock()
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.saveCollection(userId: "userId", localDatabase: localDatabase)
        
        // THEN
        XCTAssertEqual(error, DatabaseError.saveError)
    }
    
    func test_saveCollection_GivenErrorSavingGames_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllPlatforms(willReturn: .success(MockData.platformsCollected)))
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.setData(path: .any, firestoreData: .any, willReturn: DatabaseError.saveError))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.saveCollection(userId: "userId", localDatabase: localDatabase)
        
        // THEN
        XCTAssertEqual(error, DatabaseError.saveError)
    }
    
    func test_removePlatform_GivenNoError_ThenShouldReturnNil() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.deleteData(path: .any, directory: .any, willReturn: nil))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.removePlatform(userId: "userId", platform: MockData.platform)
        
        // THEN
        XCTAssertNil(error)
    }
    
    func test_removePlatform_GivenErrorDeletingData_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.deleteData(path: .any, directory: .any, willReturn: DatabaseError.removeError))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.removePlatform(userId: "userId", platform: MockData.platform)
        
        // THEN
        XCTAssertEqual(error, DatabaseError.removeError)
    }
    
    func test_removeGame_GivenNoError_ThenShouldReturnNil() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.deleteData(path: .any, directory: .any, willReturn: nil))
        firestoreSession.given(.getData(mainPath: .any, willReturn: .success(MockData.firestoreGamesCorrectData)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.removeGame(userId: "userId", platform: MockData.platform, savedGame: MockData.savedGame)
        
        // THEN
        XCTAssertNil(error)
    }
    
    func test_removeGame_GivenErrorDeletingGame_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.deleteData(path: .any, directory: .any, willReturn: DatabaseError.removeError))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.removeGame(userId: "userId", platform: MockData.platform, savedGame: MockData.savedGame)
        
        // THEN
        XCTAssertEqual(error, DatabaseError.removeError)
    }
    
    func test_removeGame_GivenErrorFetchingRemainingGames_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.deleteData(path: .value(MockData.userGamesPath), directory: .any, willReturn: nil))
        firestoreSession.given(.getData(mainPath: .any, willReturn: .failure(DatabaseError.fetchError)))
        
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.removeGame(userId: "userId", platform: MockData.platform, savedGame: MockData.savedGame)
        
        // THEN
        XCTAssertEqual(error, DatabaseError.removeError)
    }
    
    func test_removeGame_GivenErrorDeletingPlatformWithNoGame_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.deleteData(path: .value(MockData.userGamesPath), directory: .any, willReturn: nil))
        firestoreSession.given(.getData(mainPath: .any, willReturn: .success(MockData.firestoreEmptyData)))
        firestoreSession.given(.deleteData(path: .value(MockData.userPlatformsPath), directory: .any, willReturn: DatabaseError.removeError))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.removeGame(userId: "userId", platform: MockData.platform, savedGame: MockData.savedGame)
        
        // THEN
        XCTAssertEqual(error, DatabaseError.removeError)
    }
    
    func test_removeGame_GivenNoErrorDeletingPlatformWithNoGame_ThenShouldReturnNil() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.deleteData(path: .value(MockData.userGamesPath), directory: .any, willReturn: nil))
        firestoreSession.given(.getData(mainPath: .any, willReturn: .success(MockData.firestoreEmptyData)))
        firestoreSession.given(.deleteData(path: .value(MockData.userPlatformsPath), directory: .any, willReturn: nil))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.removeGame(userId: "userId", platform: MockData.platform, savedGame: MockData.savedGame)
        
        // THEN
        XCTAssertNil(error)
    }
   
    func test_removeUser_GivenNoError_ThenShouldReturnNil() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.deleteData(path: .any, directory: .any, willReturn: nil))
        firestoreSession.given(.getData(mainPath: .value(MockData.userGamesPath), willReturn: .success(MockData.firestoreGamesCorrectData)))
        firestoreSession.given(.getData(mainPath: .value(MockData.userPlatformsPath), willReturn: .success(MockData.firestorePlatformsCorrectData)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.removeUser(userId: "userId")
        
        // THEN
        XCTAssertNil(error)
    }
    
    func test_removeUser_GivenErrorFetchingData_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.deleteData(path: .any, directory: .any, willReturn: nil))
        firestoreSession.given(.getData(mainPath: .any, willReturn: .failure(DatabaseError.fetchError)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.removeUser(userId: "userId")
        
        // THEN
        XCTAssertEqual(error, DatabaseError.fetchError)
    }
    
    func test_removeUser_GivenErrorRemovingGames_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.deleteData(path: .value(MockData.userGamesPath), directory: .any, willReturn: DatabaseError.removeError))
        firestoreSession.given(.getData(mainPath: .value(MockData.userGamesPath), willReturn: .success(MockData.firestoreGamesCorrectData)))
        firestoreSession.given(.getData(mainPath: .value(MockData.userPlatformsPath), willReturn: .success(MockData.firestorePlatformsCorrectData)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.removeUser(userId: "userId")
        
        // THEN
        XCTAssertEqual(error, DatabaseError.removeError)
    }
    
    func test_removeUser_GivenErrorRemovingPlatforms_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.deleteData(path: .value(MockData.userGamesPath), directory: .any, willReturn: nil))
        firestoreSession.given(.deleteData(path: .value(MockData.userPlatformsPath), directory: .any, willReturn: DatabaseError.removeError))
        firestoreSession.given(.getData(mainPath: .value(MockData.userGamesPath), willReturn: .success(MockData.firestoreGamesCorrectData)))
        firestoreSession.given(.getData(mainPath: .value(MockData.userPlatformsPath), willReturn: .success(MockData.firestorePlatformsCorrectData)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.removeUser(userId: "userId")
        
        // THEN
        XCTAssertEqual(error, DatabaseError.removeError)
    }
    
    func test_removeUser_GivenErrorRemovingUser_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let firestoreSession = FirestoreSessionMock()
        firestoreSession.given(.deleteData(path: .value(MockData.userGamesPath), directory: .any, willReturn: nil))
        firestoreSession.given(.deleteData(path: .value(MockData.userPlatformsPath), directory: .any, willReturn: nil))
        firestoreSession.given(.deleteData(path: .value(MockData.userPath), directory: .any, willReturn: DatabaseError.removeError))
        firestoreSession.given(.getData(mainPath: .value(MockData.userGamesPath), willReturn: .success(MockData.firestoreGamesCorrectData)))
        firestoreSession.given(.getData(mainPath: .value(MockData.userPlatformsPath), willReturn: .success(MockData.firestorePlatformsCorrectData)))
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        
        // WHEN
        let error = await firestoreDatabase.removeUser(userId: "userId")
        
        // THEN
        XCTAssertEqual(error, DatabaseError.removeError)
    }
    
    func test_syncLocalAndCloudDatabases_GivenNoError_ThenShouldReturnNil() async {
        // GIVEN
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.removeAll(willReturn: nil))
        localDatabase.given(.add(newEntity: .any, platform: .any, willReturn: nil))
        let firestoreSession = FirestoreSessionMock()
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        firestoreSession.given(.getData(mainPath: .value(MockData.userGamesPath), willReturn: .success(MockData.firestoreGamesCorrectData)))
        firestoreSession.given(.getData(mainPath: .value(MockData.userPlatformsPath), willReturn: .success(MockData.firestorePlatformsCorrectData)))
        
        // WHEN
        let error = await firestoreDatabase.syncLocalAndCloudDatabases(userId: "userId", localDatabase: localDatabase)
        
        // THEN
        XCTAssertNil(error)
    }
    
    func test_syncLocalAndCloudDatabases_GivenErrorAddingDataToLocal_ThenShouldReturnNil() async {
        // GIVEN
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.removeAll(willReturn: nil))
        localDatabase.given(.add(newEntity: .any, platform: .any, willReturn: DatabaseError.saveError))
        let firestoreSession = FirestoreSessionMock()
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        firestoreSession.given(.getData(mainPath: .value(MockData.userGamesPath), willReturn: .success(MockData.firestoreGamesCorrectData)))
        firestoreSession.given(.getData(mainPath: .value(MockData.userPlatformsPath), willReturn: .success(MockData.firestorePlatformsCorrectData)))
        
        // WHEN
        let error = await firestoreDatabase.syncLocalAndCloudDatabases(userId: "userId", localDatabase: localDatabase)
        
        // THEN
        XCTAssertEqual(error, DatabaseError.saveError)
    }
    
    func test_syncLocalAndCloudDatabases_GivenErrorRemovingLocalData_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.removeAll(willReturn: DatabaseError.removeError))
        let firestoreSession = FirestoreSessionMock()
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        firestoreSession.given(.getData(mainPath: .value(MockData.userGamesPath), willReturn: .success(MockData.firestoreGamesCorrectData)))
        firestoreSession.given(.getData(mainPath: .value(MockData.userPlatformsPath), willReturn: .success(MockData.firestorePlatformsCorrectData)))
        
        // WHEN
        let error = await firestoreDatabase.syncLocalAndCloudDatabases(userId: "userId", localDatabase: localDatabase)
        
        // THEN
        XCTAssertEqual(error, DatabaseError.removeError)
    }
    
    func test_syncLocalAndCloudDatabases_GivenFetchError_ThenShouldReturnDatabaseError() async {
        // GIVEN
        let localDatabase = LocalDatabaseMock()
        let firestoreSession = FirestoreSessionMock()
        let firestoreDatabase = FirestoreDatabase(firestoreSession: firestoreSession)
        firestoreSession.given(.getData(mainPath: .any, willReturn: .failure(DatabaseError.fetchError)))
        
        // WHEN
        let error = await firestoreDatabase.syncLocalAndCloudDatabases(userId: "userId", localDatabase: localDatabase)
        
        // THEN
        XCTAssertEqual(error, DatabaseError.fetchError)
    }
}
