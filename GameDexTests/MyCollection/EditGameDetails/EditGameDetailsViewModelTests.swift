//
//  EditGameDetailsViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 17/09/2023.
//

import XCTest
@testable import GameDex
import SwiftyMocky

final class EditGameDetailsViewModelTests: XCTestCase {
    
    // MARK: Setup
    
    override class func setUp() {
        super.setUp()
        Matcher.default.register(
            AlertViewModel.self,
            match: Matcher.AlertViewModel.matcher
        )
        Matcher.default.register(
            ContentViewFactory.self,
            match: Matcher.ContentViewFactory.matcher
        )
    }
    
    // MARK: Tests
    
    func test_init_ThenShouldNoSectionsAndItems() {
        // Given
        let viewModel = EditGameDetailsViewModel(
            savedGame: MockData.savedGame,
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: AuthenticationServiceMock()
        )
        // When
        let numberOfSections = viewModel.numberOfSections()
        let numberOfItems = viewModel.numberOfItems(in: .zero)
        // Then
        XCTAssertEqual(numberOfSections, .zero)
        XCTAssertEqual(numberOfItems, .zero)
    }
    
    func test_loadData_ThenCallBackIsCalledAndSectionsAreSetCorrectly() {
        // Given
        let viewModel = EditGameDetailsViewModel(
            savedGame: MockData.savedGame,
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: AuthenticationServiceMock()
        )
        
        var callbackIsCalled = false
        
        // When
        viewModel.loadData { _ in
            callbackIsCalled = true
        }
        
        // Then
        XCTAssertTrue(callbackIsCalled)
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 8)
    }
    
    func test_didTapPrimaryButton_GivenLocalDatabaseNoError_ThenAlertParametersAreCorrect() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        
        let viewModel = EditGameDetailsViewModel(
            savedGame: MockData.savedGame,
            platform: MockData.platform,
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService
        )
        
        authenticationService.given(
            .getUserId(
                willReturn: nil
            )
        )
        
        viewModel.containerDelegate = containerDelegate
        
        viewModel.loadData { _ in }
        
        localDatabase.given(
            .replace(
                savedGame: .any,
                willReturn: nil
            )
        )
        
        // When
        await viewModel.didTapPrimaryButton()
        
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
        containerDelegate.verify(
            .configureSupplementaryView(
                contentViewFactory: .any
            )
        )
    }
    
    func test_didTapPrimaryButton_GivenLocalDatabaseErrorReplacingData_ThenAlertParametersAreCorrect() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        
        let viewModel = EditGameDetailsViewModel(
            savedGame: MockData.savedGame,
            platform: MockData.platform,
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService
        )
        
        authenticationService.given(
            .getUserId(
                willReturn: nil
            )
        )
        
        viewModel.containerDelegate = containerDelegate
        
        viewModel.loadData { _ in }
        
        localDatabase.given(
            .replace(
                savedGame: .any,
                willReturn: DatabaseError.replaceError
            )
        )
        
        // When
        await viewModel.didTapPrimaryButton()
        
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
        containerDelegate.verify(
            .configureSupplementaryView(
                contentViewFactory: .any
            )
        )
    }
    
    func test_didTapPrimaryButton_GivenCloudDatabaseNoError_ThenAlertParametersAreCorrect() async {
        // Given
        let cloudDatabase = CloudDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        
        let viewModel = EditGameDetailsViewModel(
            savedGame: MockData.savedGame,
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService
        )
        
        authenticationService.given(
            .getUserId(
                willReturn: "userId"
            )
        )
        
        viewModel.containerDelegate = containerDelegate
        
        viewModel.loadData { _ in }
        
        cloudDatabase.given(
            .saveGame(
                userId: .any,
                game: .any,
                platform: .any,
                editingEntry: .value(true),
                willReturn: nil
            )
        )
        
        // When
        await viewModel.didTapPrimaryButton()
        
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
        containerDelegate.verify(
            .configureSupplementaryView(
                contentViewFactory: .any
            )
        )
    }
    
    func test_didTapPrimaryButton_GivenCloudDatabaseErrorReplacingData_ThenAlertParametersAreCorrect() async {
        // Given
        let cloudDatabase = CloudDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        
        let viewModel = EditGameDetailsViewModel(
            savedGame: MockData.savedGame,
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService
        )
        
        authenticationService.given(
            .getUserId(
                willReturn: "userId"
            )
        )
        
        viewModel.containerDelegate = containerDelegate
        
        viewModel.loadData { _ in }
        
        cloudDatabase.given(
            .saveGame(
                userId: .any,
                game: .any,
                platform: .any,
                editingEntry: .value(true),
                willReturn: DatabaseError.saveError
            )
        )
        
        // When
        await viewModel.didTapPrimaryButton()
        
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
        containerDelegate.verify(
            .configureSupplementaryView(
                contentViewFactory: .any
            )
        )
    }
    
    func test_enableSaveButton_GivenStringValueChanged_ThenShouldCallContainerDelegate() {
        // Given
        let localDatabase = LocalDatabaseMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        
        let viewModel = EditGameDetailsViewModel(
            savedGame: MockData.savedGame,
            platform: MockData.platform,
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: AuthenticationServiceMock()
        )
        
        viewModel.containerDelegate = containerDelegate
        
        viewModel.loadData { _ in
            
            guard let firstSection = viewModel.sections.first,
                  let formCellsVM = firstSection.cellsVM.filter({ cellVM in
                      return cellVM is (any CollectionFormCellViewModel)
                  }) as? [any CollectionFormCellViewModel] else {
                XCTFail("Wrong type")
                return
            }
            var acquisitionYear: String?
            var rating: Int?
            
            for formCellVM in formCellsVM {
                guard let formType = formCellVM.formType as? GameFormType else { return }
                switch formType {
                case .yearOfAcquisition:
                    acquisitionYear = formCellVM.value as? String
                    acquisitionYear = "2023"
                case .rating:
                    rating = formCellVM.value as? Int
                    rating = 3
                default:
                    break
                }
            }
        }
        viewModel.enableSaveButtonIfNeeded()
        
        // Then
        containerDelegate.verify(
            .configureSupplementaryView(
                contentViewFactory: .any
            )
        )
    }
    
    func test_didTapRightButtonItem_ThenShouldSetAlertParametersCorrectly() {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = EditGameDetailsViewModel(
            savedGame: MockData.savedGame,
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: AuthenticationServiceMock()
        )
        
        // When
        viewModel.didTapRightButtonItem()
        
        // Then
        alertDisplayer.verify(
            .presentBasicAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .warning,
                        description: L10n.warningRemoveGameDescription,
                        cancelButtonTitle: L10n.cancel,
                        okButtonTitle: L10n.confirm
                    )
                )
            )
        )
    }
    
    func test_didTapOkButton_GivenLocalRemoveDataError_ThenShouldSetAlertParametersCorrectlyAndCallContainerDelegate() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        let viewModel = EditGameDetailsViewModel(
            savedGame: MockData.savedGame,
            platform: MockData.platform,
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService
        )
        viewModel.containerDelegate = containerDelegate
        viewModel.alertDelegate = viewModel
        
        authenticationService.given(
            .getUserId(
                willReturn: nil
            )
        )
        
        localDatabase.given(
            .remove(
                savedGame: .any,
                willReturn: DatabaseError.removeError
            )
        )
        
        // When
        await viewModel.didTapOkButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.removeGameErrorDescription
                    )
                )
            )
        )
    }
    
    func test_didTapOkButton_GivenLocalNoError_ThenShouldSetAlertParametersCorrectlyAndCallContainerDelegate() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        let viewModel = EditGameDetailsViewModel(
            savedGame: MockData.savedGame,
            platform: MockData.platform,
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService
        )
        viewModel.containerDelegate = containerDelegate
        viewModel.alertDelegate = viewModel
        
        authenticationService.given(
            .getUserId(
                willReturn: nil
            )
        )
        
        localDatabase.given(
            .remove(
                savedGame: .any,
                willReturn: nil
            )
        )
        
        // When
        await viewModel.didTapOkButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.removeGameSuccessDescription
                    )
                )
            )
        )
        
        containerDelegate.verify(.goBackToRootViewController())
    }
    
    func test_didTapOkButton_GivenCloudRemoveDataError_ThenShouldSetAlertParametersCorrectlyAndCallContainerDelegate() async {
        // Given
        let savedGame = MockData.savedGame
        let platform = MockData.platform
        let cloudDatabase = CloudDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        let viewModel = EditGameDetailsViewModel(
            savedGame: savedGame,
            platform: platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService
        )
        viewModel.containerDelegate = containerDelegate
        viewModel.alertDelegate = viewModel
        
        authenticationService.given(
            .getUserId(
                willReturn: "userId"
            )
        )
        
        cloudDatabase.given(
            .removeGame(
                userId: .any,
                platform: .value(platform),
                savedGame: .value(savedGame),
                willReturn: DatabaseError.removeError
            )
        )
        
        // When
        await viewModel.didTapOkButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.removeGameErrorDescription
                    )
                )
            )
        )
    }
    
    func test_didTapOkButton_GivenCloudNoError_ThenShouldSetAlertParametersCorrectlyAndCallContainerDelegate() async {
        // Given
        let savedGame = MockData.savedGame
        let platform = MockData.platform
        let cloudDatabase = CloudDatabaseMock()
        let authenticationService = AuthenticationServiceMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        let viewModel = EditGameDetailsViewModel(
            savedGame: savedGame,
            platform: platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService
        )
        viewModel.containerDelegate = containerDelegate
        viewModel.alertDelegate = viewModel
        
        authenticationService.given(
            .getUserId(
                willReturn: "userId"
            )
        )
        
        cloudDatabase.given(
            .removeGame(
                userId: .any,
                platform: .value(platform),
                savedGame: .value(savedGame),
                willReturn: nil
            )
        )
        
        // When
        await viewModel.didTapOkButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.removeGameSuccessDescription
                    )
                )
            )
        )
        containerDelegate.verify(.goBackToRootViewController())
    }
}

