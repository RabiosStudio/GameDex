//
//  AuthenticationViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 25/09/2023.
//

import XCTest
@testable import GameDex

final class AuthenticationViewModelTests: XCTestCase {
    func test_init_ThenShouldSetupPropertiesCorrectly() {
        // Given
        let viewModel = AuthenticationViewModel(
            userHasAccount: true,
            authenticationSerice: AuthenticationServiceMock(),
            alertDisplayer: AlertDisplayerMock(),
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        // Then
        XCTAssertEqual(viewModel.numberOfSections(), .zero)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), .zero)
    }
    
    func test_loadData_ThenCallBackIsCalledAndSectionsUpdated() async {
        // Given
        let viewModel = AuthenticationViewModel(
            userHasAccount: true,
            authenticationSerice: AuthenticationServiceMock(),
            alertDisplayer: AlertDisplayerMock(),
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
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 5)
    }
    
    func test_didTapPrimaryButton_GivenUserHasAccountAndLoginError_ThenAlertParametersAreSetCorrectly() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .login(
                email: .any,
                password: .any,
                cloudDatabase: .any,
                localDatabase: .any,
                willReturn: AuthenticationError.loginError
            )
        )
        let alertDisplayer = AlertDisplayerMock()
        
        let viewModel = AuthenticationViewModel(
            userHasAccount: true,
            authenticationSerice: authenticationService,
            alertDisplayer: alertDisplayer,
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        viewModel.loadData { _ in }
        
        let firstSection = viewModel.sections.first!
        let formCellsVM = firstSection.cellsVM.filter({ cellVM in
            return cellVM is TextFieldCellViewModel
        }) as! [TextFieldCellViewModel]
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? UserAccountFormType else { return }
            switch formType {
            case .email:
                formCellVM.value = "email"
            case .password:
                formCellVM.value = "password"
            case .collection(_):
                XCTFail("Wrong type")
            }
        }
        
        // When
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.errorAuthDescription
                    )
                )
            )
        )
    }
    
    func test_didTapPrimaryButton_GivenUserHasAccountAndNoError_ThenAlertParametersAreSetCorrectly() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .login(
                email: .any,
                password: .any,
                cloudDatabase: .any,
                localDatabase: .any,
                willReturn: nil
            )
        )
        let alertDisplayer = AlertDisplayerMock()
        let myProfileDelegate = MyProfileViewModelDelegateMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        
        let viewModel = AuthenticationViewModel(
            userHasAccount: true,
            authenticationSerice: authenticationService,
            alertDisplayer: alertDisplayer,
            myProfileDelegate: myProfileDelegate,
            myCollectionDelegate: myCollectionDelegate
        )
        
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        viewModel.loadData { _ in }
        
        let firstSection = viewModel.sections.first!
        let formCellsVM = firstSection.cellsVM.filter({ cellVM in
            return cellVM is TextFieldCellViewModel
        }) as! [TextFieldCellViewModel]
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? UserAccountFormType else { return }
            switch formType {
            case .email:
                formCellVM.value = "email"
            case .password:
                formCellVM.value = "password"
            case .collection(_):
                XCTFail("Wrong type")
            }
        }
        
        // When
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.successAuthDescription
                    )
                )
            )
        )
        
        myProfileDelegate.verify(.reloadMyProfile())
        myCollectionDelegate.verify(.reloadCollection())
        containerDelegate.verify(.goBackToRootViewController())
    }
    
    func test_didTapPrimaryButton_GivenNoUserAccountAndCreateAccountError_ThenAlertParametersAreSetCorrectly() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .createUser(
                email: .any,
                password: .any,
                cloudDatabase: .any,
                willReturn: AuthenticationError.createAccountError
            )
        )
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = AuthenticationViewModel(
            userHasAccount: false,
            authenticationSerice: authenticationService,
            alertDisplayer: alertDisplayer,
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        viewModel.loadData { _ in }
        
        let firstSection = viewModel.sections.first!
        let formCellsVM = firstSection.cellsVM.filter({ cellVM in
            return cellVM is TextFieldCellViewModel
        }) as! [TextFieldCellViewModel]
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? UserAccountFormType else { return }
            switch formType {
            case .email:
                formCellVM.value = "email"
            case .password:
                formCellVM.value = "password"
            case .collection(_):
                XCTFail("Wrong type")
            }
        }
        
        // When
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.errorAuthDescription
                    )
                )
            )
        )
    }
    
    func test_didTapPrimaryButton_GivenNoUserAccountAndNoError_ThenAlertParametersAreSetCorrectly() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: nil))
        authenticationService.given(
            .createUser(
                email: .any,
                password: .any,
                cloudDatabase: .any,
                willReturn: nil
            )
        )
        let alertDisplayer = AlertDisplayerMock()
        let myProfileDelegate = MyProfileViewModelDelegateMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        
        let viewModel = AuthenticationViewModel(
            userHasAccount: false,
            authenticationSerice: authenticationService,
            alertDisplayer: alertDisplayer,
            myProfileDelegate: myProfileDelegate,
            myCollectionDelegate: myCollectionDelegate
        )
        
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        viewModel.loadData { _ in }
        
        let firstSection = viewModel.sections.first!
        let formCellsVM = firstSection.cellsVM.filter({ cellVM in
            return cellVM is TextFieldCellViewModel
        }) as! [TextFieldCellViewModel]
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? UserAccountFormType else { return }
            switch formType {
            case .email:
                formCellVM.value = "email"
            case .password:
                formCellVM.value = "password"
            case .collection(_):
                XCTFail("Wrong type")
            }
        }

        // When
        await viewModel.didTapPrimaryButton(with: nil)
        
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.successAuthDescription
                    )
                )
            )
        )
        myProfileDelegate.verify(.reloadMyProfile())
        myCollectionDelegate.verify(.reloadCollection())
        containerDelegate.verify(.goBackToRootViewController())
    }
    
    func test_didTapForgotPassword_GivenNoEmailEntry_ThenAlertSettingsAreCorrects() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
//        authenticationService.given(.getUserId(willReturn: "userId"))
        let alertDisplayer = AlertDisplayerMock()
        
        let viewModel = AuthenticationViewModel(
            userHasAccount: true,
            authenticationSerice: authenticationService,
            alertDisplayer: alertDisplayer,
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        viewModel.loadData { _ in }
        
        // When
        viewModel.sections.first?.cellsVM.last?.cellTappedCallback?()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.errorSendingPasswordResetEmail
                    )
                )
            )
        )
    }
}
