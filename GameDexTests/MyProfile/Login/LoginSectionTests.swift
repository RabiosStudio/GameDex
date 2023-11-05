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
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
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
    
    func test_cellTappedCallback_ThenLastNavigationStyleIsCorrect() {
        // Given
        let myProfileDelegate = MyProfileViewModelDelegateMock()
        let section = LoginSection(
            myProfileDelegate: myProfileDelegate,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        guard let buttonCellsVM = section.cellsVM.filter({ cellVM in
            return cellVM is PrimaryButtonCellViewModel
        }) as? [PrimaryButtonCellViewModel] else {
            XCTFail("Wrong type")
            return
        }
        
        let loginButtonCellVM = buttonCellsVM.first { cell in
            cell.buttonViewModel.buttonTitle == L10n.login
        }
        let signupButtonCellVM = buttonCellsVM.first { cell in
            cell.buttonViewModel.buttonTitle == L10n.createAccount
        }
        
        // When
        loginButtonCellVM?.cellTappedCallback?()
        signupButtonCellVM?.cellTappedCallback?()
        
        // Then
        let expectedNavigationStyle1: NavigationStyle = .push(
            screenFactory: AuthenticationScreenFactory(
                userHasAccount: true,
                myProfileDelegate: myProfileDelegate,
                myCollectionDelegate: MyCollectionViewModelDelegateMock()
            )
        )
        XCTAssertEqual(Routing.shared.lastNavigationStyle, expectedNavigationStyle1)
        
        let expectedNavigationStyle2: NavigationStyle = .push(
            screenFactory: AuthenticationScreenFactory(
                userHasAccount: false,
                myProfileDelegate: myProfileDelegate,
                myCollectionDelegate: MyCollectionViewModelDelegateMock()
            )
        )
        XCTAssertEqual(Routing.shared.lastNavigationStyle, expectedNavigationStyle2)
    }
}
