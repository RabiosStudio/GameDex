//
//  AuthenticationSectionTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 25/09/2023.
//

import XCTest
@testable import GameDex

final class AuthenticationSectionTests: XCTestCase {
    
    func test_init_GivenUserHasAccount_ThenShouldSetPropertiesCorrectly() {
        // Given
        let section = AuthenticationSection(
            userHasAccount: true,
            primaryButtonDelegate: nil,
            completionBlock: nil
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 5)
        
        guard let titleCellVM = section.cellsVM.first as? TitleCellViewModel,
              let loginButtonCellVM = section.cellsVM[3] as? PrimaryButtonCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(titleCellVM.title, L10n.loginEmail)
        XCTAssertEqual(loginButtonCellVM.buttonViewModel, ButtonViewModel(isEnabled: true, buttonTitle: L10n.login))
        
        
        
        guard let formCellsVM = section.cellsVM.filter({ cellVM in
            return cellVM is (any CollectionFormCellViewModel)
        }) as? [any CollectionFormCellViewModel] else {
            return
        }
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? UserAccountFormType else {
                XCTFail("Wrong type")
                return
            }
            switch formType {
            case .email:
                guard let emailCellVM = formCellVM as? TextFieldCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(emailCellVM.placeholder, L10n.email)
            case .password:
                guard let passwordCellVM = formCellVM as? TextFieldCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(passwordCellVM.placeholder, L10n.password)
            case .collection(_):
                return
            }
        }
    }
    
    func test_init_GivenNoUserAccount_ThenShouldSetPropertiesCorrectly() {
        // Given
        let section = AuthenticationSection(
            userHasAccount: false,
            primaryButtonDelegate: nil, 
            completionBlock: nil
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 4)
        
        guard let titleCellVM = section.cellsVM.first as? TitleCellViewModel,
              let createAccountButtonCellVM = section.cellsVM[3] as? PrimaryButtonCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(titleCellVM.title, L10n.signupEmail)
        XCTAssertEqual(createAccountButtonCellVM.buttonViewModel, ButtonViewModel(isEnabled: true, buttonTitle: L10n.createAccount))
        
        guard let formCellsVM = section.cellsVM.filter({ cellVM in
            return cellVM is (any CollectionFormCellViewModel)
        }) as? [any CollectionFormCellViewModel] else {
            return
        }
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? UserAccountFormType else {
                XCTFail("Wrong type")
                return
            }
            switch formType {
            case .email:
                guard let emailCellVM = formCellVM as? TextFieldCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(emailCellVM.placeholder, L10n.email)
            case .password:
                guard let passwordCellVM = formCellVM as? TextFieldCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(passwordCellVM.placeholder, L10n.password)
            case .collection(_):
                return
            }
        }
    }
    
    func test_cellTappedCallback_GivenForgotPasswordCellTapped_ThenUseCompletionBlock() {
        // Given
        var cellTappedCallbackCalled = false
        let section = AuthenticationSection(
            userHasAccount: true,
            primaryButtonDelegate: nil,
            completionBlock: {
                cellTappedCallbackCalled = true
            }
        )
        
        guard let forgotPasswordCellVM = section.cellsVM.last as? LabelCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        // When
        forgotPasswordCellVM.cellTappedCallback?()
        
        // Then
        XCTAssertTrue(cellTappedCallbackCalled)
    }
}
