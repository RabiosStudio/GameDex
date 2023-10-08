//
//  MyProfileViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import XCTest
@testable import GameDex

final class MyProfileViewModelTests: XCTestCase {
    
    func test_init_ThenShouldSetupPropertiesCorrectly() {
        // Given
        let viewModel = MyProfileViewModel(
            authenticationService: AuthenticationServiceMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        // Then
        XCTAssertEqual(viewModel.numberOfSections(), .zero)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), .zero)
    }
    
    func test_loadData_GivenUserIsLoggedIn_ThenSectionsUpdated() {
        // Given
        let authenticationService = AuthenticationServiceMock()
        let viewModel = MyProfileViewModel(
            authenticationService: authenticationService,
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        authenticationService.given(
            .isUserLoggedIn(
                willReturn: true
            )
        )
        
        // When
        viewModel.loadData { _ in
        }
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 3)
    }
    
    func test_loadData_GivenUserIsNotLoggedIn_ThenSectionsUpdated() {
        // Given
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = MyProfileViewModel(
            authenticationService: authenticationService,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        authenticationService.given(
            .isUserLoggedIn(
                willReturn: false
            )
        )
        
        // When
        viewModel.loadData { _ in }
        
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 3)
    }
    
    func test_reloadMyProfile_ThenContainerDelegateIsCalled() {
        // Given
        let viewModel = MyProfileViewModel(
            authenticationService: AuthenticationServiceMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        let containerDelegate = ContainerViewControllerDelegateMock()
        
        viewModel.containerDelegate = containerDelegate
        
        viewModel.reloadMyProfile()
        
        containerDelegate.verify(.reloadSections())
    }
    
    func test_didTapOkButton_GivenNoError_ThenAlertParametersAreCorrectsAndContainerDelegateIsCalled() {
        // Given
        let expectation = XCTestExpectation()
        let alertDisplayer = AlertDisplayerMock()
        let authenticationService = AuthenticationServiceMock()
        let viewModel = MyProfileViewModel(
            authenticationService: authenticationService,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        authenticationService.perform(
            .logout(
                callback: .any,
                perform: { completion in
                    completion(nil)
                    
                    alertDisplayer.verify(
                        .presentTopFloatAlert(
                            parameters: .value(
                                AlertViewModel(
                                    alertType: .success,
                                    description: L10n.successLogOutDescription
                                )
                            )
                        )
                    )
                    containerDelegate.verify(.reloadSections())
                    expectation.fulfill()
                }
            )
        )
        viewModel.didTapOkButton()
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func test_didTapOkButton_GivenErrorLogOut_ThenAlertParametersAreCorrects() {
        // Given
        let expectation = XCTestExpectation()
        let alertDisplayer = AlertDisplayerMock()
        let authenticationService = AuthenticationServiceMock()
        let viewModel = MyProfileViewModel(
            authenticationService: authenticationService,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        authenticationService.perform(
            .logout(
                callback: .any,
                perform: { completion in
                    completion(AuthenticationError.logoutError)
                    
                    alertDisplayer.verify(
                        .presentTopFloatAlert(
                            parameters: .value(
                                AlertViewModel(
                                    alertType: .error,
                                    description: L10n.errorLogOutDescription
                                )
                            )
                        )
                    )
                    expectation.fulfill()
                }
            )
        )
        viewModel.didTapOkButton()
        wait(for: [expectation], timeout: Constants.timeout)
    }
}
