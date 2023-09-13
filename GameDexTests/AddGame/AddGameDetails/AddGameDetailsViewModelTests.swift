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
    
    let game = Game(
        title: "The Legend of Zelda: The Minish Cap",
        description: "description",
        id: "id",
        platform: "Game Boy Advance",
        imageURL: "imageURL"
    )
    
    // MARK: Tests
    
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let viewModel = AddGameDetailsViewModel(
            game: self.game,
            localDatabase: MockLocalDatabase(
                data: nil,
                response: nil
            )
        )
        
        // Then
        XCTAssertEqual(viewModel.sections.count, 1)
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 8)
    }
    
    func test_loadData_ThenCallBackIsCalled() {
        // Given
        let viewModel = AddGameDetailsViewModel(
            game: self.game,
            localDatabase: MockLocalDatabase(
                data: nil,
                response: nil
            )
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
        )
        let viewModel = AddGameDetailsViewModel(
            game: self.game,
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
