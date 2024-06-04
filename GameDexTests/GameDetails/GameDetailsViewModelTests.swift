//
//  GameDetailsViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 04/06/2024.
//

import XCTest
@testable import GameDex
import SwiftyMocky

final class GameDetailsViewModelTests: XCTestCase {
    
    // MARK: Setup
    
    override class func setUp() {
        super.setUp()
        Matcher.default.register(
            AlertViewModel.self,
            match: Matcher.AlertViewModel.matcher
        )
        Matcher.default.register(
            ContentViewFactory.self,
            match: Matcher.ContentViewFactory.matcher
        )
    }
    
    // MARK: Tests
    
    func test_init_ThenShouldNoSectionsAndItems() {
        // Given
        let viewModel = GameDetailsViewModel(
            gameDetailsContext: .edit(savedGame: MockData.savedGame),
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: AuthenticationServiceMock()
        )
        // When
        let numberOfSections = viewModel.numberOfSections()
        let numberOfItems = viewModel.numberOfItems(in: .zero)
        // Then
        XCTAssertEqual(numberOfSections, .zero)
        XCTAssertEqual(numberOfItems, .zero)
    }
    
    func test_loadData_GivenGameDetailsContextAdd_ThenCallBackIsCalledAndSectionsAreSetCorrectly() {
        // Given
        let viewModel = GameDetailsViewModel(
            gameDetailsContext: .add(game: MockData.game),
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: AuthenticationServiceMock()
        )
        
        var callbackIsCalled = false
        
        // When
        viewModel.loadData { _ in
            callbackIsCalled = true
        }
        
        // Then
        XCTAssertTrue(callbackIsCalled)
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 9)
    }
    
    func test_loadData_GivenGameDetailsContextEdit_ThenCallBackIsCalledAndSectionsAreSetCorrectly() {
        // Given
        let viewModel = GameDetailsViewModel(
            gameDetailsContext: .edit(savedGame: MockData.savedGame),
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: AuthenticationServiceMock()
        )
        
        var callbackIsCalled = false
        
        // When
        viewModel.loadData { _ in
            callbackIsCalled = true
        }
        
        // Then
        XCTAssertTrue(callbackIsCalled)
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 9)
    }
    
    func test_didTapPrimaryButton_GivenContextEditAndLocalDatabaseNoError_ThenAlertParametersAreCorrectAndSupplementaryViewConfiguredTwice() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        
        let viewModel = GameDetailsViewModel(
            gameDetailsContext: .edit(savedGame: MockData.savedGame),
            platform: MockData.platform,
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService
        )
        
        authenticationService.given(
            .getUserId(
                willReturn: nil
            )
        )
        
        viewModel.containerDelegate = containerDelegate
        
        viewModel.loadData { _ in }
        
        localDatabase.given(
            .replace(
                savedGame: .any,
                willReturn: nil
            )
        )
        
        // When
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.updateSuccessDescription
                    )
                )
            ), count: .once
        )
        containerDelegate.verify(
            .configureSupplementaryView(
                contentViewFactory: .any
            ), count: 2
        )
    }
    
    func test_didTapPrimaryButton_GivenContextEditAndLocalDatabaseErrorReplacingData_ThenAlertParametersAreCorrectAndSupplementaryViewConfiguredTwice() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        
        let viewModel = GameDetailsViewModel(
            gameDetailsContext: .edit(savedGame: MockData.savedGame),
            platform: MockData.platform,
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService
        )
        
        authenticationService.given(
            .getUserId(
                willReturn: nil
            )
        )
        
        viewModel.containerDelegate = containerDelegate
        
        viewModel.loadData { _ in }
        
        localDatabase.given(
            .replace(
                savedGame: .any,
                willReturn: DatabaseError.replaceError
            )
        )
        
        // When
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.updateErrorDescription
                    )
                )
            ), count: .once
        )
        containerDelegate.verify(
            .configureSupplementaryView(
                contentViewFactory: .any
            ), count: 2
        )
    }
    
    func test_didTapPrimaryButton_GivenContextEditAndCloudDatabaseNoError_ThenAlertParametersAreCorrectAndSupplementaryViewConfiguredTwice() async {
        // Given
        let cloudDatabase = CloudDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        
        let viewModel = GameDetailsViewModel(
            gameDetailsContext: .edit(savedGame: MockData.savedGame),
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService
        )
        
        authenticationService.given(
            .getUserId(
                willReturn: "userId"
            )
        )
        
        viewModel.containerDelegate = containerDelegate
        
        viewModel.loadData { _ in }
        
        cloudDatabase.given(
            .replaceGame(
                userId: .any,
                newGame: .any,
                oldGame: .any,
                platform: .any,
                willReturn: nil
            )
        )
        
        // When
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.updateSuccessDescription
                    )
                )
            ), count: .once
        )
        containerDelegate.verify(
            .configureSupplementaryView(
                contentViewFactory: .any
            ), count: 2
        )
    }
    
    func test_didTapPrimaryButton_GivenContextEditAndCloudDatabaseErrorReplacingData_ThenAlertParametersAreCorrectAndSupplementaryViewConfiguredTwice() async {
        // Given
        let cloudDatabase = CloudDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        
        let viewModel = GameDetailsViewModel(
            gameDetailsContext: .edit(savedGame: MockData.savedGame),
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService
        )
        
        authenticationService.given(
            .getUserId(
                willReturn: "userId"
            )
        )
        
        viewModel.containerDelegate = containerDelegate
        
        viewModel.loadData { _ in }
        
        cloudDatabase.given(
            .replaceGame(
                userId: .any,
                newGame: .any,
                oldGame: .any,
                platform: .any,
                willReturn: DatabaseError.replaceError
            )
        )
        
        // When
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.updateErrorDescription
                    )
                )
            ), count: .once
        )
        containerDelegate.verify(
            .configureSupplementaryView(
                contentViewFactory: .any
            ), count: 2
        )
    }
    
    func test_didTapPrimaryButton_GivenContextAddAndLocalDatabaseNoError_ThenNavigationStyleIsDismissAndAlertParametersAreCorrect() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .getUserId(
                willReturn: nil
            )
        )
        let alertDisplayer = AlertDisplayerMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        
        let viewModel  = GameDetailsViewModel(
            gameDetailsContext: .add(game: MockData.game),
            platform: MockData.platform,
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: myCollectionDelegate,
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
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.saveGameSuccessDescription
                    )
                )
            ), count: .once
        )
        
        myCollectionDelegate.verify(.reloadCollection())
        if case .dismiss = Routing.shared.lastNavigationStyle {
            XCTAssertTrue(true)
        } else {
            XCTFail("Wrong navigation style")
        }
    }
    
    func test_didTapPrimaryButton_GivenContextAddAndLocalDatabaseItemAlreadySavedError_ThenAlertParametersAreSetCorrectly() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        let alertDisplayer = AlertDisplayerMock()
        let authenticationService = AuthenticationServiceMock()
        
        let viewModel  = GameDetailsViewModel(
            gameDetailsContext: .add(game: MockData.game),
            platform: MockData.platform,
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
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
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .warning,
                        description: L10n.warningGameAlreadyInDatabase
                    )
                )
            ), count: .once
        )
    }
    
    func test_didTapPrimaryButton_GivenContextAddAndCloudDatabaseNoError_ThenNavigationStyleIsDismissAndAlertParametersAreCorrect() async {
        // Given
        let cloudDatabase = CloudDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        
        let viewModel  = GameDetailsViewModel(
            gameDetailsContext: .add(game: MockData.game),
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: myCollectionDelegate,
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
                platform: .any,
                willReturn: nil
            )
        )
        
        // When
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.saveGameSuccessDescription
                    )
                )
            ), count: .once
        )
        
        myCollectionDelegate.verify(.reloadCollection())
        if case .dismiss = Routing.shared.lastNavigationStyle {
            XCTAssertTrue(true)
        } else {
            XCTFail("Wrong navigation style")
        }
    }
    
    func test_didTapPrimaryButton_GivenContextAddAndCloudDatabaseSaveError_ThenAlertParametersAreSetCorrectly() async {
        // Given
        let cloudDatabase = CloudDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        
        let viewModel  = GameDetailsViewModel(
            gameDetailsContext: .add(game: MockData.game),
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: myCollectionDelegate,
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
                platform: .any,
                willReturn: DatabaseError.saveError
            )
        )
        
        // When
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.saveGameErrorDescription
                    )
                )
            ), count: .once
        )
    }
    
    func test_didTapPrimaryButton_GivenContextAddAndCloudDatabaseItemAlreadySavedError_ThenAlertParametersAreSetCorrectly() async {
        // Given
        let cloudDatabase = CloudDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        
        let viewModel  = GameDetailsViewModel(
            gameDetailsContext: .add(game: MockData.game),
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: myCollectionDelegate,
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
                platform: .any,
                willReturn: DatabaseError.itemAlreadySaved
            )
        )
        
        // When
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .warning,
                        description: L10n.warningGameAlreadyInDatabase
                    )
                )
            ), count: .once
        )
    }
    
    func test_didTapButtonItem_GivenContextEdit_ThenShouldSetAlertParametersCorrectly() async {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = GameDetailsViewModel(
            gameDetailsContext: .edit(savedGame: MockData.savedGame),
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: AuthenticationServiceMock()
        )
        
        // When
        viewModel.didTap(buttonItem: .delete)
        
        // Then
        alertDisplayer.verify(
            .presentBasicAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .warning,
                        description: L10n.warningRemoveGameDescription
                    )
                )
            ), count: .once
        )
    }
    
    func test_didTapButtonItem_GivenContextAdd_ThenShouldSetNavigationStyleCorrectlyAndCallMyCollectionDelegate() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        let alertDisplayer = AlertDisplayerMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        
        let viewModel  = GameDetailsViewModel(
            gameDetailsContext: .add(game: MockData.game),
            platform: MockData.platform,
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: myCollectionDelegate,
            authenticationService: AuthenticationServiceMock()
        )
        
        // When
        viewModel.didTap(buttonItem: .close)
        
        // Then
        let expectedNavigationStyle: NavigationStyle = {
            return .dismiss(completionBlock: nil)
        }()
        let lastNavigationStyle = Routing.shared.lastNavigationStyle
        
        XCTAssertEqual(lastNavigationStyle, expectedNavigationStyle)
    }
    
    func test_didTapOkButton_GivenContextEditAndLocalRemoveDataError_ThenShouldSetAlertParametersCorrectlyAndCallContainerDelegate() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        
        let viewModel = GameDetailsViewModel(
            gameDetailsContext: .edit(savedGame: MockData.savedGame),
            platform: MockData.platform,
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService
        )
        viewModel.containerDelegate = containerDelegate
        viewModel.alertDelegate = viewModel
        
        authenticationService.given(
            .getUserId(
                willReturn: nil
            )
        )
        
        localDatabase.given(
            .remove(
                savedGame: .any,
                willReturn: DatabaseError.removeError
            )
        )
        
        // When
        await viewModel.didTapOkButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.removeGameErrorDescription
                    )
                )
            ), count: .once
        )
    }
    
    func test_didTapOkButton_GivenContextEditAndLocalNoError_ThenShouldSetAlertParametersCorrectlyAndCallContainerDelegate() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        let viewModel = GameDetailsViewModel(
            gameDetailsContext: .edit(savedGame: MockData.savedGame),
            platform: MockData.platform,
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService
        )
        viewModel.containerDelegate = containerDelegate
        viewModel.alertDelegate = viewModel
        
        authenticationService.given(
            .getUserId(
                willReturn: nil
            )
        )
        
        localDatabase.given(
            .remove(
                savedGame: .any,
                willReturn: nil
            )
        )
        
        // When
        await viewModel.didTapOkButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.removeGameSuccessDescription
                    )
                )
            ), count: .once
        )
        
        containerDelegate.verify(.goBackToPreviousScreen())
    }
    
    func test_didTapOkButton_GivenContextEditAndCloudRemoveDataError_ThenShouldSetAlertParametersCorrectlyAndCallContainerDelegate() async {
        // Given
        let savedGame = MockData.savedGame
        let platform = MockData.platform
        let cloudDatabase = CloudDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        let viewModel = GameDetailsViewModel(
            gameDetailsContext: .edit(savedGame: MockData.savedGame),
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService
        )
        viewModel.containerDelegate = containerDelegate
        viewModel.alertDelegate = viewModel
        
        authenticationService.given(
            .getUserId(
                willReturn: "userId"
            )
        )
        
        cloudDatabase.given(
            .removeGame(
                userId: .any,
                platform: .value(platform),
                savedGame: .value(savedGame),
                willReturn: DatabaseError.removeError
            )
        )
        
        // When
        await viewModel.didTapOkButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.removeGameErrorDescription
                    )
                )
            ), count: .once
        )
    }
    
    func test_didTapOkButton_GivenContextEditAndCloudNoError_ThenShouldSetAlertParametersCorrectlyAndCallContainerDelegate() async {
        // Given
        let cloudDatabase = CloudDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        let viewModel = GameDetailsViewModel(
            gameDetailsContext: .edit(savedGame: MockData.savedGame),
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService
        )
        viewModel.containerDelegate = containerDelegate
        viewModel.alertDelegate = viewModel
        
        authenticationService.given(
            .getUserId(
                willReturn: "userId"
            )
        )
        
        cloudDatabase.given(
            .removeGame(
                userId: .any,
                platform: .value(MockData.platform),
                savedGame: .value(MockData.savedGame),
                willReturn: nil
            )
        )
        
        // When
        await viewModel.didTapOkButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.removeGameSuccessDescription
                    )
                )
            ), count: .once
        )
        containerDelegate.verify(.goBackToPreviousScreen(), count: .once)
    }
    
    func test_didUpdate_GivenContextEditAndCloudNoError_ThenShouldSetAlertParametersCorrectlyAndCallContainerDelegate() async {
        // Given
        let containerDelegate = ContainerViewControllerDelegateMock()
        let viewModel = GameDetailsViewModel(
            gameDetailsContext: .edit(savedGame: MockData.savedGame),
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: AuthenticationServiceMock()
        )
        viewModel.containerDelegate = containerDelegate
        
        // WHEN
        viewModel.didUpdate(value: MockData.editedGameForm.acquisitionYear as Any, for: GameFormType.acquisitionYear)
        viewModel.didUpdate(
            value: MockData.editedGameForm.gameCondition as Any,
            for: GameFormType.gameCondition(
                PickerViewModel(
                    data: [GameCondition.allCases.compactMap {
                        guard $0 != .unknown else {
                            return nil
                        }
                        return $0.value
                    }]
                )
            )
        )
        viewModel.didUpdate(
            value: MockData.editedGameForm.gameCompleteness as Any,
            for: GameFormType.gameCompleteness(
                PickerViewModel(
                    data: [GameCompleteness.allCases.compactMap {
                        guard $0 != .unknown else {
                            return nil
                        }
                        return $0.value
                    }]
                )
            )
        )
        viewModel.didUpdate(
            value: MockData.editedGameForm.gameRegion as Any,
            for: GameFormType.gameRegion(
                PickerViewModel(
                    data: [GameRegion.allCases.map { $0.value }]
                )
            )
        )
        viewModel.didUpdate(value: MockData.editedGameForm.storageArea as Any, for: GameFormType.storageArea)
        viewModel.didUpdate(value: MockData.editedGameForm.rating as Any, for: GameFormType.rating)
        viewModel.didUpdate(value: MockData.editedGameForm.notes as Any, for: GameFormType.notes)
        viewModel.didUpdate(value: MockData.editedGameForm.isPhysical as Any, for: GameFormType.isPhysical)
        
        // THEN
        XCTAssertEqual(viewModel.gameForm.acquisitionYear, MockData.editedGameForm.acquisitionYear)
        XCTAssertEqual(viewModel.gameForm.gameCompleteness, MockData.editedGameForm.gameCompleteness)
        XCTAssertEqual(viewModel.gameForm.gameCondition, MockData.editedGameForm.gameCondition)
        XCTAssertEqual(viewModel.gameForm.gameRegion, MockData.editedGameForm.gameRegion)
        XCTAssertEqual(viewModel.gameForm.storageArea, MockData.editedGameForm.storageArea)
        XCTAssertEqual(viewModel.gameForm.rating, MockData.editedGameForm.rating)
        XCTAssertEqual(viewModel.gameForm.notes, MockData.editedGameForm.notes)
        XCTAssertEqual(viewModel.gameForm.isPhysical, MockData.editedGameForm.isPhysical)
    }
    
    func test_refreshSectionsDependingOnGameFormat_GivenFormatIsUpdated_ThenShouldReloadSections() {
        // Given
        let containerDelegate = ContainerViewControllerDelegateMock()
        let viewModel = GameDetailsViewModel(
            gameDetailsContext: .edit(savedGame: MockData.savedGame),
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: AuthenticationServiceMock()
        )
        viewModel.containerDelegate = containerDelegate
        viewModel.loadData { _ in }
        
        // When
        viewModel.gameForm = MockData.digitalGameForm
        viewModel.refreshSectionsDependingOnGameFormat()
        
        // Then
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 5)
        containerDelegate.verify(.reloadSections(emptyError: .any), count: .once)
    }
}



