//
//  LoginSectionTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import XCTest
@testable import GameDex

final class LoginSectionTests: XCTestCase {
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let section = LoginSection()
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 7)
        
        guard let headerCellVM = section.cellsVM.first as? TitleCellViewModel,
              let emailCellVM = section.cellsVM[1] as? BasicCardCellViewModel,
              let appleCellVM = section.cellsVM[2] as? BasicCardCellViewModel,
              let facebookCellVM = section.cellsVM[3] as? BasicCardCellViewModel,
              let googleCellVM = section.cellsVM[4] as? BasicCardCellViewModel,
              let footerCellVM = section.cellsVM[5] as? TitleCellViewModel,
              let buttonCellVM = section.cellsVM.last as? ButtonCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        guard let emailCellVMCardType = emailCellVM.cardType as? AuthCardType,
              let appleCellVMCardType = appleCellVM.cardType as? AuthCardType,
              let facebookCellVMCardType = facebookCellVM.cardType as? AuthCardType,
              let googleCellVMCardType = googleCellVM.cardType as? AuthCardType else {
            XCTFail("Wrong type")
            return
        }
        
        XCTAssertEqual(headerCellVM.title, L10n.loginDescription)
        
        XCTAssertEqual(emailCellVMCardType, AuthCardType.emailAuth)
        XCTAssertEqual(emailCellVM.cardTitle, L10n.loginEmail)
        
        XCTAssertEqual(appleCellVMCardType, AuthCardType.appleAuth)
        XCTAssertEqual(appleCellVM.cardTitle, L10n.loginApple)
        
        XCTAssertEqual(facebookCellVMCardType, AuthCardType.facebookAuth)
        XCTAssertEqual(facebookCellVM.cardTitle, L10n.loginFacebook)
        
        XCTAssertEqual(googleCellVMCardType, AuthCardType.googleAuth)
        XCTAssertEqual(googleCellVM.cardTitle, L10n.loginGoogle)
        
        XCTAssertEqual(footerCellVM.title, L10n.noAccountYet)
        
        XCTAssertEqual(buttonCellVM.title, L10n.createAccount)
    }
}
