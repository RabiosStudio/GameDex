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
            primaryButtonDelegate: nil
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 8)
        
        guard let titleCellVM = section.cellsVM.first as? TitleCellViewModel,
              let loginButtonCellVM = section.cellsVM[3] as? PrimaryButtonCellViewModel,
              let otherLoginMethodTitleCellVM = section.cellsVM[4] as? TitleCellViewModel,
              let appleCellVM = section.cellsVM[5] as? BasicCardCellViewModel,
              let facebookCellVM = section.cellsVM[6] as? BasicCardCellViewModel,
              let googleCellVM = section.cellsVM[7] as? BasicCardCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(titleCellVM.title, L10n.loginEmail)
        XCTAssertEqual(loginButtonCellVM.title, L10n.login)
        XCTAssertEqual(otherLoginMethodTitleCellVM.title, "\(L10n.or) \n \n \(L10n.login) \(L10n.authThroughOtherMethods)")
        
        
        guard let appleCellVMCardType = appleCellVM.cardType as? AuthCardType,
              let facebookCellVMCardType = facebookCellVM.cardType as? AuthCardType,
              let googleCellVMCardType = googleCellVM.cardType as? AuthCardType else {
            XCTFail("Wrong type")
            return
        }
        
        XCTAssertEqual(appleCellVMCardType, AuthCardType.appleAuth)
        XCTAssertEqual(appleCellVM.cardTitle, L10n.loginApple)
        
        XCTAssertEqual(facebookCellVMCardType, AuthCardType.facebookAuth)
        XCTAssertEqual(facebookCellVM.cardTitle, L10n.loginFacebook)
        
        XCTAssertEqual(googleCellVMCardType, AuthCardType.googleAuth)
        XCTAssertEqual(googleCellVM.cardTitle, L10n.loginGoogle)
        
        
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
            }
        }
    }
    
    func test_init_GivenNoUserAccount_ThenShouldSetPropertiesCorrectly() {
        // Given
        let section = AuthenticationSection(
            userHasAccount: false,
            primaryButtonDelegate: nil
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 8)
        
        guard let titleCellVM = section.cellsVM.first as? TitleCellViewModel,
              let createAccountButtonCellVM = section.cellsVM[3] as? PrimaryButtonCellViewModel,
              let otherLoginMethodTitleCellVM = section.cellsVM[4] as? TitleCellViewModel,
              let appleCellVM = section.cellsVM[5] as? BasicCardCellViewModel,
              let facebookCellVM = section.cellsVM[6] as? BasicCardCellViewModel,
              let googleCellVM = section.cellsVM[7] as? BasicCardCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(titleCellVM.title, L10n.signupEmail)
        XCTAssertEqual(createAccountButtonCellVM.title, L10n.createAccount)
        XCTAssertEqual(otherLoginMethodTitleCellVM.title, "\(L10n.or) \n \n \(L10n.signup) \(L10n.authThroughOtherMethods)")
        
        
        guard let appleCellVMCardType = appleCellVM.cardType as? AuthCardType,
              let facebookCellVMCardType = facebookCellVM.cardType as? AuthCardType,
              let googleCellVMCardType = googleCellVM.cardType as? AuthCardType else {
            XCTFail("Wrong type")
            return
        }
        
        XCTAssertEqual(appleCellVMCardType, AuthCardType.appleAuth)
        XCTAssertEqual(appleCellVM.cardTitle, L10n.signupApple)
        
        XCTAssertEqual(facebookCellVMCardType, AuthCardType.facebookAuth)
        XCTAssertEqual(facebookCellVM.cardTitle, L10n.signupFacebook)
        
        XCTAssertEqual(googleCellVMCardType, AuthCardType.googleAuth)
        XCTAssertEqual(googleCellVM.cardTitle, L10n.signupGoogle)
        
        
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
            }
        }
    }
}
