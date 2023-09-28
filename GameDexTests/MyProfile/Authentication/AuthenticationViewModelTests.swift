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
            myProfileDelegate: nil
        )
        
        // Then
        XCTAssertEqual(viewModel.numberOfSections(), .zero)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), .zero)
    }
    
    func test_loadData_ThenCallBackIsCalledAndSectionsUpdated() {
        // Given
        let viewModel = AuthenticationViewModel(
            userHasAccount: true,
            authenticationSerice: AuthenticationServiceMock(),
            alertDisplayer: AlertDisplayerMock(),
            myProfileDelegate: nil
        )
        var callbackIsCalled = false
        // When
        viewModel.loadData { _ in
            callbackIsCalled = true
        }
        XCTAssertTrue(callbackIsCalled)
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 8)
    }
    
    func test_didTapPrimaryButton_GivenUserHasAccountAndLoginError_ThenAlertParametersAreSetCorrectly() {
        // Given
        let expectation = XCTestExpectation()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        
        let viewModel = AuthenticationViewModel(
            userHasAccount: true,
            authenticationSerice: authenticationService,
            alertDisplayer: alertDisplayer,
            myProfileDelegate: nil
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
            }
        }
        
        authenticationService.perform(
            .login(
                email: .any,
                password: .any,
                callback: .any,
                perform: { _, _, completion in
                    completion(AuthenticationError.loginError)
                    
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
                    expectation.fulfill()
                }
            )
        )
        
        // When
        viewModel.didTapPrimaryButton()
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func test_didTapPrimaryButton_GivenUserHasAccountAndNoError_ThenAlertParametersAreSetCorrectly() {
        // Given
        let expectation = XCTestExpectation()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        
        let viewModel = AuthenticationViewModel(
            userHasAccount: true,
            authenticationSerice: authenticationService,
            alertDisplayer: alertDisplayer,
            myProfileDelegate: nil
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
            }
        }
        
        authenticationService.perform(
            .login(
                email: .any,
                password: .any,
                callback: .any,
                perform: { _, _, completion in
                    completion(nil)
                    
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
                    expectation.fulfill()
                }
            )
        )
        
        viewModel.didTapPrimaryButton()
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func test_didTapPrimaryButton_GivenNoUserAccountAndCreateAccountError_ThenAlertParametersAreSetCorrectly() {
        // Given
        let expectation = XCTestExpectation()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        
        let viewModel = AuthenticationViewModel(
            userHasAccount: false,
            authenticationSerice: authenticationService,
            alertDisplayer: alertDisplayer,
            myProfileDelegate: nil
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
            }
        }
        
        authenticationService.perform(
            .createUser(
                email: .any,
                password: .any,
                callback: .any,
                perform: { _, _, completion in
                    completion(AuthenticationError.createAccountError)
                    
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
                    expectation.fulfill()
                }
            )
        )
        
        viewModel.didTapPrimaryButton()
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func test_didTapPrimaryButton_GivenNoUserAccountAndNoError_ThenAlertParametersAreSetCorrectly() {
        // Given
        let expectation = XCTestExpectation()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        
        let viewModel = AuthenticationViewModel(
            userHasAccount: false,
            authenticationSerice: authenticationService,
            alertDisplayer: alertDisplayer,
            myProfileDelegate: nil
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
            }
        }
        
        authenticationService.perform(
            .createUser(
                email: .any,
                password: .any,
                callback: .any,
                perform: { _, _, completion in
                    completion(nil)
                    
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
                    expectation.fulfill()
                }
            )
        )
        
        viewModel.didTapPrimaryButton()
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
}
