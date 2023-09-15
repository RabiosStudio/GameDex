//
//  SelectAddGameMethodViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 27/08/2023.
//

import XCTest
@testable import GameDex

final class SelectAddGameMethodViewModelTests: XCTestCase {
    func test_init_GivenSelectAddGameMethodViewModel_ThenShouldSetPropertiesCorrectly() {
        // Given
        let viewModel = SelectAddGameMethodViewModel(delegate: AddGameDetailsViewModelDelegateMock())
        
        // Then
        XCTAssertEqual(viewModel.sections.count, 1)
        XCTAssertEqual(viewModel.numberOfSections(), 1)
    }
    
    func test_loadData_ThenCallBackIsCalled() {
        // Given
        let viewModel = SelectAddGameMethodViewModel(delegate: AddGameDetailsViewModelDelegateMock())
        var callbackIsCalled = false
        // When
        viewModel.loadData { _ in
            callbackIsCalled = true
        }
        XCTAssertTrue(callbackIsCalled)
    }
    
    func test_numberOfItems_ThenShouldReturnOne() {
        // Given
        let viewModel = SelectAddGameMethodViewModel(delegate: AddGameDetailsViewModelDelegateMock())
        // When
        let numberOfItems = viewModel.numberOfItems(in: .zero)
        // Then
        XCTAssertEqual(numberOfItems, 2)
        }
}
