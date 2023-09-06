//
//  AddGameDetailsViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 05/09/2023.
//

import XCTest
@testable import GameDex

final class AddGameDetailsViewModelTests: XCTestCase {
    
    // MARK: Setup
    
    let game = Game(
        title: "The Legend of Zelda: The Minish Cap",
        description: "description",
        id: "id",
        platform: "Game Boy Advance",
        image: "imageURL"
    )
    
    // MARK: Tests
    
    func test_init_AddGameDetailsViewModel_ThenShouldSetPropertiesCorrectly() {
        // Given
        let viewModel = AddGameDetailsViewModel(game: self.game)
        
        // Then
        XCTAssertEqual(viewModel.sections.count, 1)
        XCTAssertEqual(viewModel.numberOfSections(), 1)
    }
    
    func test_loadData_ThenCallBackIsCalled() {
        // Given
        let viewModel = AddGameDetailsViewModel(game: self.game)
        var callbackIsCalled = false
        // When
        viewModel.loadData { _ in
            callbackIsCalled = true
        }
        XCTAssertTrue(callbackIsCalled)
    }
    
    func test_numberOfItems_ThenShouldReturnOne() {
        // Given
        let viewModel = AddGameDetailsViewModel(game: self.game)
        // When
        let numberOfItems = viewModel.numberOfItems(in: .zero)
        // Then
        XCTAssertEqual(numberOfItems, 9)
        }

}
