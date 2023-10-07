//
//  LoginViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import XCTest
@testable import GameDex

final class LoginViewModelTests: XCTestCase {
    func test_init_ThenShouldSetupPropertiesCorrectly() {
        // Given
        let viewModel = LoginViewModel(
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        // Then
        XCTAssertEqual(viewModel.numberOfSections(), .zero)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), .zero)
    }
    
    func test_loadData_ThenCallBackIsCalledAndSectionsUpdated() {
        // Given
        let viewModel = LoginViewModel(
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        var callbackIsCalled = false
        // When
        viewModel.loadData { _ in
            callbackIsCalled = true
        }
        XCTAssertTrue(callbackIsCalled)
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 4)
    }
}
