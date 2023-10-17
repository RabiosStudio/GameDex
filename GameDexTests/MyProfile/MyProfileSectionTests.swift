//
//  MyProfileSectionTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import XCTest
@testable import GameDex

final class MyProfileSectionTests: XCTestCase {
    
    func test_init_GivenUserIsLoggedOut_ThenShouldSetPropertiesCorrectly() {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let section = MyProfileSection(
            isUserLoggedIn: false,
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: alertDisplayer, 
            appLauncher: AppLauncherMock()
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
    }
    
    func test_init_GivenUserIsLoggedIn_ThenShouldSetPropertiesCorrectly() {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let section = MyProfileSection(
            isUserLoggedIn: true,
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: alertDisplayer,
            appLauncher: AppLauncherMock()
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
    }
    
    func test_LoginCellTapped_GivenUserIsLoggedOut_ThenShouldSetCellTappedCallbackCorrectly() {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let section = MyProfileSection(
            isUserLoggedIn: false,
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: alertDisplayer,
            appLauncher: AppLauncherMock()
        )
        
        guard let loginCellVM = section.cellsVM.first as? LabelCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        // When
        loginCellVM.cellTappedCallback?()
        
        // Then
        let expectedNavigationStyle: NavigationStyle = .push(
            screenFactory: LoginScreenFactory(
                myProfileDelegate: MyProfileViewModelDelegateMock(),
                myCollectionDelegate: MyCollectionViewModelDelegateMock()
            )
        )
        XCTAssertEqual(Routing.shared.lastNavigationStyle, expectedNavigationStyle)
    }
    
    func test_LoginCellTapped_GivenUserIsLoggedIn_ThenShouldSetCellTappedCallbackCorrectly() {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let section = MyProfileSection(
            isUserLoggedIn: true,
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: alertDisplayer,
            appLauncher: AppLauncherMock()
        )
        
        guard let loginCellVM = section.cellsVM.first as? LabelCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        // When
        loginCellVM.cellTappedCallback?()
        
        // Then
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
    
    func test_ContactUsCellTapped_GivenCorrectContactEmail_ThenShouldSetCellTappedCallbackCorrectly() {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let appLauncher = AppLauncherMock()
        let section = MyProfileSection(
            isUserLoggedIn: true,
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: alertDisplayer,
            appLauncher: appLauncher
        )
        
        guard let contactUsCellVM = section.cellsVM[2] as? LabelCellViewModel,
              let contactUrl = URL(string: "mailto:gabrielledalbera@icloud.com") else {
            XCTFail("Cell View Model or property is not correct")
            return
        }
        
        appLauncher.given(
            .createEmailUrl(
                to: .any,
                willReturn: contactUrl
            )
        )
        
        appLauncher.given(
            .canOpenURL(
                .value(contactUrl),
                willReturn: true
            )
        )
        
        // When
        contactUsCellVM.cellTappedCallback?()
        
        let email = "gabrielledalbera@icloud.com"
        
        let alertVM = AlertViewModel(
            alertType: .error,
            description: L10n.errorEmailAppDescription + email
        )
        
        let expectedNavigationStyle: NavigationStyle = .url(
            appURL: contactUrl,
            appLauncher: appLauncher, 
            alertDisplayer: alertDisplayer,
            alertViewModel: alertVM
        )
        XCTAssertEqual(Routing.shared.lastNavigationStyle,  expectedNavigationStyle)
    }
    
    func test_ContactUsCellTapped_GivenErrorContactEmail_ThenShouldSetCellTappedCallbackCorrectly() {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let appLauncher = AppLauncherMock()
        let section = MyProfileSection(
            isUserLoggedIn: true,
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: alertDisplayer,
            appLauncher: appLauncher
        )
        
        guard let contactUsCellVM = section.cellsVM[2] as? LabelCellViewModel else {
            XCTFail("Cell View Model or property is not correct")
            return
        }
        
        appLauncher.given(
            .createEmailUrl(
                to: .any,
                willReturn: nil
            )
        )
        
        // When
        contactUsCellVM.cellTappedCallback?()
        
        let email = "gabrielledalbera@icloud.com"
        
        let alertVM = AlertViewModel(
            alertType: .error,
            description: L10n.errorEmailAppDescription + email
        )
        alertDisplayer.verify(.presentTopFloatAlert(parameters: .value(alertVM)))
    }
}
