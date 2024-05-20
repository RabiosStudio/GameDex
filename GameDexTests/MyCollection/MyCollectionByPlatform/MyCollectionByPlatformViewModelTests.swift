//
//  MyCollectionByPlatformViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 17/09/2023.
//

import XCTest
@testable import GameDex

final class MyCollectionByPlatformViewModelTests: XCTestCase {
    
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let viewModel = MyCollectionByPlatformsViewModel(
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: AuthenticationServiceMock(),
            connectivityChecker: ConnectivityCheckerMock()
        )
        
        // Then
        XCTAssertEqual(viewModel.numberOfSections(), .zero)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), .zero)
        XCTAssertEqual(viewModel.searchViewModel?.placeholder, L10n.searchGame)
        XCTAssertEqual(viewModel.searchViewModel?.activateOnTap, true)
    }
    
    func test_loadData_GivenDataInCollection_ThenCallbackIsCalledAndSectionsAreSetCorrectly() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .isUserLoggedIn(
                willReturn: true
            )
        )
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let viewModel = MyCollectionByPlatformsViewModel(
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        var callbackIsCalled = false
        
        // When
        await viewModel.loadData { _ in
            callbackIsCalled = true
            
            // Then
            XCTAssertTrue(callbackIsCalled)
        }
        
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), MockData.games.count)
    }
    
    func test_loadData_GivenEmptyCollection_ThenContainerDelegateIsCalled() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .isUserLoggedIn(
                willReturn: true
            )
        )
        let platform = MockData.platformWithNoGames
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let viewModel = MyCollectionByPlatformsViewModel(
            platform: platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        // When
        await viewModel.loadData { _ in }
        
        // Then
        containerDelegate.verify(.goBackToRootViewController())
    }
    
    func test_loadData_GivenUserIsNotLoggedIn_ThenShouldSetupSupplementaryView() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .isUserLoggedIn(
                willReturn: false
            )
        )
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let platform = MockData.platformWithNoGames
        let viewModel = MyCollectionByPlatformsViewModel(
            platform: platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        // When
        await viewModel.loadData { _ in
            
            // Then
            containerDelegate.verify(
                .configureSupplementaryView(
                    contentViewFactory: .any
                )
            )
        }
    }
    
    func test_loadData_GivenUserIsNotConnectedToInternet_ThenShouldSetupSupplementaryView() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .isUserLoggedIn(
                willReturn: true
            )
        )
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(
            .hasConnectivity(
                willReturn: false
            )
        )
        let platform = MockData.platformWithNoGames
        let viewModel = MyCollectionByPlatformsViewModel(
            platform: platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        // When
        await viewModel.loadData { _ in
            
            // Then
            containerDelegate.verify(
                .configureSupplementaryView(
                    contentViewFactory: .any
                )
            )
        }
    }
    
    func test_didTapRightButtonItem_ThenShouldSetNavigationStyleCorrectly() {
        // Given
        let platform = MockData.platform
        let viewModel = MyCollectionByPlatformsViewModel(
            platform: platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: AuthenticationServiceMock(),
            connectivityChecker: ConnectivityCheckerMock()
        )
        
        // When
        viewModel.didTapRightButtonItem()
        
        // Then
        let expectedNavigationStyle: NavigationStyle = {
            return .present(
                screenFactory: SearchGameByTitleScreenFactory(
                    platform: platform, 
                    progress: DesignSystem.halfProgress,
                    myCollectionDelegate: viewModel
                ),
                completionBlock: nil
            )
        }()
        
        let lastNavigationStyle = Routing.shared.lastNavigationStyle
        
        XCTAssertEqual(lastNavigationStyle, expectedNavigationStyle)
    }
    
    func test_updateSearch_GivenListOfPlatforms_ThenShouldSetupSectionsAndCellsVMAccordingly() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .isUserLoggedIn(
                willReturn: true
            )
        )
        let platform = MockData.platform
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let viewModel = MyCollectionByPlatformsViewModel(
            platform: platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        
        await viewModel.loadData { _ in
            
            // When
            viewModel.updateSearchTextField(with: MockData.searchGameQuery) { _ in
                
                // Then
                XCTAssertEqual(viewModel.numberOfSections(), 1)
                XCTAssertEqual(viewModel.sections[0].cellsVM.count, platform.games?.count)
            }
        }
    }
    
    func test_updateSearch_GivenNoMatchingPlatforms_ThenShouldReturnErrorNoItems() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .isUserLoggedIn(
                willReturn: true
            )
        )
        let platform = MockData.platform
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let viewModel = MyCollectionByPlatformsViewModel(
            platform: platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        
        await viewModel.loadData { _ in
            
            // When
            viewModel.updateSearchTextField(with: "Playstation01") { error in
                guard let error = error as? MyCollectionError else {
                    XCTFail("Error type is not correct")
                    return
                }
                XCTAssertEqual(error, MyCollectionError.noItems)
            }
        }
    }
    
    func test_updateSearch_GivenEmptySearchQuery_ThenShouldReturnFullListOfPlatforms() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .isUserLoggedIn(
                willReturn: true
            )
        )
        let platform = MockData.platform
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let viewModel = MyCollectionByPlatformsViewModel(
            platform: platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        
        await viewModel.loadData { _ in
            
            // When
            viewModel.updateSearchTextField(with: "") { _ in
                XCTAssertEqual(viewModel.numberOfSections(), 1)
                XCTAssertEqual(viewModel.numberOfItems(in: 0), MockData.savedGames.count)
            }
        }
    }
    
    func test_startSearch_ThenShouldCallCallback() {
        // Given
        let platform = MockData.platform
        let viewModel = MyCollectionByPlatformsViewModel(
            platform: platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: AuthenticationServiceMock(),
            connectivityChecker: ConnectivityCheckerMock()
        )
        
        var callbackIsCalled = false
        
        // When
        viewModel.startSearch(from: "nothing") { _ in
            callbackIsCalled = true
        }
        
        // Then
        XCTAssertTrue(callbackIsCalled)
    }
    
    func test_reloadCollection_GivenLocalDatabaseFetchDataError_ThenResultsInErrorAlert() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .isUserLoggedIn(
                willReturn: true
            )
        )
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(
            .fetchAllPlatforms(
                willReturn: Result<[PlatformCollected], DatabaseError>.failure(DatabaseError.fetchError)
            )
        )
        localDatabase.given(
            .getPlatform(
                platformId: .any,
                willReturn: Result<PlatformCollected?, DatabaseError>.failure(DatabaseError.fetchError)
            )
        )
        let alertDisplayer = AlertDisplayerMock()
        let platform = MockData.platform
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let viewModel = MyCollectionByPlatformsViewModel(
            platform: platform,
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        
        await viewModel.loadData { _ in }
        
        // When
        await viewModel.reloadCollection()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.fetchGamesErrorDescription
                    )
                )
            )
        )
    }
    
    func test_reloadCollection_GivenLocalDatabaseEmptyCollectionFetched_ThenResultsInErrorAlert() async {
        // Given
        let emptyCollection = [PlatformCollected]()
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(
            .fetchAllPlatforms(
                willReturn: Result<[PlatformCollected], DatabaseError>.success(emptyCollection)
            )
        )
        localDatabase.given(
            .getPlatform(
                platformId: .any,
                willReturn: Result<PlatformCollected?, DatabaseError>.success(nil)
            )
        )
        let platform = MockData.platformWithNoGames
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = MyCollectionByPlatformsViewModel(
            platform: platform,
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: AuthenticationServiceMock(),
            connectivityChecker: ConnectivityCheckerMock()
        )
        
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        // When
        await viewModel.reloadCollection()
        
        // Then
        containerDelegate.verify(.reloadSections())
    }
    
    func test_reloadCollection_GivenCloudDatabaseFetchDataError_ThenResultsInErrorAlert() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.isUserLoggedIn(willReturn: true))
        authenticationService.given(.getUserId(willReturn: "userId"))
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(
            .getSinglePlatformCollection(
                userId: .any,
                platform: .any,
                willReturn: .failure(DatabaseError.fetchError)
            )
        )
        
        let alertDisplayer = AlertDisplayerMock()
        let platform = MockData.platform
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let viewModel = MyCollectionByPlatformsViewModel(
            platform: platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        
        await viewModel.loadData { _ in }
        
        // When
        await viewModel.reloadCollection()
        
        // Then
        alertDisplayer.verify(
            .presentTopFloatAlert(
                parameters: .value(
                    AlertViewModel(
                        alertType: .error,
                        description: L10n.fetchGamesErrorDescription
                    )
                )
            )
        )
    }
    
    func test_reloadCollection_GivenCloudDatabaseEmptyCollectionFetched_ThenResultsInErrorAlert() async {
        // Given
        let emptyCollection = Platform(title: "title", id: 1, imageUrl: "imageUrl", games: [], supportedNames: ["supported name"])
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.isUserLoggedIn(willReturn: true))
        authenticationService.given(.getUserId(willReturn: "userId"))
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(
            .getSinglePlatformCollection(
                userId: .any,
                platform: .any,
                willReturn: .success(emptyCollection)
            )
        )
        let platform = MockData.platformWithNoGames
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = MyCollectionByPlatformsViewModel(
            platform: platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        // When
        await viewModel.reloadCollection()
        
        // Then
        containerDelegate.verify(.reloadSections())
    }
    
    func test_reloadCollection_GivenCloudDatabaseNoError_ThenSectionsAreSetAndContainerDelegateCalled() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.isUserLoggedIn(willReturn: true))
        authenticationService.given(.getUserId(willReturn: "userId"))
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(
            .getSinglePlatformCollection(
                userId: .any,
                platform: .any,
                willReturn: .success(MockData.platform)
            )
        )
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = MyCollectionByPlatformsViewModel(
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            alertDisplayer: alertDisplayer,
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        await viewModel.loadData { _ in }
        
        // When
        await viewModel.reloadCollection()
        
        // Then
        let expectedNumberOfitems = MockData.platform.games?.count
        
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.sections[0].cellsVM.count, expectedNumberOfitems)
        containerDelegate.verify(.reloadSections())
    }
    
    func test_cancelButtonTapped_ThenUpdateSectionAndRightButtonItems() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: "user id"))
        authenticationService.given(.isUserLoggedIn(willReturn: true))
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(.hasConnectivity(willReturn: true))
        let viewModel = MyCollectionByPlatformsViewModel(
            platform: MockData.platform,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        
        await viewModel.loadData { _ in
            
            // When
            viewModel.cancelButtonTapped { _ in
                
                // Then
                XCTAssertEqual(viewModel.numberOfSections(), 1)
                XCTAssertEqual(viewModel.numberOfItems(in: 0), MockData.platform.games?.count)
                
                let expectedButtonItems: [AnyBarButtonItem]? = [.add, .search]
                XCTAssertEqual(viewModel.rightButtonItems, expectedButtonItems)
            }
        }
    }
    
    func test_cancelButtonTapped_GivenNoGames_ThenCallbackErrorNoItem() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: "user id"))
        authenticationService.given(.isUserLoggedIn(willReturn: true))
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(.hasConnectivity(willReturn: true))
        let viewModel = MyCollectionByPlatformsViewModel(
            platform: MockData.platformWithNoGames,
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: CloudDatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            myCollectionDelegate: MyCollectionViewModelDelegateMock(),
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        
        await viewModel.loadData { _ in
            
            // When
            viewModel.cancelButtonTapped { error in
                guard let error = error as? MyCollectionError else {
                    XCTFail("wrong type")
                    return
                }
                XCTAssertEqual(error, MyCollectionError.noItems)
            }
        }
    }

}
