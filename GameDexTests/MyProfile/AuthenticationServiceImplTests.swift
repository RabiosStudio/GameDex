//
//  AuthenticationServiceImplTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 12/10/2023.
//

import XCTest
@testable import GameDex

final class AuthenticationServiceImplTests: XCTestCase {
    
    func test_login_GivenLoginAndDataSyncSuccessfull_ThenShouldReturnNil() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(
            .logIn(
                email: .any,
                password: .any,
                willReturn: nil
            )
        )
        authSession.given(.getUserUid(willReturn: MockData.userId))
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(
            .syncLocalAndCloudDatabases(
                userId: .any,
                localDatabase: .any,
                willReturn: nil
            )
        )
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.login(email: MockData.email, password: MockData.password, cloudDatabase: cloudDatabase, localDatabase: LocalDatabaseMock())
        
        XCTAssertNil(error)
    }
    
    func test_login_GivenLoginSuccessButDataSyncError_ThenShouldReturnSaveUserDataError() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(
            .logIn(
                email: .any,
                password: .any,
                willReturn: nil
            )
        )
        authSession.given(.getUserUid(willReturn: MockData.userId))
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(
            .syncLocalAndCloudDatabases(
                userId: .any,
                localDatabase: .any,
                willReturn: DatabaseError.saveError
            )
        )
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.login(email: MockData.email, password: MockData.password, cloudDatabase: cloudDatabase, localDatabase: LocalDatabaseMock())
        
        XCTAssertEqual(error, AuthenticationError.saveUserDataError)
    }
    
    func test_login_GivenFailedLogin_ThenShouldReturnLoginError() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(
            .logIn(
                email: .any,
                password: .any,
                willReturn: AuthenticationError.loginError
            )
        )
        authSession.given(.getUserUid(willReturn: MockData.userId))
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.login(email: MockData.email, password: MockData.password, cloudDatabase: CloudDatabaseMock(), localDatabase: LocalDatabaseMock())
        
        XCTAssertEqual(error, AuthenticationError.loginError)
    }
    
    func test_createUser_GivenAccountCreationAndSavingDataSuccessfull_ThenShouldReturnNil() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(
            .createUser(
                email: .any,
                password: .any,
                willReturn: nil
            )
        )
        authSession.given(.getUserUid(willReturn: MockData.userId))
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(
            .saveUser(
                userId: .any,
                userEmail: .any,
                willReturn: nil
            )
        )
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.createUser(email: MockData.email, password: MockData.password, cloudDatabase: cloudDatabase)
        
        XCTAssertNil(error)
    }
    
    func test_createUser_GivenAccountCreationSuccessButSavingDataError_ThenShouldReturnSaveUserDataError() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(
            .createUser(
                email: .any,
                password: .any,
                willReturn: nil
            )
        )
        authSession.given(.getUserUid(willReturn: MockData.userId))
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(
            .saveUser(
                userId: .any,
                userEmail: .any,
                willReturn: DatabaseError.saveError
            )
        )
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.createUser(email: MockData.email, password: MockData.password, cloudDatabase: cloudDatabase)
        
        XCTAssertEqual(error, AuthenticationError.saveUserDataError)
    }
    
    func test_createUser_GivenFailedAccountCreation_ThenShouldReturnCreateAccountError() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(
            .createUser(
                email: .any,
                password: .any,
                willReturn: AuthenticationError.createAccountError
            )
        )
        authSession.given(.getUserUid(willReturn: nil))
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.createUser(email: MockData.email, password: MockData.password, cloudDatabase: CloudDatabaseMock())
        
        XCTAssertEqual(error, AuthenticationError.createAccountError)
    }
    
    func test_logout_GivenSuccess_ThenShouldReturnNil() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(.logOut(willReturn: nil))
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.logout()
        XCTAssertNil(error)
    }
    
    func test_logout_GivenFailure_ThenShouldReturnNil() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(.logOut(willReturn: AuthenticationError.logoutError))
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.logout()
        XCTAssertEqual(error, AuthenticationError.logoutError)
    }
    
    func test_isUserLoggedIn_GivenAuthSessionReturnsId_ThenReturnTrue() {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(.getUserUid(willReturn: MockData.userId))
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let isLoggedIn = authenticationService.isUserLoggedIn()
        XCTAssertTrue(isLoggedIn)
    }
    
    func test_isUserLoggedIn_GivenAuthSessionReturnsNil_ThenReturnFalse() {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(.getUserUid(willReturn: nil))
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let isLoggedIn = authenticationService.isUserLoggedIn()
        XCTAssertFalse(isLoggedIn)
    }
    
    func test_getUserId_GivenAuthSessionReturnsId_ThenShouldReturnId() {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(.getUserUid(willReturn: MockData.userId))
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let userId = authenticationService.getUserId()
        XCTAssertEqual(userId, MockData.userId)
    }
    
    func test_getUserId_GivenAuthSessionReturnsNil_ThenShouldReturnNil() {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(.getUserUid(willReturn: nil))
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let userId = authenticationService.getUserId()
        XCTAssertNil(userId)
    }
    
    func test_updateUserEmailAddress_GivenNoError_ThenShouldReturnNil() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(.updateUserEmailAddress(to: .any, willReturn: nil))
        authSession.given(.getUserUid(willReturn: "userId"))
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(.saveUserEmail(userId: .any, userEmail: .any, willReturn: nil))
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.updateUserEmailAddress(to: "email", cloudDatabase: cloudDatabase)
        
        // Then
        XCTAssertNil(error)
    }
        
    func test_updateUserEmailAddress_GivenAuthSessionError_ThenShouldReturnSaveUserDataError() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(.updateUserEmailAddress(to: .any, willReturn: AuthenticationError.saveUserDataError))
        let cloudDatabase = CloudDatabaseMock()
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.updateUserEmailAddress(to: "email", cloudDatabase: cloudDatabase)
        
        // Then
        XCTAssertEqual(error, AuthenticationError.saveUserDataError)
    }
    
    func test_updateUserEmailAddress_GivenCloudDatabaseError_ThenShouldReturnNil() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(.updateUserEmailAddress(to: .any, willReturn: nil))
        authSession.given(.getUserUid(willReturn: "userId"))
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(.saveUserEmail(userId: .any, userEmail: .any, willReturn: DatabaseError.saveError))
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.updateUserEmailAddress(to: "email", cloudDatabase: cloudDatabase)
        
        // Then
        XCTAssertNil(error)
    }
    
    func test_updateUserPassword_GivenNoError_ThenShouldReturnNil() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(.updateUserPassword(to: .any, willReturn: nil))
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.updateUserPassword(to: "password")
        
        // Then
        XCTAssertNil(error)
    }
    
    func test_updateUserPassword_GivenAuthSessionError_ThenShouldReturnSaveUserDataError() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(.updateUserPassword(to: .any, willReturn: AuthenticationError.saveUserDataError))
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.updateUserPassword(to: "password")
        
        // Then
        XCTAssertEqual(error, AuthenticationError.saveUserDataError)
    }
    
    func test_reauthenticateUser_GivenNoError_ThenShouldReturnNil() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(.reauthenticate(email: .any, password: .any, willReturn: nil))
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.reauthenticateUser(email: "email", password: "password")
        
        // Then
        XCTAssertNil(error)
    }
    
    func test_reauthenticateUser_GivenAuthSessionError_ThenShouldReturnLoginError() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(.reauthenticate(email: .any, password: .any, willReturn: AuthenticationError.loginError))
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.reauthenticateUser(email: "email", password: "password")
        
        // Then
        XCTAssertEqual(error, AuthenticationError.loginError)
    }
    
    func test_deleteUser_GivenNoError_ThenShouldReturnNil() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(.deleteUser(willReturn: nil))
        authSession.given(.getUserUid(willReturn: "userId"))
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(.saveUserEmail(userId: .any, userEmail: .any, willReturn: nil))
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.deleteUser(cloudDatabase: cloudDatabase)
        
        // Then
        XCTAssertNil(error)
    }
    
    func test_deleteUser_GivenAuthSessionError_ThenShouldReturnDeleteUserError() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(.deleteUser(willReturn: AuthenticationError.deleteUserError))
        let cloudDatabase = CloudDatabaseMock()
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.deleteUser(cloudDatabase: cloudDatabase)
        
        // Then
        XCTAssertEqual(error, AuthenticationError.deleteUserError)
    }
    
    func test_deleteUser_GivenCloudDatabaseError_ThenShouldReturnNil() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(.deleteUser(willReturn: nil))
        authSession.given(.getUserUid(willReturn: "userId"))
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(.removeUser(userId: .any, willReturn: DatabaseError.removeError))
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.deleteUser(cloudDatabase: cloudDatabase)
        
        // Then
        XCTAssertNil(error)
    }
    
    func test_sendPasswordResetEmail_GivenNoError_ThenShouldReturnNil() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(.sendPasswordResetEmail(email: "email", willReturn: nil))
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.sendPasswordResetEmail(userEmail: "email")
        
        // Then
        XCTAssertNil(error)
    }
    
    func test_sendPasswordResetEmail_GivenErrorSendingEmail_ThenShouldReturnPasswordResetEmailError() async {
        // Given
        let authSession = AuthSessionMock()
        authSession.given(.sendPasswordResetEmail(email: "email", willReturn: AuthenticationError.passwordResetEmailError))
        let authenticationService = AuthenticationServiceImpl(authSession: authSession)
        
        // When
        let error = await authenticationService.sendPasswordResetEmail(userEmail: "email")
        
        // Then
        XCTAssertEqual(error, AuthenticationError.passwordResetEmailError)
    }
}
