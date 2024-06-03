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
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 9)
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
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.updateSuccessDescription
                    )
                )
            ), count: .once
        )
        containerDelegate.verify(
            .configureSupplementaryView(
                contentViewFactory: .any
            ), count: 2
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
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.updateErrorDescription
                    )
                )
            ), count: .once
        )
        containerDelegate.verify(
            .configureSupplementaryView(
                contentViewFactory: .any
            ), count: 2
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
            .replaceGame(
                userId: .any,
                newGame: .any,
                oldGame: .any,
                platform: .any,
                willReturn: nil
            )
        )
        
        // When
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.updateSuccessDescription
                    )
                )
            ), count: .once
        )
        containerDelegate.verify(
            .configureSupplementaryView(
                contentViewFactory: .any
            ), count: 2
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
            .replaceGame(
                userId: .any,
                newGame: .any,
                oldGame: .any,
                platform: .any,
                willReturn: DatabaseError.replaceError
            )
        )
        
        // When
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.updateErrorDescription
                    )
                )
            ), count: .once
        )
        containerDelegate.verify(
            .configureSupplementaryView(
                contentViewFactory: .any
            ), count: 2
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
                      return cellVM is (any FormCellViewModel)
                  }) as? [any FormCellViewModel] else {
                XCTFail("Wrong type")
                return
            }
            var acquisitionYear: String?
            var rating: Int?
            
            for formCellVM in formCellsVM {
                guard let formType = formCellVM.formType as? GameFormType else { return }
                switch formType {
                case .acquisitionYear:
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
            ), count: 2
        )
    }
    
    func test_enableSaveButton_GivenStringValueChangedWithNil_ThenShouldCallContainerDelegate() {
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
            
            let firstSection = viewModel.sections.first!
            let formCellsVM = firstSection.cellsVM.filter({ cellVM in
                return cellVM is TextFieldCellViewModel
            }) as! [TextFieldCellViewModel]
            
            for formCellVM in formCellsVM {
                guard let formType = formCellVM.formType as? GameFormType else { return }
                switch formType {
                case .acquisitionYear:
                    formCellVM.value = nil
                default:
                    break
                }
            }
        }
        
        // When
        viewModel.enableSaveButtonIfNeeded()
        
        // Then
        containerDelegate.verify(
            .configureSupplementaryView(
                contentViewFactory: .any
            ), count: 3
        )
    }
    
    func test_didTapButtonItem_ThenShouldSetAlertParametersCorrectly() async {
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
        await viewModel.didTap(buttonItem: .delete)
        
        // Then
        alertDisplayer.verify(
            .presentBasicAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .warning,
                        description: L10n.warningRemoveGameDescription
                    )
                )
            ), count: .once
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
            ), count: .once
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
            ), count: .once
        )
        
        containerDelegate.verify(.goBackToPreviousScreen())
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
            ), count: .once
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
            ), count: .once
        )
        containerDelegate.verify(.goBackToPreviousScreen(), count: .once)
    }
    
    func test_didUpdate_GivenCloudNoError_ThenShouldSetAlertParametersCorrectlyAndCallContainerDelegate() async {
        // Given
        let savedGame = MockData.savedGame
        let platform = MockData.platform
        let containerDelegate = ContainerViewControllerDelegateMock()
        let viewModel = EditGameDetailsViewModel(
            savedGame: savedGame,
            platform: platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: AuthenticationServiceMock()
        )
        viewModel.containerDelegate = containerDelegate
        
        // WHEN
        viewModel.didUpdate(value: MockData.editedGameForm.acquisitionYear as Any, for: GameFormType.acquisitionYear)
        viewModel.didUpdate(
            value: MockData.editedGameForm.gameCondition as Any,
            for: GameFormType.gameCondition(
                PickerViewModel(
                    data: [GameCondition.allCases.compactMap {
                        guard $0 != .unknown else {
                            return nil
                        }
                        return $0.value
                    }]
                )
            )
        )
        viewModel.didUpdate(
            value: MockData.editedGameForm.gameCompleteness as Any,
            for: GameFormType.gameCompleteness(
                PickerViewModel(
                    data: [GameCompleteness.allCases.compactMap {
                        guard $0 != .unknown else {
                            return nil
                        }
                        return $0.value
                    }]
                )
            )
        )
        viewModel.didUpdate(
            value: MockData.editedGameForm.gameRegion as Any,
            for: GameFormType.gameRegion(
                PickerViewModel(
                    data: [GameRegion.allCases.map { $0.value }]
                )
            )
        )
        viewModel.didUpdate(value: MockData.editedGameForm.storageArea as Any, for: GameFormType.storageArea)
        viewModel.didUpdate(value: MockData.editedGameForm.rating as Any, for: GameFormType.rating)
        viewModel.didUpdate(value: MockData.editedGameForm.notes as Any, for: GameFormType.notes)
        viewModel.didUpdate(value: MockData.editedGameForm.isPhysical as Any, for: GameFormType.isPhysical)
        
        // THEN
        XCTAssertEqual(viewModel.gameForm.acquisitionYear, MockData.editedGameForm.acquisitionYear)
        XCTAssertEqual(viewModel.gameForm.gameCompleteness, MockData.editedGameForm.gameCompleteness)
        XCTAssertEqual(viewModel.gameForm.gameCondition, MockData.editedGameForm.gameCondition)
        XCTAssertEqual(viewModel.gameForm.gameRegion, MockData.editedGameForm.gameRegion)
        XCTAssertEqual(viewModel.gameForm.storageArea, MockData.editedGameForm.storageArea)
        XCTAssertEqual(viewModel.gameForm.rating, MockData.editedGameForm.rating)
        XCTAssertEqual(viewModel.gameForm.notes, MockData.editedGameForm.notes)
        XCTAssertEqual(viewModel.gameForm.isPhysical, MockData.editedGameForm.isPhysical)
    }
}
