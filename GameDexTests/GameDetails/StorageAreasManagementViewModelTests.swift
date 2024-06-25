//
//  StorageAreasManagementViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 25/06/2024.
//

import XCTest
@testable import GameDex
import SwiftyMocky

final class StorageAreasManagementViewModelTests: XCTestCase {
    
    // MARK: Setup
    
    override class func setUp() {
        super.setUp()
        Matcher.default.register(
            AlertViewModel.self,
            match: Matcher.AlertViewModel.matcher
        )
    }
    
    // MARK: Tests
    
    func test_init_ThenShouldNoSectionsAndItems() {
        // Given
        let viewModel = StorageAreasManagementViewModel(
            localDatabase: LocalDatabaseMock(),
            authenticationService: AuthenticationServiceMock(),
            alertDisplayer: AlertDisplayerMock(),
            formDelegate: FormDelegateMock(),
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        // When
        let numberOfSections = viewModel.numberOfSections()
        let numberOfItems = viewModel.numberOfItems(in: .zero)
        // Then
        XCTAssertEqual(numberOfSections, .zero)
        XCTAssertEqual(numberOfItems, .zero)
        XCTAssertEqual(viewModel.buttonItems, [.add])
        XCTAssertNil(viewModel.context)
    }
    
    func test_loadData_GivenLocalDatabaseAndNoError_ThenCallBackIsCalledAndSectionsAreSetCorrectly() {
        // Given
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllStorageAreas(willReturn: .success(MockData.storageAreas)))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: nil))
        let viewModel = StorageAreasManagementViewModel(
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            alertDisplayer: AlertDisplayerMock(),
            formDelegate: FormDelegateMock(),
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        
        var callbackIsCalled = false
        
        // When
        viewModel.loadData { _ in
            callbackIsCalled = true
        }
        
        // Then
        XCTAssertTrue(callbackIsCalled)
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), MockData.storageAreas.count)
    }
    
    func test_loadData_GivenLocalDatabaseAndEmptyStorageAreas_ThenReturnsEmptyStorageAreasError() {
        // Given
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllStorageAreas(willReturn: .success(MockData.emptyStorageAreas)))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: nil))
        let viewModel = StorageAreasManagementViewModel(
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            alertDisplayer: AlertDisplayerMock(),
            formDelegate: FormDelegateMock(),
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        
        // When
        viewModel.loadData { error in
            // Then
            guard let error = error as? StorageAreaManagementError else {
                XCTFail("Error type is not correct")
                return
            }
            XCTAssertEqual(error, StorageAreaManagementError.emptyStorageAreas(delegate: StorageAreasManagementDelegateMock()))
        }
    }
    
    func test_loadData_GivenLocalDatabaseErrorFetchingData_ThenReturnsFetchError() {
        // Given
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllStorageAreas(willReturn: .failure(.fetchError)))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: nil))
        let viewModel = StorageAreasManagementViewModel(
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            alertDisplayer: AlertDisplayerMock(),
            formDelegate: FormDelegateMock(),
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        
        // When
        viewModel.loadData { error in
            // Then
            guard let error = error as? StorageAreaManagementError else {
                XCTFail("Error type is not correct")
                return
            }
            XCTAssertEqual(error, StorageAreaManagementError.fetchError)
        }
    }
    
    func test_didTapAddButtonItem_ThenSetsContextAddAndUpdateSections() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllStorageAreas(willReturn: .success(MockData.storageAreas)))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: nil))
        let viewModel = StorageAreasManagementViewModel(
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            alertDisplayer: AlertDisplayerMock(),
            formDelegate: FormDelegateMock(),
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        viewModel.loadData { _ in }
        
        // When
        viewModel.didTap(buttonItem: .add)
        
        // Then
        XCTAssertEqual(viewModel.context, .add)
        XCTAssertEqual(viewModel.sections.count, 1)
        XCTAssertEqual(viewModel.sections.first?.cellsVM.count, MockData.storageAreas.count + 1)
        
        containerDelegate.verify(
            .reloadSections(emptyError: .any),
            count: .once
        )
    }
    
    func test_delete_ThenShouldSetAlertParametersCorrectly() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllStorageAreas(willReturn: .success(MockData.storageAreas)))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: nil))
        let alertDisplayer = AlertDisplayerMock()
        let gameDetailsDelegate = GameDetailsViewModelDelegateMock()
        let viewModel = StorageAreasManagementViewModel(
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            alertDisplayer: alertDisplayer,
            formDelegate: FormDelegateMock(),
            gameDetailsDelegate: gameDetailsDelegate
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        viewModel.loadData { _ in }
        
        // When
        viewModel.delete(value: MockData.storageAreas.first as Any)
        
        // Then
        alertDisplayer.verify(
            .presentBasicAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .warning,
                        description: L10n.warningStorageAreaDeletion
                    )
                )
            ), count: .once
        )
    }
    
    func test_didTapOkButton_GivenLocalDatabaseAndNoError_ThenShouldSetAlertParametersCorrectlyAndCallContainerDelegate() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllStorageAreas(willReturn: .success(MockData.storageAreas)))
        localDatabase.given(.remove(storageArea: .any, willReturn: nil))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: nil))
        let alertDisplayer = AlertDisplayerMock()
        let gameDetailsDelegate = GameDetailsViewModelDelegateMock()
        let viewModel = StorageAreasManagementViewModel(
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            alertDisplayer: alertDisplayer,
            formDelegate: FormDelegateMock(),
            gameDetailsDelegate: gameDetailsDelegate
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        viewModel.loadData { _ in }
        
        viewModel.delete(value: MockData.storageAreas.first as Any)
        
        // When
        await viewModel.didTapOkButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.successDeletingStorageArea
                    )
                )
            ), count: .once
        )
        gameDetailsDelegate.verify(
            .removeStorageAreaFromGameFormIfNeeded(storageArea: .any),
            count: .once
        )
        XCTAssertNil(viewModel.context)
        containerDelegate.verify(
            .reloadData()
        )
    }
    
    func test_didTapOkButton_GivenLocalDatabaseAndErrorRemovingData_ThenShouldSetAlertParametersCorrectly() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllStorageAreas(willReturn: .success(MockData.storageAreas)))
        localDatabase.given(.remove(storageArea: .any, willReturn: DatabaseError.removeError))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: nil))
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = StorageAreasManagementViewModel(
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            alertDisplayer: alertDisplayer,
            formDelegate: FormDelegateMock(),
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        viewModel.loadData { _ in }
        
        viewModel.delete(value: MockData.storageAreas.first as Any)
        
        // When
        await viewModel.didTapOkButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.errorDeletingStorageArea
                    )
                )
            ), count: .once
        )
        XCTAssertNil(viewModel.context)
    }
    
    func test_edit_ThenShouldSetContextEditAndReloadSectionsAndCallContainerDelegate() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllStorageAreas(willReturn: .success(MockData.storageAreas)))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: nil))
        let viewModel = StorageAreasManagementViewModel(
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            alertDisplayer: AlertDisplayerMock(),
            formDelegate: FormDelegateMock(),
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        viewModel.loadData { _ in }
        
        // When
        viewModel.edit(value: MockData.storageAreas.first as Any)
        
        // Then
        XCTAssertEqual(viewModel.context, .edit(storageArea: MockData.storageAreas[0]))
        XCTAssertEqual(viewModel.sections.first?.cellsVM.count, MockData.storageAreas.count)
        containerDelegate.verify(.reloadSections(emptyError: .any), count: .once)
    }
    
    func test_select_ThenShouldCallFormDelegateAndContainerDelegate() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllStorageAreas(willReturn: .success(MockData.storageAreas)))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: nil))
        let formDelegate = FormDelegateMock()
        let viewModel = StorageAreasManagementViewModel(
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            alertDisplayer: AlertDisplayerMock(),
            formDelegate: formDelegate,
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        viewModel.loadData { _ in }
        
        // When
        viewModel.select(storageArea: MockData.storageAreas[0])
        
        // Then
        formDelegate.verify(.didUpdate(value: .any, for: .any), count: .once)
        formDelegate.verify(.refreshSections(), count: .once)
        containerDelegate.verify(.goBackToPreviousScreen(), count: .once)
    }
    
    func test_confirmChanges_GivenContextEditAndErrorReplacingData_ThenAlertsParametersAreSetCorrectly() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllStorageAreas(willReturn: .success(MockData.storageAreas)))
        localDatabase.given(.replaceStorageArea(oldValue: .any, newValue: .any, willReturn: DatabaseError.replaceError))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: nil))
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = StorageAreasManagementViewModel(
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            alertDisplayer: alertDisplayer,
            formDelegate: FormDelegateMock(),
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        viewModel.loadData { _ in }
        viewModel.context = .edit(storageArea: MockData.storageAreas[.zero])
        
        // When
        await viewModel.confirmChanges(value: "New storage area", for: GameFormType.storageArea)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.errorUpdatingStorageArea
                    )
                )
            ), count: .once
        )
    }
    
    func test_confirmChanges_GivenContextEditAndNoError_ThenAlertsParametersAreSetCorrectlyAndGameDetailsDelegateAndContainerDelegateAreCalled() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllStorageAreas(willReturn: .success(MockData.storageAreas)))
        localDatabase.given(.replaceStorageArea(oldValue: .any, newValue: .any, willReturn: nil))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: nil))
        let alertDisplayer = AlertDisplayerMock()
        let gameDetailsDelegate = GameDetailsViewModelDelegateMock()
        let viewModel = StorageAreasManagementViewModel(
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            alertDisplayer: alertDisplayer,
            formDelegate: FormDelegateMock(),
            gameDetailsDelegate: gameDetailsDelegate
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        viewModel.loadData { _ in }
        viewModel.context = .edit(storageArea: MockData.storageAreas[.zero])
        
        // When
        await viewModel.confirmChanges(value: "New storage area", for: GameFormType.storageArea)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.successUpdatingStorageArea
                    )
                )
            ), count: .once
        )
        gameDetailsDelegate.verify(.editStorageAreaFromGameFormIfNeeded(storageArea: .any))
        XCTAssertNil(viewModel.context)
        containerDelegate.verify(.reloadSections(emptyError: .any), count: .once)
    }
    
    func test_confirmChanges_GivenContextAddAndNoError_ThenAlertsParametersAreSetCorrectlyAndGameDetailsDelegateAndContainerDelegateAreCalled() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllStorageAreas(willReturn: .success(MockData.storageAreas)))
        localDatabase.given(.add(storageArea: .any, willReturn: nil))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: nil))
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = StorageAreasManagementViewModel(
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            alertDisplayer: alertDisplayer,
            formDelegate: FormDelegateMock(),
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        viewModel.loadData { _ in }
        viewModel.context = .add
        
        // When
        await viewModel.confirmChanges(value: "New storage area", for: GameFormType.storageArea)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: L10n.successSavingStorageArea
                    )
                )
            ), count: .once
        )
        XCTAssertNil(viewModel.context)
        containerDelegate.verify(.reloadSections(emptyError: .any), count: .once)
    }
    
    func test_confirmChanges_GivenContextAddErrorSavingData_ThenAlertsParametersAreSetCorrectly() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllStorageAreas(willReturn: .success(MockData.storageAreas)))
        localDatabase.given(.add(storageArea: .any, willReturn: DatabaseError.saveError))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: nil))
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = StorageAreasManagementViewModel(
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            alertDisplayer: alertDisplayer,
            formDelegate: FormDelegateMock(),
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        viewModel.loadData { _ in }
        viewModel.context = .add
        
        // When
        await viewModel.confirmChanges(value: "New storage area", for: GameFormType.storageArea)
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.errorSavingStorageArea
                    )
                )
            ), count: .once
        )
    }
}
