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
    
    func test_didTapPrimaryButton_GivenLoginButtonTapped_ThenSetupCorrectNavigationStyle() async {
        // Given
        let myProfileDelegate = MyProfileViewModelDelegateMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        let viewModel = LoginViewModel(
            myProfileDelegate: myProfileDelegate,
            myCollectionDelegate: myCollectionDelegate
        )
        viewModel.loadData { _ in }
        
        // When
        await viewModel.didTapPrimaryButton(with: L10n.login)
        
        // Then
        let expectedNavigationStyle: NavigationStyle = .push(
            screenFactory: AuthenticationScreenFactory(
                userHasAccount: true,
                myProfileDelegate: myProfileDelegate,
                myCollectionDelegate: myCollectionDelegate
            )
        )
        let lastNavigationStyle = Routing.shared.lastNavigationStyle
        XCTAssertEqual(lastNavigationStyle, expectedNavigationStyle)
    }
    
    func test_didTapPrimaryButton_GivenCreateAccountButtonTapped_ThenSetupCorrectNavigationStyle() async {
        // Given
        let myProfileDelegate = MyProfileViewModelDelegateMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        let viewModel = LoginViewModel(
            myProfileDelegate: myProfileDelegate,
            myCollectionDelegate: myCollectionDelegate
        )
        viewModel.loadData { _ in }
        
        // When
        await viewModel.didTapPrimaryButton(with: L10n.createAccount)
        
        // Then
        let expectedNavigationStyle: NavigationStyle = .push(
            screenFactory: AuthenticationScreenFactory(
                userHasAccount: false,
                myProfileDelegate: myProfileDelegate,
                myCollectionDelegate: myCollectionDelegate
            )
        )
        let lastNavigationStyle = Routing.shared.lastNavigationStyle
        XCTAssertEqual(lastNavigationStyle, expectedNavigationStyle)
    }
}

