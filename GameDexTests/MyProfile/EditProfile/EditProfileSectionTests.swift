//
//  EditProfileSectionTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 18/10/2023.
//

import XCTest
@testable import GameDex

final class EditProfileSectionTests: XCTestCase {
    func test_init_GivenCredentialConfirmed_ThenShouldSetPropertiesCorrectly() {
        // Given
        let profileDelegate = MyProfileViewModelDelegateMock()
        let collectionDelegate = MyCollectionViewModelDelegateMock()
        let alertDisplayer = AlertDisplayerMock()
        let primaryButtonDelegate = PrimaryButtonDelegateMock()
        let section = EditProfileSection(
            credentialsConfirmed: true,
            myProfileDelegate: profileDelegate,
            myCollectionDelegate: collectionDelegate,
            alertDisplayer: alertDisplayer,
            primaryButtonDelegate: primaryButtonDelegate
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 5)
        
        guard let titleCellVM = section.cellsVM.first as? TitleCellViewModel,
              let updateProfileButtonCellVM = section.cellsVM[3] as? PrimaryButtonCellViewModel,
              let deleteProfileButtonCellVM = section.cellsVM.last as? PrimaryButtonCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(titleCellVM.title, L10n.updateCredentials)
        XCTAssertEqual(updateProfileButtonCellVM.title, L10n.saveChanges)
        XCTAssertEqual(updateProfileButtonCellVM.buttonType, .classic)
        XCTAssertEqual(deleteProfileButtonCellVM.title, L10n.deleteAccount)
        XCTAssertEqual(deleteProfileButtonCellVM.buttonType, .warning)
        
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
                XCTAssertEqual(emailCellVM.placeholder, L10n.newEmail)
            case .password:
                guard let passwordCellVM = formCellVM as? TextFieldCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(passwordCellVM.placeholder, L10n.newPassword)
            case .collection(_):
                XCTFail("Wrong type")
                return
            }
        }
    }
    
    func test_init_GivenCredentialUnconfirmed_ThenShouldSetPropertiesCorrectly() {
        // Given
        let profileDelegate = MyProfileViewModelDelegateMock()
        let collectionDelegate = MyCollectionViewModelDelegateMock()
        let alertDisplayer = AlertDisplayerMock()
        let primaryButtonDelegate = PrimaryButtonDelegateMock()
        let section = EditProfileSection(
            credentialsConfirmed: false,
            myProfileDelegate: profileDelegate,
            myCollectionDelegate: collectionDelegate,
            alertDisplayer: alertDisplayer,
            primaryButtonDelegate: primaryButtonDelegate
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 4)
        
        guard let titleCellVM = section.cellsVM.first as? TitleCellViewModel,
              let updateProfileButtonCellVM = section.cellsVM.last as? PrimaryButtonCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(titleCellVM.title, L10n.confirmCredentials)
        XCTAssertEqual(updateProfileButtonCellVM.title, L10n.confirm)
        
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
                XCTAssertEqual(emailCellVM.placeholder, L10n.currentEmail)
            case .password:
                guard let passwordCellVM = formCellVM as? TextFieldCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(passwordCellVM.placeholder, L10n.currentPassword)
            case .collection(_):
                XCTFail("Wrong type")
                return
            }
        }
    }
    
    func test_cellTappedCallback_GivenDeleteProfileButtonCellTapped_ThenDisplayBasicAlert() {
        // Given
        let profileDelegate = MyProfileViewModelDelegateMock()
        let collectionDelegate = MyCollectionViewModelDelegateMock()
        let alertDisplayer = AlertDisplayerMock()
        let primaryButtonDelegate = PrimaryButtonDelegateMock()
        let section = EditProfileSection(
            credentialsConfirmed: true,
            myProfileDelegate: profileDelegate,
            myCollectionDelegate: collectionDelegate,
            alertDisplayer: alertDisplayer,
            primaryButtonDelegate: primaryButtonDelegate
        )
        
        guard let deleteProfileButtonCellVM = section.cellsVM.last as? PrimaryButtonCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        // When
        deleteProfileButtonCellVM.cellTappedCallback?()
        
        // Then
        alertDisplayer.verify(
            .presentBasicAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .warning,
                        description: L10n.warningAccountDeletion,
                        cancelButtonTitle: L10n.cancel,
                        okButtonTitle: L10n.confirm
                    )
                )
            )
        )
        
    }
}
