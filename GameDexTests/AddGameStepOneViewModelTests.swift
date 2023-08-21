//
//  AddGameStepOneViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 21/08/2023.
//

import XCTest
@testable import GameDex

final class AddGameStepOneViewModelTests: XCTestCase {
    
    func test_init_GivenAddGameStepOneViewModel_ThenShouldSetPropertiesCorrectly () throws {
        // Given
        let viewModel = AddGameStepOneViewModel()
        
        // Then
        XCTAssertEqual(viewModel.sections.count, 1)
    }
    
    func test_loadData_GivenContainerDelegateIsSet_ThenShouldSetPropertiesCorrectly () throws {
        // Given
        let viewModel = AddGameStepOneViewModel()
        let delegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = delegate
        var callbackIsCalled = false
        
        // When
        viewModel.loadData { _ in
            callbackIsCalled = true
        }        
        
        // Then
        XCTAssertTrue(callbackIsCalled)
        XCTAssertTrue(delegate.configureBottomViewCalled)
        
    }
}
