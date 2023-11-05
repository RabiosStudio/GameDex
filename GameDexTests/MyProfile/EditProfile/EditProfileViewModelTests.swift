//
//  EditProfileViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 18/10/2023.
//

import XCTest
@testable import GameDex

final class EditProfileViewModelTests: XCTestCase {
    func test_init_ThenShouldSetupPropertiesCorrectly() {
        // Given
        let viewModel = EditProfileViewModel(
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: AlertDisplayerMock(),
            authenticationService: AuthenticationServiceMock(),
            cloudDatabase: CloudDatabaseMock(),
            credentialsConfirmed: false
        )
        
        // Then
        XCTAssertEqual(viewModel.numberOfSections(), .zero)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), .zero)
    }
    
    func test_loadData_ThenSectionIsUpdated() {
        // Given
        let viewModel = EditProfileViewModel(
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: AlertDisplayerMock(),
            authenticationService: AuthenticationServiceMock(),
            cloudDatabase: CloudDatabaseMock(),
            credentialsConfirmed: false
        )
        
        // When
        viewModel.loadData { _ in }
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 4)
    }
    
    func test_didTapPrimaryButton_GivenSaveChangesButtonTappedAndNoError_ThenAlertParametersAreCorrectAndDelegatesCalled() async {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        let myProfileDelegate = MyProfileViewModelDelegateMock()
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.updateUserEmailAddress(to: .any, cloudDatabase: .any, willReturn: nil))
        authenticationService.given(.updateUserPassword(to: .any, willReturn: nil))
        
        let viewModel = EditProfileViewModel(
            myProfileDelegate: myProfileDelegate,
            myCollectionDelegate: myCollectionDelegate,
            alertDisplayer: alertDisplayer,
            authenticationService: authenticationService,
            cloudDatabase: CloudDatabaseMock(),
            credentialsConfirmed: true
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
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
            case .collection(_):
                return
            }
        }
        
        // When
        await viewModel.didTapPrimaryButton(with: L10n.saveChanges)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.updateSuccessDescription
                    )
                )
            )
        )
        
        myCollectionDelegate.verify(.reloadCollection())
        myProfileDelegate.verify(.reloadMyProfile())
        containerDelegate.verify(.goBackToRootViewController())
    }
    
    func test_didTapPrimaryButton_GivenSaveChangesButtonTappedAndErrorUpdatingUserEmailAddress_ThenAlertParametersAreCorrect() async {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.updateUserEmailAddress(to: .any, cloudDatabase: .any, willReturn: AuthenticationError.saveUserDataError))
        authenticationService.given(.updateUserPassword(to: .any, willReturn: nil))
        
        let viewModel = EditProfileViewModel(
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: alertDisplayer,
            authenticationService: authenticationService,
            cloudDatabase: CloudDatabaseMock(),
            credentialsConfirmed: true
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
            case .collection(_):
                return
            }
        }
        
        // When
        await viewModel.didTapPrimaryButton(with: L10n.saveChanges)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.updateErrorDescription
                    )
                )
            )
        )
    }
    
    func test_didTapPrimaryButton_GivenSaveChangesButtonTappedAndErrorUpdatingPassword_ThenAlertParametersAreCorrect() async {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.updateUserEmailAddress(to: .any, cloudDatabase: .any, willReturn: nil))
        authenticationService.given(.updateUserPassword(to: .any, willReturn: AuthenticationError.saveUserDataError))
        
        let viewModel = EditProfileViewModel(
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: alertDisplayer,
            authenticationService: authenticationService,
            cloudDatabase: CloudDatabaseMock(),
            credentialsConfirmed: true
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
            case .collection(_):
                XCTFail("Wrong type")
                return
            }
        }
        
        // When
        await viewModel.didTapPrimaryButton(with: L10n.saveChanges)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .warning,
                        description: L10n.warningUpdatePassword
                    )
                )
            )
        )
    }
    
    func test_didTapPrimaryButton_GivenConfirmButtonTappedAndNoError_ThenReauthenticateUser() async {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        let myProfileDelegate = MyProfileViewModelDelegateMock()
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.reauthenticateUser(email: .any, password: .any, willReturn: nil))
        
        let viewModel = EditProfileViewModel(
            myProfileDelegate: myProfileDelegate,
            myCollectionDelegate: myCollectionDelegate,
            alertDisplayer: alertDisplayer,
            authenticationService: authenticationService,
            cloudDatabase: CloudDatabaseMock(),
            credentialsConfirmed: false
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
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
            case .collection(_):
                XCTFail("Wrong type")
            }
        }
        
        // When
        await viewModel.didTapPrimaryButton(with: L10n.confirm)
        
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
        containerDelegate.verify(.reloadSections())
    }
    
    func test_didTapPrimaryButton_GivenConfirmButtonTappedAndErrorReauthenticatingUser_ThenAlertParametersAreCorrectAndContainerDelegateCalled() async {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.reauthenticateUser(email: .any, password: .any, willReturn: AuthenticationError.loginError))
        
        let viewModel = EditProfileViewModel(
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: alertDisplayer,
            authenticationService: authenticationService,
            cloudDatabase: CloudDatabaseMock(),
            credentialsConfirmed: false
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
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
            case .collection(_):
                XCTFail("Wrong type")
            }
        }
        
        // When
        await viewModel.didTapPrimaryButton(with: L10n.confirm)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.errorCredentialsDescription
                    )
                )
            )
        )
        containerDelegate.verify(.reloadSections())
    }
    
    func test_didTapPrimaryButton_GivenDeleteAccountButtonTapped_ThenAlertParametersAreCorrect() async {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        //        let authenticationService = AuthenticationServiceMock()
        
        let viewModel = EditProfileViewModel(
            myProfileDelegate: MyProfileViewModelDelegateMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            alertDisplayer: alertDisplayer,
            authenticationService: AuthenticationServiceMock(),
            cloudDatabase: CloudDatabaseMock(),
            credentialsConfirmed: true
        )
        viewModel.loadData { _ in }
        
        // When
        await viewModel.didTapPrimaryButton(with: L10n.deleteAccount)
        
        // Then
        alertDisplayer.verify(
            .presentBasicAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .warning,
                        description: L10n.warningAccountDeletion
                    )
                )
            )
        )
    }
    
    func test_didTapOkButton_GivenAccountDeletedSuccessfully_ThenAlertParametersAreCorrectsAndDelegatedAreCalled() async {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        let myProfileDelegate = MyProfileViewModelDelegateMock()
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(.removeUser(userId: .any, willReturn: nil))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.isUserLoggedIn(willReturn: true))
        authenticationService.given(.deleteUser(cloudDatabase: .any, willReturn: nil))
        
        let viewModel = EditProfileViewModel(
            myProfileDelegate: myProfileDelegate,
            myCollectionDelegate: myCollectionDelegate,
            alertDisplayer: alertDisplayer,
            authenticationService: authenticationService,
            cloudDatabase: cloudDatabase,
            credentialsConfirmed: true
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        // When
        await viewModel.didTapOkButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.successDeleteAccountDescription
                    )
                )
            )
        )
        
        myCollectionDelegate.verify(.reloadCollection())
        myProfileDelegate.verify(.reloadMyProfile())
        containerDelegate.verify(.goBackToRootViewController())
    }
    
    func test_didTapOkButton_GivenErrorDeletingAccount_ThenAlertParametersAreCorrects() async {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        let myProfileDelegate = MyProfileViewModelDelegateMock()
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(.removeUser(userId: .any, willReturn: nil))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.isUserLoggedIn(willReturn: true))
        authenticationService.given(.deleteUser(cloudDatabase: .any, willReturn: AuthenticationError.deleteUserError))
        
        let viewModel = EditProfileViewModel(
            myProfileDelegate: myProfileDelegate,
            myCollectionDelegate: myCollectionDelegate,
            alertDisplayer: alertDisplayer,
            authenticationService: authenticationService,
            cloudDatabase: cloudDatabase,
            credentialsConfirmed: true
        )
        
        // When
        await viewModel.didTapOkButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.errorDeleteAccountDescription
                    )
                )
            )
        )
    }
}
