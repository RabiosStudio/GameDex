//
//  AddGameDetailsViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 05/09/2023.
//

import XCTest
@testable import GameDex
import SwiftyMocky

final class AddGameDetailsViewModelTests: XCTestCase {
    
    // MARK: Setup
    
    override class func setUp() {
        super.setUp()
        Matcher.default.register(
            AlertViewModel.self,
            match: Matcher.AlertViewModel.matcher
        )
    }
    
    // MARK: Tests
    
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let viewModel = AddGameDetailsViewModel(
            game: MockData.game,
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: AlertDisplayerMock(),
            authenticationService: AuthenticationServiceMock()
        )
        
        // Then
        XCTAssertEqual(viewModel.sections.count, 1)
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 8)
    }
    
    func test_loadData_ThenCallBackIsCalled() {
        // Given
        let viewModel  = AddGameDetailsViewModel(
            game: MockData.game,
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: AlertDisplayerMock(),
            authenticationService: AuthenticationServiceMock()
        )
        
        var callbackIsCalled = false
        // When
        viewModel.loadData { _ in
            callbackIsCalled = true
        }
        XCTAssertTrue(callbackIsCalled)
    }
    
    func test_didTapPrimaryButton_GivenLocalDatabaseNoError_ThenNavigationStyleIsDismissAndAlertParametersAreCorrect() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        
        let viewModel  = AddGameDetailsViewModel(
            game: MockData.game,
            platform: MockData.platform,
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            myCollectionDelegate: myCollectionDelegate,
            alertDisplayer: alertDisplayer,
            authenticationService: authenticationService
        )
        
        localDatabase.given(
            .add(
                newEntity: .any,
                platform: .any,
                willReturn: nil
            )
        )
        
        // When
        await viewModel.didTapPrimaryButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.saveGameSuccessDescription
                    )
                )
            )
        )
        
        myCollectionDelegate.verify(.reloadCollection())
        if case .dismiss = Routing.shared.lastNavigationStyle {
            XCTAssertTrue(true)
        } else {
            XCTFail("Wrong navigation style")
        }
    }
    
    func test_didTapPrimaryButton_GivenLocalDatabaseSaveError_ThenAlertParametersAreSetCorrectly() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        let alertDisplayer = AlertDisplayerMock()
        let authenticationService = AuthenticationServiceMock()
        
        let viewModel  = AddGameDetailsViewModel(
            game: MockData.game,
            platform: MockData.platform,
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: alertDisplayer,
            authenticationService: authenticationService
        )
        
        authenticationService.given(
            .getUserId(
                willReturn: nil
            )
        )
        
        localDatabase.given(
            .add(
                newEntity: .any,
                platform: .any,
                willReturn: DatabaseError.saveError
            )
        )
        
        // When
        await viewModel.didTapPrimaryButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.saveGameErrorDescription
                    )
                )
            )
        )
        
    }
    
    func test_didTapPrimaryButton_GivenLocalDatabaseItemAlreadySavedError_ThenAlertParametersAreSetCorrectly() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        let alertDisplayer = AlertDisplayerMock()
        let authenticationService = AuthenticationServiceMock()
        
        let viewModel  = AddGameDetailsViewModel(
            game: MockData.game,
            platform: MockData.platform,
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: alertDisplayer,
            authenticationService: authenticationService
        )
        
        authenticationService.given(
            .getUserId(
                willReturn: nil
            )
        )
        
        localDatabase.given(
            .add(
                newEntity: .any,
                platform: .any,
                willReturn: DatabaseError.itemAlreadySaved
            )
        )
        
        // When
        await viewModel.didTapPrimaryButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .warning,
                        description: L10n.warningGameAlreadyInDatabase
                    )
                )
            )
        )
    }
    
    func test_didTapPrimaryButton_GivenCloudDatabaseNoError_ThenNavigationStyleIsDismissAndAlertParametersAreCorrect() async {
        // Given
        let cloudDatabase = CloudDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        
        let viewModel  = AddGameDetailsViewModel(
            game: MockData.game,
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            myCollectionDelegate: myCollectionDelegate,
            alertDisplayer: alertDisplayer,
            authenticationService: authenticationService
        )
        
        authenticationService.given(
            .getUserId(
                willReturn: "userId"
            )
        )
        
        cloudDatabase.given(
            .gameIsInDatabase(
                userId: .any,
                savedGame: .any,
                willReturn: .success(false)
            )
        )
        
        cloudDatabase.given(
            .saveGame(
                userId: .any,
                game: .any,
                platformName: .any,
                editingEntry: .value(false),
                willReturn: nil
            )
        )
        
        // When
        await viewModel.didTapPrimaryButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.saveGameSuccessDescription
                    )
                )
            )
        )
        
        myCollectionDelegate.verify(.reloadCollection())
        if case .dismiss = Routing.shared.lastNavigationStyle {
            XCTAssertTrue(true)
        } else {
            XCTFail("Wrong navigation style")
        }
    }
    
    func test_didTapPrimaryButton_GivenCloudDatabaseSaveError_ThenAlertParametersAreSetCorrectly() async {
        // Given
        let cloudDatabase = CloudDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        
        let viewModel  = AddGameDetailsViewModel(
            game: MockData.game,
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            myCollectionDelegate: myCollectionDelegate,
            alertDisplayer: alertDisplayer,
            authenticationService: authenticationService
        )
        
        authenticationService.given(
            .getUserId(
                willReturn: "userId"
            )
        )
        
        cloudDatabase.given(
            .gameIsInDatabase(
                userId: .any,
                savedGame: .any,
                willReturn: .success(false)
            )
        )
        
        cloudDatabase.given(
            .saveGame(
                userId: .any,
                game: .any,
                platformName: .any,
                editingEntry: .value(false),
                willReturn: DatabaseError.saveError
            )
        )
        
        // When
        await viewModel.didTapPrimaryButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.saveGameErrorDescription
                    )
                )
            )
        )
    }
    
    func test_didTapPrimaryButton_GivenCloudDatabaseItemAlreadySavedError_ThenAlertParametersAreSetCorrectly() async {
        // Given
        let cloudDatabase = CloudDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        
        let viewModel  = AddGameDetailsViewModel(
            game: MockData.game,
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            myCollectionDelegate: myCollectionDelegate,
            alertDisplayer: alertDisplayer,
            authenticationService: authenticationService
        )
        
        authenticationService.given(
            .getUserId(
                willReturn: "userId"
            )
        )
        
        cloudDatabase.given(
            .gameIsInDatabase(
                userId: .any,
                savedGame: .any,
                willReturn: .success(true)
            )
        )
        
        cloudDatabase.given(
            .saveGame(
                userId: .any,
                game: .any,
                platformName: .any,
                editingEntry: .value(false),
                willReturn: DatabaseError.itemAlreadySaved
            )
        )
        
        // When
        await viewModel.didTapPrimaryButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .warning,
                        description: L10n.warningGameAlreadyInDatabase
                    )
                )
            )
        )
    }
    
    func test_didTapRightButtonItem_ThenShouldSetNavigationStyleCorrectlyAndCallmyCollectionDelegate() {
        // Given
        let localDatabase = LocalDatabaseMock()
        let alertDisplayer = AlertDisplayerMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        
        let viewModel  = AddGameDetailsViewModel(
            game: MockData.game,
            platform: MockData.platform,
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            myCollectionDelegate: myCollectionDelegate,
            alertDisplayer: alertDisplayer,
            authenticationService: AuthenticationServiceMock()
        )
        
        // When
        viewModel.didTapRightButtonItem()
        
        // Then
        let expectedNavigationStyle: NavigationStyle = {
            return .dismiss(completionBlock: nil)
        }()
        let lastNavigationStyle = Routing.shared.lastNavigationStyle
        
        XCTAssertEqual(lastNavigationStyle, expectedNavigationStyle)
    }
}

