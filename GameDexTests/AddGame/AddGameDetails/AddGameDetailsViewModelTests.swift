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
    
    // MARK: Tests
    
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let viewModel = AddGameDetailsViewModel(
            game: MockData.game,
            localDatabase: DatabaseMock(),
            addGameDelegate: AddGameDetailsViewModelDelegateMock(),
            alertDisplayer: AlertServiceMock()
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
            alertDisplayer: AlertServiceMock()
        )
        
        var callbackIsCalled = false
        // When
        viewModel.loadData { _ in
            callbackIsCalled = true
        }
        XCTAssertTrue(callbackIsCalled)
    }
    
    func test_didTapPrimaryButton_ThenNavigationStyleIsDismissAndAlertParametersAreCorrect() {
        // Given
        let expectation = XCTestExpectation()
        let localDatabase = DatabaseMock()
        let alertService = AlertServiceMock()

        let viewModel  = AddGameDetailsViewModel(
            game: MockData.game,
            localDatabase: localDatabase,
            addGameDelegate: AddGameDetailsViewModelDelegateMock(),
            alertDisplayer: alertService
        )
        
        localDatabase.perform(
            .add(
                newEntity: .any,
                callback: .any,
                perform: { saveGame, completion in
                    completion(nil)
                    // Then
                    alertService.verify(
                        .presentAlert(
                            title: .value(L10n.successTitle),
                            description: .value(L10n.gameSavedSuccessTitle),
                            type: .value(.success)
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
        
        // When
        viewModel.didTapPrimaryButton()
        
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
}
