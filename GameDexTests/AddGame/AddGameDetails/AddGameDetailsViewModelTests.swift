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
            localDatabase: DatabaseMock(),
            addGameDelegate: AddGameDetailsViewModelDelegateMock(),
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
            localDatabase: DatabaseMock(),
            addGameDelegate: AddGameDetailsViewModelDelegateMock(),
            alertDisplayer: AlertDisplayerMock()
        )
        
        var callbackIsCalled = false
        // When
        viewModel.loadData { _ in
            callbackIsCalled = true
        }
        XCTAssertTrue(callbackIsCalled)
    }
    
    func test_didTapPrimaryButton_GivenNoError_ThenNavigationStyleIsDismissAndAlertParametersAreCorrect() {
        // Given
        let expectation = XCTestExpectation()
        let localDatabase = DatabaseMock()
        let alertDisplayer = AlertDisplayerMock()
        
        let viewModel  = AddGameDetailsViewModel(
            game: MockData.game,
            localDatabase: localDatabase,
            addGameDelegate: AddGameDetailsViewModelDelegateMock(),
            alertDisplayer: alertDisplayer
        )
        
        localDatabase.perform(
            .add(
                newEntity: .any,
                callback: .any,
                perform: { saveGame, completion in
                    completion(nil)
                    
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
                    
                    if case .dismiss = Routing.shared.lastNavigationStyle {
                        XCTAssertTrue(true)
                    } else {
                        XCTFail("Wrong navigation style")
                    }
                    expectation.fulfill()
                }
            )
        )
        
        viewModel.didTapPrimaryButton()
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func test_didTapPrimaryButton_GivenDatabaseError_ThenAlertParametersAreSetCorrectly() {
        // Given
        let expectation = XCTestExpectation()
        let localDatabase = DatabaseMock()
        let alertDisplayer = AlertDisplayerMock()
        
        let viewModel  = AddGameDetailsViewModel(
            game: MockData.game,
            localDatabase: localDatabase,
            addGameDelegate: AddGameDetailsViewModelDelegateMock(),
            alertDisplayer: alertDisplayer
        )
        
        localDatabase.perform(
            .add(
                newEntity: .any,
                callback: .any,
                perform: { saveGame, completion in
                    completion(DatabaseError.saveError)
                    
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
                    expectation.fulfill()
                }
            )
        )
        
        viewModel.didTapPrimaryButton()
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
}

