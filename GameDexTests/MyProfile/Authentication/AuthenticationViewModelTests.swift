//
//  AuthenticationViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 25/09/2023.
//

import XCTest
@testable import GameDex

final class AuthenticationViewModelTests: XCTestCase {
    func test_init_GivenUserHasAccount_ThenShouldSetupPropertiesCorrectly() {
        // Given
        let viewModel = AuthenticationViewModel(userHasAccount: true)
        
        // Then
        XCTAssertEqual(viewModel.numberOfSections(), .zero)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), .zero)
    }
    
    func test_init_GivenNoUserAccount_ThenShouldSetupPropertiesCorrectly() {
        // Given
        let viewModel = AuthenticationViewModel(userHasAccount: false)
        
        // Then
        XCTAssertEqual(viewModel.numberOfSections(), .zero)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), .zero)
    }
        
        func test_loadData_ThenCallBackIsCalledAndSectionsUpdated() {
            // Given
            let viewModel = AuthenticationViewModel(userHasAccount: true)
            var callbackIsCalled = false
            // When
            viewModel.loadData { _ in
                callbackIsCalled = true
            }
            XCTAssertTrue(callbackIsCalled)
            XCTAssertEqual(viewModel.numberOfSections(), 1)
            XCTAssertEqual(viewModel.numberOfItems(in: .zero), 8)
        }
    }
