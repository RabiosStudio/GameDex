//
//  SelectAddGameMethodViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 27/08/2023.
//

import XCTest
@testable import GameDex

final class SelectAddGameMethodViewModelTests: XCTestCase {
    func test_init_ThenShouldSetupPropertiesCorrectly() {
        // Given
        let viewModel = SelectAddGameMethodViewModel(delegate: MyCollectionViewModelDelegateMock()
        )
        
        let numberOfItems = viewModel.numberOfItems(in: .zero)
        // Then
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(numberOfItems, 2)
    }
    
    func test_loadData_ThenCallBackIsCalled() {
        // Given
        let viewModel = SelectAddGameMethodViewModel(delegate: MyCollectionViewModelDelegateMock()
        )
        var callbackIsCalled = false
        // When
        viewModel.loadData { _ in
            callbackIsCalled = true
        }
        XCTAssertTrue(callbackIsCalled)
    }
    
    func test_didTapRightButtonItem_ThenShouldSetNavigationStyleCorrectly() {
        // Given
        let viewModel = SelectAddGameMethodViewModel(delegate: MyCollectionViewModelDelegateMock()
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
