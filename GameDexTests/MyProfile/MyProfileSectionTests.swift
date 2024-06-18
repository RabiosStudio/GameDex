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
            appLauncher: AppLauncherMock(),
            appReviewService: AppReviewServiceMock()
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 4)
        
        guard let loginCellVM = section.cellsVM.first as? LabelCellViewModel,
              let collectionManagementCellVM = section.cellsVM[1] as? LabelCellViewModel,
              let contactUsCellVM = section.cellsVM[2] as? LabelCellViewModel,
              let reviewTheAppCellVM = section.cellsVM[3] as? LabelCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(loginCellVM.text, L10n.login)
        XCTAssertEqual(collectionManagementCellVM.text, L10n.collectionManagement)
        XCTAssertEqual(contactUsCellVM.text, L10n.contactUs)
        XCTAssertEqual(reviewTheAppCellVM.text, L10n.reviewTheApp)
    }
    
    func test_init_GivenUserIsLoggedIn_ThenShouldSetPropertiesCorrectly() {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let section = MyProfileSection(
            isUserLoggedIn: true,
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: alertDisplayer,
            appLauncher: AppLauncherMock(),
            appReviewService: AppReviewServiceMock()
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 5)
        
        guard let loginCellVM = section.cellsVM.first as? LabelCellViewModel,
              let editProfileCellVM = section.cellsVM[1] as? LabelCellViewModel,
              let collectionManagementCellVM = section.cellsVM[2] as? LabelCellViewModel,
              let contactUsCellVM = section.cellsVM[3] as? LabelCellViewModel,
              let reviewTheAppCellVM = section.cellsVM[4] as? LabelCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(loginCellVM.text, L10n.logout)
        XCTAssertEqual(editProfileCellVM.text, L10n.editProfile)
        XCTAssertEqual(collectionManagementCellVM.text, L10n.collectionManagement)
        XCTAssertEqual(contactUsCellVM.text, L10n.contactUs)
        XCTAssertEqual(reviewTheAppCellVM.text, L10n.reviewTheApp)
    }
    
    func test_LoginCellTapped_GivenUserIsLoggedOut_ThenShouldSetCellTappedCallbackCorrectly() {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let section = MyProfileSection(
            isUserLoggedIn: false,
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: alertDisplayer,
            appLauncher: AppLauncherMock(),
            appReviewService: AppReviewServiceMock()
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
            appLauncher: AppLauncherMock(),
            appReviewService: AppReviewServiceMock()
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
                        description: L10n.warningLogOut
                    )
                )
            ), count: .once
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
            appLauncher: appLauncher,
            appReviewService: AppReviewServiceMock()
        )
        
        guard let contactUsCellVM = section.cellsVM[3] as? LabelCellViewModel,
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
            appLauncher: appLauncher,
            appReviewService: AppReviewServiceMock()
        )
        
        guard let contactUsCellVM = section.cellsVM[3] as? LabelCellViewModel else {
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
        alertDisplayer.verify(.presentTopFloatAlert(parameters: .value(alertVM)), count: .once)
    }
    
    func test_ReviewTheAppCellTapped_ThenShouldCallRequestReview() {
        // Given
        let appReviewService = AppReviewServiceMock()
        let section = MyProfileSection(
            isUserLoggedIn: false,
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: AlertDisplayerMock(),
            appLauncher: AppLauncherMock(),
            appReviewService: appReviewService
        )
        
        guard let reviewTheAppCellVM = section.cellsVM[3] as? LabelCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        // When
        reviewTheAppCellVM.cellTappedCallback?()
        
        // Then
        appReviewService.verify(.requestReview(), count: .once)
    }
}
