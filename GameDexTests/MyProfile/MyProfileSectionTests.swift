//
//  MyProfileSectionTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import XCTest
@testable import GameDex

final class MyProfileSectionTests: XCTestCase {
    
    func test_init_GivenUserIsNotLoggedIn_ThenShouldSetPropertiesCorrectly() {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let section = MyProfileSection(
            isUserLoggedIn: false,
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: alertDisplayer
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 3)
        
        guard let loginCellVM = section.cellsVM.first as? LabelCellViewModel,
              let collectionManagementCellVM = section.cellsVM[1] as? LabelCellViewModel,
              let contactUsCellVM = section.cellsVM.last as? LabelCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(loginCellVM.text, L10n.login)
        XCTAssertEqual(collectionManagementCellVM.text, L10n.collectionManagement)
        XCTAssertEqual(contactUsCellVM.text, L10n.contactUs)
        
        loginCellVM.cellTappedCallback?()
        let expectedNavigationStyle: NavigationStyle = .push(
            screenFactory: LoginScreenFactory(
                myProfileDelegate: MyProfileViewModelDelegateMock(),
                myCollectionDelegate: MyCollectionViewModelDelegateMock()
            )
        )
        
        XCTAssertEqual(Routing.shared.lastNavigationStyle,  expectedNavigationStyle)
    }
    
    func test_init_GivenUserIsLoggedIn_ThenShouldSetPropertiesCorrectly() {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let section = MyProfileSection(
            isUserLoggedIn: true,
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: alertDisplayer
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 3)
        
        guard let loginCellVM = section.cellsVM.first as? LabelCellViewModel,
              let collectionManagementCellVM = section.cellsVM[1] as? LabelCellViewModel,
              let contactUsCellVM = section.cellsVM.last as? LabelCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(loginCellVM.text, L10n.logout)
        XCTAssertEqual(collectionManagementCellVM.text, L10n.collectionManagement)
        XCTAssertEqual(contactUsCellVM.text, L10n.contactUs)
        
        loginCellVM.cellTappedCallback?()
        
        alertDisplayer.verify(
            .presentBasicAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .warning,
                        description: L10n.warningLogOut,
                        cancelButtonTitle: L10n.cancel,
                        okButtonTitle: L10n.confirm
                    )
                )
            )
        )
    }
}
