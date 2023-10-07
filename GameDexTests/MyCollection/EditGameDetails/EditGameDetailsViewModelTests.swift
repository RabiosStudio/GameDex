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
            platformName: MockData.platform.title,
            localDatabase: LocalDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
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
            platformName: MockData.platform.title,
            localDatabase: LocalDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
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
    
    func test_didTapPrimaryButton_GivenNoError_ThenAlertParametersAreCorrect() {
        // Given
        let expectation = XCTestExpectation()
        let localDatabase = LocalDatabaseMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        
        let viewModel = EditGameDetailsViewModel(
            savedGame: MockData.savedGame,
            platformName: MockData.platform.title,
            localDatabase: localDatabase,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        viewModel.containerDelegate = containerDelegate
        
        viewModel.loadData { _ in
            localDatabase.perform(
                .replace(
                    savedGame: .any,
                    callback: .any,
                    perform: { replaceGame, completion in
                        completion(nil)
                        
                        // Then
                        alertDisplayer.verify(
                            .presentTopFloatAlert(
                                parameters: .value(
                                    AlertViewModel(
                                        alertType: .success,
                                        description: L10n.updateGameSuccessDescription
                                    )
                                )
                            )
                        )
                        containerDelegate.verify(
                            .configureSupplementaryView(
                                contentViewFactory: .any,
                                topView: .any
                            )
                        )
                        expectation.fulfill()
                    }
                )
            )
        }
        viewModel.didTapPrimaryButton()
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func test_didTapPrimaryButton_GivenErrorReplacingData_ThenAlertParametersAreCorrect() {
        // Given
        let expectation = XCTestExpectation()
        let localDatabase = LocalDatabaseMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        
        let viewModel = EditGameDetailsViewModel(
            savedGame: MockData.savedGame,
            platformName: MockData.platform.title,
            localDatabase: localDatabase,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        viewModel.containerDelegate = containerDelegate
        
        viewModel.loadData { _ in
            localDatabase.perform(
                .replace(
                    savedGame: .any,
                    callback: .any,
                    perform: { replaceGame, completion in
                        completion(DatabaseError.replaceError)
                        
                        // Then
                        alertDisplayer.verify(
                            .presentTopFloatAlert(
                                parameters: .value(
                                    AlertViewModel(
                                        alertType: .error,
                                        description: L10n.updateGameErrorDescription
                                    )
                                )
                            )
                        )
                        containerDelegate.verify(
                            .configureSupplementaryView(
                                contentViewFactory: .any,
                                topView: .any
                            )
                        )
                        expectation.fulfill()
                    }
                )
            )
        }
        viewModel.didTapPrimaryButton()
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func test_enableSaveButton_GivenStringValueChanged_ThenShouldCallContainerDelegate() {
        // Given
        let localDatabase = LocalDatabaseMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        
        let viewModel = EditGameDetailsViewModel(
            savedGame: MockData.savedGame,
            platformName: MockData.platform.title,
            localDatabase: localDatabase,
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
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
                contentViewFactory: .any,
                topView: .any
            )
        )
    }
    
    func test_didTapRightButtonItem_ThenShouldSetAlertParametersCorrectly() {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = EditGameDetailsViewModel(
            savedGame: MockData.savedGame,
            platformName: MockData.platform.title,
            localDatabase: LocalDatabaseMock(),
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
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
    
    func test_didTapOkButton_GivenRemoveDataError_ThenShouldSetAlertParametersCorrectlyAndCallContainerDelegate() {
        // Given
        let expectation = XCTestExpectation()
        let localDatabase = LocalDatabaseMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        let viewModel = EditGameDetailsViewModel(
            savedGame: MockData.savedGame,
            platformName: MockData.platform.title,
            localDatabase: localDatabase,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        viewModel.containerDelegate = containerDelegate
        viewModel.alertDelegate = viewModel
        
        localDatabase.perform(
            .remove(
                savedGame: .any,
                callback: .any,
                perform: { aSavedGame, completion in
                    completion(DatabaseError.removeError)
                    
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
                    containerDelegate.verify(
                        .configureSupplementaryView(
                            contentViewFactory: .any,
                            topView: .any
                        )
                    )
                    expectation.fulfill()
                }
            )
        )
        // When
        viewModel.didTapOkButton()
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func test_didTapOkButton_GivenNoError_ThenShouldSetAlertParametersCorrectlyAndCallContainerDelegate() {
        // Given
        let expectation = XCTestExpectation()
        let localDatabase = LocalDatabaseMock()
        let alertDisplayer = AlertDisplayerMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        let viewModel = EditGameDetailsViewModel(
            savedGame: MockData.savedGame,
            platformName: MockData.platform.title,
            localDatabase: localDatabase,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        viewModel.containerDelegate = containerDelegate
        viewModel.alertDelegate = viewModel
        
        localDatabase.perform(
            .remove(
                savedGame: .any,
                callback: .any,
                perform: { aSavedGame, completion in
                    completion(nil)
                    
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
                    containerDelegate.verify(
                        .goBackToRootViewController()
                    )
                    expectation.fulfill()
                }
            )
        )
        // When
        viewModel.didTapOkButton()
        wait(for: [expectation], timeout: Constants.timeout)
    }
}
