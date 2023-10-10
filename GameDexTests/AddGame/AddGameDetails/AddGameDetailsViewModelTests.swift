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
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: AlertDisplayerMock()
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
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: AlertDisplayerMock()
        )
        
        var callbackIsCalled = false
        // When
        viewModel.loadData { _ in
            callbackIsCalled = true
        }
        XCTAssertTrue(callbackIsCalled)
    }
    
    func test_didTapPrimaryButton_GivenNoError_ThenNavigationStyleIsDismissAndAlertParametersAreCorrect() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        let alertDisplayer = AlertDisplayerMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        
        let viewModel  = AddGameDetailsViewModel(
            game: MockData.game,
            platform: MockData.platform,
            localDatabase: localDatabase,
            myCollectionDelegate: myCollectionDelegate,
            alertDisplayer: alertDisplayer
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
    
    func test_didTapPrimaryButton_GivenDatabaseSaveError_ThenAlertParametersAreSetCorrectly() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        let alertDisplayer = AlertDisplayerMock()
        
        let viewModel  = AddGameDetailsViewModel(
            game: MockData.game,
            platform: MockData.platform,
            localDatabase: localDatabase,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: alertDisplayer
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
    
    func test_didTapPrimaryButton_GivenDatabaseItemAlreadySavedError_ThenAlertParametersAreSetCorrectly() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        let alertDisplayer = AlertDisplayerMock()
        
        let viewModel  = AddGameDetailsViewModel(
            game: MockData.game,
            platform: MockData.platform,
            localDatabase: localDatabase,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: alertDisplayer
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
    
    func test_didTapRightButtonItem_ThenShouldSetNavigationStyleCorrectlyAndCallmyCollectionDelegate() {
        // Given
        let localDatabase = LocalDatabaseMock()
        let alertDisplayer = AlertDisplayerMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        
        let viewModel  = AddGameDetailsViewModel(
            game: MockData.game,
            platform: MockData.platform,
            localDatabase: localDatabase,
            myCollectionDelegate: myCollectionDelegate,
            alertDisplayer: alertDisplayer
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

