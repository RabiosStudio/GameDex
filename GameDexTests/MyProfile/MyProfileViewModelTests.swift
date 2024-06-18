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
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            cloudDatabase: CloudDatabaseMock(),
            localDatabase: LocalDatabaseMock()
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
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            cloudDatabase: CloudDatabaseMock(),
            localDatabase: LocalDatabaseMock()
        )
        
        authenticationService.given(
            .isUserLoggedIn(
                willReturn: true
            )
        )
        
        // When
        viewModel.loadData { _ in }
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 5)
    }
    
    func test_loadData_GivenUserIsNotLoggedIn_ThenSectionsUpdated() {
        // Given
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = MyProfileViewModel(
            authenticationService: authenticationService,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            cloudDatabase: CloudDatabaseMock(),
            localDatabase: LocalDatabaseMock()
        )
        authenticationService.given(
            .isUserLoggedIn(
                willReturn: false
            )
        )
        
        // When
        viewModel.loadData { _ in }
        
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 4)
    }
    
    func test_reloadMyProfile_ThenContainerDelegateIsCalled() {
        // Given
        let viewModel = MyProfileViewModel(
            authenticationService: AuthenticationServiceMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            cloudDatabase: CloudDatabaseMock(),
            localDatabase: LocalDatabaseMock()
        )
        
        let containerDelegate = ContainerViewControllerDelegateMock()
        
        viewModel.containerDelegate = containerDelegate
        
        viewModel.reloadMyProfile()
        
        containerDelegate.verify(.reloadData(), count: .once)
    }
    
    func test_didTapOkButton_GivenNoError_ThenAlertParametersAreCorrectsAndContainerDelegateIsCalled() async {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let authenticationService = AuthenticationServiceMock()
        let viewModel = MyProfileViewModel(
            authenticationService: authenticationService,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            cloudDatabase: CloudDatabaseMock(),
            localDatabase: LocalDatabaseMock()
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        authenticationService.given(.logout(willReturn: nil))
        
        // When
        await viewModel.didTapOkButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.successLogOutDescription
                    )
                )
            ), count: .once
        )
        containerDelegate.verify(.reloadData(), count: .once)
    }
    
    func test_didTapOkButton_GivenErrorLogOut_ThenAlertParametersAreCorrects() async {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let authenticationService = AuthenticationServiceMock()
        let viewModel = MyProfileViewModel(
            authenticationService: authenticationService,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            cloudDatabase: CloudDatabaseMock(),
            localDatabase: LocalDatabaseMock()
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        authenticationService.given(.logout(willReturn: AuthenticationError.logoutError))
        
        // When
        await viewModel.didTapOkButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.errorLogOutDescription
                    )
                )
            ), count: .once
        )
    }
}
