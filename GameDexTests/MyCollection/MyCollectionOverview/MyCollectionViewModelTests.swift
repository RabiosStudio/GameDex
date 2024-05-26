//
//  MyCollectionViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 22/08/2023.
//

import XCTest
@testable import GameDex
import SwiftyMocky

final class MyCollectionViewModelTests: XCTestCase {
    
    // MARK: - Setup
    
    override class func setUp() {
        super.setUp()
        Matcher.default.register(
            ContentViewFactory.self,
            match: Matcher.ContentViewFactory.matcher
        )
    }
    
    // MARK: - Tests
    
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let localDatabase = LocalDatabaseMock()
        let viewModel = MyCollectionViewModel(
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            authenticationService: AuthenticationServiceMock(),
            connectivityChecker: ConnectivityCheckerMock()
        )
        // When
        let numberOfSections = viewModel.numberOfSections()
        let numberOfItems = viewModel.numberOfItems(in: .zero)
        // Then
        XCTAssertEqual(numberOfSections, .zero)
        XCTAssertEqual(numberOfItems, .zero)
        XCTAssertEqual(viewModel.searchViewModel?.placeholder, L10n.searchCollection)
        XCTAssertEqual(viewModel.searchViewModel?.activateOnTap, true)

    }
    
    func test_loadData_GivenUserIsLoggedInAndDatabaseFetchError_ThenShouldSetupButtonItemsCorrectlyAndCallbackShouldReturnFetchError() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .getUserId(willReturn: "randomId")
        )
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
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(
            .getUserCollection(
                userId: .any,
                willReturn: .failure(DatabaseError.fetchError)
            )
        )
        let viewModel = MyCollectionViewModel(
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        
        // When
        await viewModel.loadData { error in            
            // Then
            guard let error = error as? MyCollectionError else {
                XCTFail("Error type is not correct")
                return
            }
            XCTAssertEqual(error, MyCollectionError.fetchError)
            XCTAssertEqual(viewModel.buttonItems, [.add])
        }
    }
    
    func test_loadData_GivenUserIsLoggedInAndEmptyCollectionFetched_ThenShouldSetupButtonItemsCorrectlyAndCallbackShouldReturnNoItems() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .getUserId(willReturn: "randomId")
        )
        authenticationService.given(
            .isUserLoggedIn(
                willReturn: true
            )
        )
        let emptyCollection = [Platform]()
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(
            .getUserCollection(
                userId: .any,
                willReturn: .success(emptyCollection)
            )
        )
        let viewModel = MyCollectionViewModel(
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        var callbackIsCalled = false
        
        // When
        await viewModel.loadData { _ in
            
            // Then
            callbackIsCalled = true
            XCTAssertEqual(emptyCollection, [])
            XCTAssertTrue(callbackIsCalled)
            XCTAssertEqual(viewModel.buttonItems, [.add])
        }
    }
    
    func test_loadData_GivenUserIsLoggedInAndNoError_ThenShouldSetupSectionsAndButtonItemsCorrectly() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .getUserId(willReturn: "randomId")
        )
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
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(
            .getUserCollection(
                userId: .any,
                willReturn: .success(MockData.platforms)
            )
        )
        let viewModel = MyCollectionViewModel(
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        
        // When
        await viewModel.loadData { _ in
            
            // Then
            XCTAssertEqual(viewModel.numberOfItems(in: .zero), MockData.platforms.count)
            XCTAssertEqual(viewModel.buttonItems, [.add])
            
            let itemAvailable = viewModel.itemAvailable(at: IndexPath(row: .zero, section: .zero))
            XCTAssertTrue(itemAvailable)
        }
    }
    
    func test_loadData_GivenUserIsLoggedOutAndDatabaseFetchError_ThenShouldSetupButtonItemsCorrectlyAndCallbackShouldReturnFetchError() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .isUserLoggedIn(
                willReturn: false
            )
        )
        let localDatabase = LocalDatabaseMock()
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let viewModel = MyCollectionViewModel(
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        var callbackIsCalled = false
        localDatabase.given(
            .fetchAllPlatforms(
                willReturn: Result<[PlatformCollected], DatabaseError>.failure(.fetchError)
            )
        )
        
        // When
        await viewModel.loadData { error in
            
            // Then
            callbackIsCalled = true
            guard let error = error as? MyCollectionError else {
                XCTFail("Error type is not correct")
                return
            }
            XCTAssertEqual(error, MyCollectionError.fetchError)
            XCTAssertTrue(callbackIsCalled)
            XCTAssertEqual(viewModel.buttonItems, [.add])
        }
    }
    
    func test_loadData_GivenUserIsLoggedOutAndEmptyCollectionFetched_ThenShouldSetupButtonItemsCorrectlyAndCallbackShouldReturnNoItems() async {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .isUserLoggedIn(
                willReturn: false
            )
        )
        let emptyCollection = [PlatformCollected]()
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(
            .fetchAllPlatforms(
                willReturn: Result<[PlatformCollected], DatabaseError>.success(emptyCollection)
            )
        )
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let viewModel = MyCollectionViewModel(
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        var callbackIsCalled = false
        
        // When
        await viewModel.loadData { _ in
            
            // Then
            callbackIsCalled = true
            XCTAssertEqual(emptyCollection, [])
            XCTAssertTrue(callbackIsCalled)
            XCTAssertEqual(viewModel.buttonItems, [.add])
        }
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
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(
            .fetchAllPlatforms(
                willReturn: Result<[PlatformCollected], DatabaseError>.success(MockData.platformsCollected)
            )
        )
        let viewModel = MyCollectionViewModel(
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
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
                ), count: .once
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
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(
            .fetchAllPlatforms(
                willReturn: Result<[PlatformCollected], DatabaseError>.success(MockData.platformsCollected)
            )
        )
        let viewModel = MyCollectionViewModel(
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
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
                ), count: .once
            )
        }
    }
    
    func test_startSearch_ThenShouldCallCallback() {
        // Given
        let localDatabase = LocalDatabaseMock()
        let viewModel = MyCollectionViewModel(
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
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
    
    func test_updateSearch_GivenListOfCollections_ThenShouldSetupSectionsAndCellsVMAccordingly() async {
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
                willReturn: Result<[PlatformCollected], DatabaseError>.success(MockData.platformsCollected)
            )
        )
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let viewModel = MyCollectionViewModel(
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        
        let platform = CoreDataConverter.convert(platformCollected: MockData.platformsCollected[0])
        
        var callBackIsCalled = false
        
        await viewModel.loadData { _ in
            
            // When
            viewModel.updateSearchTextField(with: "Game Boy") { _ in
                callBackIsCalled = true
                
                // Then
                let expectedItems = platform.games?.filter({
                    $0.game.platformId == 4
                })
                let expectedNumberOfitems = expectedItems?.count
                
                XCTAssertEqual(viewModel.numberOfSections(), 1)
                XCTAssertEqual(viewModel.sections[0].cellsVM.count, expectedNumberOfitems)
                XCTAssertTrue(callBackIsCalled)
            }
        }
    }
    
    func test_updateSearch_GivenNoMatchingCollection_ThenShouldReturnErrorNoItems() async {
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
                willReturn: Result<[PlatformCollected], DatabaseError>.success(MockData.platformsCollected)
            )
        )
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let viewModel = MyCollectionViewModel(
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        
        await viewModel.loadData { _ in
            
            // When
            viewModel.updateSearchTextField(with: "Unknown entry") { error in
                guard let error = error as? MyCollectionError else {
                    XCTFail("Error type is not correct")
                    return
                }
                XCTAssertEqual(error, MyCollectionError.noItems(delegate: viewModel))
            }
        }
    }
    
    func test_updateSearch_GivenEmptySearchQuery_ThenShouldReturnFullListOfCollections() async {
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
                willReturn: Result<[PlatformCollected], DatabaseError>.success(MockData.platformsCollected)
            )
        )
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let viewModel = MyCollectionViewModel(
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        
        let expectedItems = CoreDataConverter.convert(platformsCollected: MockData.platformsCollected)
        
        await viewModel.loadData { _ in
            
            // When
            viewModel.updateSearchTextField(with: "") { _ in
                XCTAssertEqual(viewModel.numberOfSections(), 1)
                XCTAssertEqual(viewModel.numberOfItems(in: 0), expectedItems.count)
            }
        }
    }
    
    func test_reloadCollection_ThenContainerDelegateIsCalled() {
        // Given
        let localDatabase = LocalDatabaseMock()
        let viewModel = MyCollectionViewModel(
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            authenticationService: AuthenticationServiceMock(),
            connectivityChecker: ConnectivityCheckerMock()
        )
        
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        // When
        viewModel.reloadCollection()
        
        containerDelegate.verify(.reloadData(), count: .once)
    }
    
    func test_didTapButtonItem_ThenShouldSetNavigationStyleCorrectly() async {
        // Given
        let localDatabase = LocalDatabaseMock()
        let viewModel = MyCollectionViewModel(
            localDatabase: localDatabase,
            cloudDatabase: CloudDatabaseMock(),
            authenticationService: AuthenticationServiceMock(),
            connectivityChecker: ConnectivityCheckerMock()
        )
        
        // When
        viewModel.didTap(buttonItem: .add)
        
        // Then
        let expectedNavigationStyle: NavigationStyle = {
            return .present(
                screenFactory: SelectPlatformScreenFactory(
                    delegate: viewModel
                ),
                completionBlock: nil
            )
        }()
        let lastNavigationStyle = Routing.shared.lastNavigationStyle
        
        XCTAssertEqual(lastNavigationStyle, expectedNavigationStyle)
    }
    
    func test_cancelButtonTapped_ThenUpdateSectionAndButtonItems() async {
        // Given
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(.getUserCollection(userId: .any, willReturn: .success(MockData.platforms)))
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(.getUserId(willReturn: "user id"))
        authenticationService.given(.isUserLoggedIn(willReturn: true))
        let connectivityChecker = ConnectivityCheckerMock()
        connectivityChecker.given(.hasConnectivity(willReturn: true))
        let viewModel = MyCollectionViewModel(
            localDatabase: LocalDatabaseMock(),
            cloudDatabase: cloudDatabase,
            authenticationService: authenticationService,
            connectivityChecker: connectivityChecker
        )
        
        await viewModel.loadData { _ in
            
            // When
            viewModel.cancelButtonTapped { _ in
                
                // Then
                XCTAssertEqual(viewModel.platforms, MockData.platforms)
                
                let expectedButtonItems: [AnyBarButtonItem]? = [.add]
                XCTAssertEqual(viewModel.buttonItems, expectedButtonItems)
            }
        }
    }
}
