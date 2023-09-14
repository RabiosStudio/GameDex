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
    
    
    // MARK: Tests
    
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let viewModel = AddGameDetailsViewModel(
            localDatabase: MockLocalDatabase(
                data: nil,
                response: nil
            )
            game: MockData.game,
        )
        
        // Then
        XCTAssertEqual(viewModel.sections.count, 1)
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 8)
    }
    
    func test_loadData_ThenCallBackIsCalled() {
        // Given
        let viewModel = AddGameDetailsViewModel(
            localDatabase: MockLocalDatabase(
                data: nil,
                response: nil
            )
            game: MockData.game,
        )
        var callbackIsCalled = false
        // When
        viewModel.loadData { _ in
            callbackIsCalled = true
        }
        XCTAssertTrue(callbackIsCalled)
    }
    
    func test_didTapPrimaryButton_GivenErrorSavingGame_ThenContainerDelegateIsCalledOnce() {
        // Given
        let localDatabase = MockLocalDatabase(
            data: nil,
            response: nil
            game: MockData.game,
        )
        let viewModel = AddGameDetailsViewModel(
            localDatabase: localDatabase
        )
        let delegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = delegate
        
        // When
        viewModel.didTapPrimaryButton()
        
        // Then
        delegate.verify(.configureBottomView(contentViewFactory: .any))
    }
}
