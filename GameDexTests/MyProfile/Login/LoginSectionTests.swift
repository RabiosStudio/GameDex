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
        let section = LoginSection(
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(), primaryButtonDelegate: nil
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 4)
        
        guard let imageCellVM = section.cellsVM.first as? ImageCellViewModel,
              let titleCellVM = section.cellsVM[1] as? TitleCellViewModel,
              let loginButtonCellVM = section.cellsVM[2] as? PrimaryButtonCellViewModel,
              let signupButtonCellVM = section.cellsVM.last as? PrimaryButtonCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(imageCellVM.imageName, Asset.devices.name)
        XCTAssertEqual(titleCellVM.title, L10n.loginDescription)
        XCTAssertEqual(loginButtonCellVM.buttonViewModel, ButtonViewModel(isEnabled: true, buttonTitle: L10n.login))
        XCTAssertEqual(signupButtonCellVM.buttonViewModel, ButtonViewModel(isEnabled: true, buttonTitle: L10n.createAccount))
    }
}
