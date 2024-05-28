//
//  CollectionManagementViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 25/10/2023.
//

import XCTest
@testable import GameDex

final class CollectionManagementViewModelTests: XCTestCase {
    
    func test_init_ThenShouldSetupPropertiesCorrectly() async {
        // Given
        let viewModel = CollectionManagementViewModel(
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            cloudDatabase: CloudDatabaseMock(),
            localDatabase: LocalDatabaseMock(),
            authenticationService: AuthenticationServiceMock(),
            alertDisplayer: AlertDisplayerMock()
        )
        await viewModel.didTap(buttonItem: .close)
        // Then
        XCTAssertEqual(viewModel.numberOfSections(), .zero)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), .zero)
    }
    
    func test_loadData_GivenLocalCollectionFetched_ThenSectionsAreUpdated() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllPlatforms(willReturn: .success(MockData.platformsCollected)))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: nil))
        let viewModel = CollectionManagementViewModel(
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            cloudDatabase: CloudDatabaseMock(),
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            alertDisplayer: AlertDisplayerMock()
        )
        
        // When
        await viewModel.loadData { _ in
            
        }
        let item = viewModel.item(at: IndexPath(row: .zero, section: .zero))
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 3)
    }
    
    func test_loadData_GivenEmptyLocalCollectionFetched_ThenSendBackErrorNoItem() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllPlatforms(willReturn: .success([PlatformCollected]())))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: nil))
        let viewModel = CollectionManagementViewModel(
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            cloudDatabase: CloudDatabaseMock(),
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            alertDisplayer: AlertDisplayerMock()
        )
        
        // When
        await viewModel.loadData { error in
            guard let error = error as? MyCollectionError else {
                XCTFail("Wrong type")
                return
            }
            XCTAssertEqual(error, MyCollectionError.noItems(delegate: nil))
        }
    }
    
    func test_loadData_GivenErrorFetchingLocalCollection_ThenSendBackFetchError() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllPlatforms(willReturn: .failure(DatabaseError.fetchError)))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: nil))
        let viewModel = CollectionManagementViewModel(
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            cloudDatabase: CloudDatabaseMock(),
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            alertDisplayer: AlertDisplayerMock()
        )
        
        // When
        await viewModel.loadData { error in
            guard let error = error as? MyCollectionError else {
                XCTFail("Wrong type")
                return
            }
            XCTAssertEqual(error, MyCollectionError.fetchError)
        }
    }
    
    func test_loadData_GivenCloudCollectionFetched_ThenSectionsAreUpdated() async {
        // Given
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(.getUserCollection(userId: .any, willReturn: .success(MockData.platforms)))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: "userId"))
        let viewModel = CollectionManagementViewModel(
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            cloudDatabase: cloudDatabase,
            localDatabase: LocalDatabaseMock(),
            authenticationService: authenticationService,
            alertDisplayer: AlertDisplayerMock()
        )
        
        // When
        await viewModel.loadData { _ in
            
        }
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 3)
    }
    
    func test_loadData_GivenEmptyCloudCollectionFetched_ThenSendBackErrorNoItem() async {
        // Given
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(.getUserCollection(userId: .any, willReturn: .success([Platform]())))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: "userId"))
        let viewModel = CollectionManagementViewModel(
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            cloudDatabase: cloudDatabase,
            localDatabase: LocalDatabaseMock(),
            authenticationService: authenticationService,
            alertDisplayer: AlertDisplayerMock()
        )
        
        // When
        await viewModel.loadData { error in
            guard let error = error as? MyCollectionError else {
                XCTFail("Wrong type")
                return
            }
            XCTAssertEqual(error, MyCollectionError.fetchError)
        }
    }
    
    func test_loadData_GivenErrorFetchingCloudCollection_ThenSendBackFetchError() async {
        // Given
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(.getUserCollection(userId: .any, willReturn: .failure(DatabaseError.fetchError)))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: "userId"))
        let viewModel = CollectionManagementViewModel(
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            cloudDatabase: cloudDatabase,
            localDatabase: LocalDatabaseMock(),
            authenticationService: authenticationService,
            alertDisplayer: AlertDisplayerMock()
        )
        
        // When
        await viewModel.loadData { error in
            guard let error = error as? MyCollectionError else {
                XCTFail("Wrong type")
                return
            }
            XCTAssertEqual(error, MyCollectionError.fetchError)
        }
    }
    
    func test_didTapOkButton_GivenLocalDataFetchedAndNoError_ThenSetupAlertAndDelegatesCorrectly() async {
        // Given
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllPlatforms(willReturn: .success(MockData.platformsCollected)))
        localDatabase.given(.remove(platform: .any, willReturn: nil))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: nil))
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = CollectionManagementViewModel(
            myCollectionDelegate: myCollectionDelegate,
            cloudDatabase: CloudDatabaseMock(),
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            alertDisplayer: alertDisplayer
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        await viewModel.loadData { _ in }
        
        guard let firstSection = viewModel.sections.first,
              let formCellsVM = firstSection.cellsVM.filter({ cellVM in
                  return cellVM is (TextFieldCellViewModel)
              }) as? [TextFieldCellViewModel] else {
            XCTFail("Wrong type")
            return
        }
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? UserAccountFormType else {
                XCTFail("Wrong type")
                return
            }
            switch formType {
            case .collection(_):
                formCellVM.value = ""
            default:
                XCTFail("Wrong type")
                return
            }
        }
        
        // When
        await viewModel.didTapOkButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: "" + L10n.successDeletePlatformDescription
                    )
                )
            ), count: .once
        )
    }
    
    func test_didTapOkButton_GivenCloudDataFetchedAndNoError_ThenSetupAlertAndDelegatesCorrectly() async {
        // Given
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(.getUserCollection(userId: .any, willReturn: .success(MockData.platforms)))
        cloudDatabase.given(.removePlatformAndGames(userId: .any, platform: .any, willReturn: nil))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: "userId"))
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = CollectionManagementViewModel(
            myCollectionDelegate: myCollectionDelegate,
            cloudDatabase: cloudDatabase,
            localDatabase: LocalDatabaseMock(),
            authenticationService: authenticationService,
            alertDisplayer: alertDisplayer
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        await viewModel.loadData { _ in }
        
        guard let firstSection = viewModel.sections.first,
              let formCellsVM = firstSection.cellsVM.filter({ cellVM in
                  return cellVM is (TextFieldCellViewModel)
              }) as? [TextFieldCellViewModel] else {
            XCTFail("Wrong type")
            return
        }
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? UserAccountFormType else {
                XCTFail("Wrong type")
                return
            }
            switch formType {
            case .collection(_):
                formCellVM.value = MockData.platforms[0].title
            default:
                XCTFail("Wrong type")
                return
            }
        }
        
        // When
        await viewModel.didTapOkButton()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .success,
                        description: "\(MockData.platforms[0].title)" + L10n.successDeletePlatformDescription
                    )
                )
            ), count: .once
        )
    }
    
    func test_didTapOkButton_GivenLocalCollectionErrorDeletingPlatform_ThenDisplayErrorAlert() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(.fetchAllPlatforms(willReturn: .success(MockData.platformsCollected)))
        localDatabase.given(.remove(platform: .any, willReturn: DatabaseError.fetchError))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: nil))
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = CollectionManagementViewModel(
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            cloudDatabase: CloudDatabaseMock(),
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            alertDisplayer: alertDisplayer
        )
        
        await viewModel.loadData { _ in }
        
        guard let firstSection = viewModel.sections.first,
              let formCellsVM = firstSection.cellsVM.filter({ cellVM in
                  return cellVM is (TextFieldCellViewModel)
              }) as? [TextFieldCellViewModel] else {
            XCTFail("Wrong type")
            return
        }
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? UserAccountFormType else {
                XCTFail("Wrong type")
                return
            }
            switch formType {
            case .collection(_):
                formCellVM.value = ""
            default:
                XCTFail("Wrong type")
                return
            }
        }
        
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
    
    func test_didTapOkButton_GivenCloudCollectionErrorDeletingPlatform_ThenDisplayErrorAlert() async {
        // Given
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(.getUserCollection(userId: .any, willReturn: .success(MockData.platforms)))
        cloudDatabase.given(.removePlatformAndGames(userId: .any, platform: .any, willReturn: DatabaseError.fetchError))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: "userId"))
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = CollectionManagementViewModel(
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            cloudDatabase: cloudDatabase,
            localDatabase: LocalDatabaseMock(),
            authenticationService: authenticationService,
            alertDisplayer: alertDisplayer
        )
        
        await viewModel.loadData { _ in }
        
        guard let firstSection = viewModel.sections.first,
              let formCellsVM = firstSection.cellsVM.filter({ cellVM in
                  return cellVM is (TextFieldCellViewModel)
              }) as? [TextFieldCellViewModel] else {
            XCTFail("Wrong type")
            return
        }
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? UserAccountFormType else {
                XCTFail("Wrong type")
                return
            }
            switch formType {
            case .collection(_):
                formCellVM.value = MockData.platforms[0].title
            default:
                XCTFail("Wrong type")
                return
            }
        }
        
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
    
    func test_didTapPrimaryButton_GivenDeleteFromCollectionButtonTappedAndUserLoggedOut_ThenAlertParametersAreCorrect() async {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = CollectionManagementViewModel(
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            cloudDatabase: CloudDatabaseMock(),
            localDatabase: LocalDatabaseMock(),
            authenticationService: AuthenticationServiceMock(),
            alertDisplayer: alertDisplayer
        )
        viewModel.isLoggedIn = true
        
        // When
        await viewModel.didTapPrimaryButton(with: L10n.deleteFromCollection)
        
        // Then
        alertDisplayer.verify(
            .presentBasicAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .warning,
                        description: L10n.warningPlatformDeletionCloud
                    )
                )
            ), count: .once
        )
    }
    
    func test_didTapPrimaryButton_GivenDeleteFromCollectionButtonTappedAndUserIsLoggedIn_ThenAlertParametersAreCorrect() async {
        // Given
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = CollectionManagementViewModel(
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            cloudDatabase: CloudDatabaseMock(),
            localDatabase: LocalDatabaseMock(),
            authenticationService: AuthenticationServiceMock(),
            alertDisplayer: alertDisplayer
        )
        viewModel.isLoggedIn = false
        
        // When
        await viewModel.didTapPrimaryButton(with: L10n.deleteFromCollection)
        
        // Then
        alertDisplayer.verify(
            .presentBasicAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .warning,
                        description: L10n.warningPlatformDeletionLocal
                    )
                )
            ), count: .once
        )
    }
}

