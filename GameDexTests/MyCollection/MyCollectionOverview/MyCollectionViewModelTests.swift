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
            authenticationService: AuthenticationServiceMock(),
            connectionManager: ConnectionManagerMock()
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
    
    func test_loadData_GivenDatabaseFetchError_ThenCallbackShouldReturnFetchError() {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .userIsLoggedIn(
                willReturn: true
            )
        )
        let localDatabase = LocalDatabaseMock()
        let connectionManager = ConnectionManagerMock()
        connectionManager.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let viewModel = MyCollectionViewModel(
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            connectionManager: connectionManager
        )
        var callbackIsCalled = false
        localDatabase.given(
            .fetchAllPlatforms(
                willReturn: Result<[PlatformCollected], DatabaseError>.failure(.fetchError)
            )
        )
        
        // When
        viewModel.loadData { error in
            
            // Then
            callbackIsCalled = true
            guard let error = error as? MyCollectionError else {
                XCTFail("Error type is not correct")
                return
            }
            XCTAssertEqual(error, MyCollectionError.fetchError)
            XCTAssertTrue(callbackIsCalled)
        }
    }
    
    func test_loadData_GivenEmptyCollectionFetched_ThenCallbackShouldReturnNoItems() {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .userIsLoggedIn(
                willReturn: true
            )
        )
        let emptyCollection = [PlatformCollected]()
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(
            .fetchAllPlatforms(
                willReturn: Result<[PlatformCollected], DatabaseError>.success(emptyCollection)
            )
        )
        let connectionManager = ConnectionManagerMock()
        connectionManager.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let viewModel = MyCollectionViewModel(
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            connectionManager: connectionManager
        )
        var callbackIsCalled = false
        
        // When
        viewModel.loadData { _ in
            
            // Then
            callbackIsCalled = true
            XCTAssertEqual(emptyCollection, [])
            XCTAssertTrue(callbackIsCalled)
        }
    }
    
    func test_loadData_GivenUserIsNotLoggedIn_ThenShouldSetupSupplementaryView() {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .userIsLoggedIn(
                willReturn: false
            )
        )
        let connectionManager = ConnectionManagerMock()
        connectionManager.given(
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
            authenticationService: authenticationService,
            connectionManager: connectionManager
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        // When
        viewModel.loadData { _ in
            
            // Then
            containerDelegate.verify(
                .configureSupplementaryView(
                    contentViewFactory: .any,
                    topView: .value(true)
                )
            )
        }
    }
    
    func test_loadData_GivenUserIsNotConnectedToInternet_ThenShouldSetupSupplementaryView() {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .userIsLoggedIn(
                willReturn: true
            )
        )
        let connectionManager = ConnectionManagerMock()
        connectionManager.given(
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
            authenticationService: authenticationService,
            connectionManager: connectionManager
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        // When
        viewModel.loadData { _ in
            
            // Then
            containerDelegate.verify(
                .configureSupplementaryView(
                    contentViewFactory: .any,
                    topView: .value(true)
                )
            )
        }
    }
    
    func test_startSearch_ThenShouldCallCallback() {
        // Given
        let localDatabase = LocalDatabaseMock()
        let viewModel = MyCollectionViewModel(
            localDatabase: localDatabase,
            authenticationService: AuthenticationServiceMock(),
            connectionManager: ConnectionManagerMock()
        )
        var callbackIsCalled = false
        
        // When
        viewModel.startSearch(from: "nothing") { _ in
            callbackIsCalled = true
        }
        
        // Then
        XCTAssertTrue(callbackIsCalled)
    }
    
    func test_updateSearch_GivenListOfCollections_ThenShouldSetupSectionsAndCellsVMAccordingly() {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .userIsLoggedIn(
                willReturn: true
            )
        )
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(
            .fetchAllPlatforms(
                willReturn: Result<[PlatformCollected], DatabaseError>.success(MockData.platformsCollected)
            )
        )
        let connectionManager = ConnectionManagerMock()
        connectionManager.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let viewModel = MyCollectionViewModel(
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            connectionManager: connectionManager
        )
        
        let platform = CoreDataConverter.convert(platformCollected: MockData.platformsCollected[0])
        
        var callBackIsCalled = false
        
        viewModel.loadData { _ in
            
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
    
    func test_updateSearch_GivenNoMatchingCollection_ThenShouldReturnErrorNoItems() {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .userIsLoggedIn(
                willReturn: true
            )
        )
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(
            .fetchAllPlatforms(
                willReturn: Result<[PlatformCollected], DatabaseError>.success(MockData.platformsCollected)
            )
        )
        let connectionManager = ConnectionManagerMock()
        connectionManager.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let viewModel = MyCollectionViewModel(
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            connectionManager: connectionManager
        )
        
        viewModel.loadData { _ in
            
            // When
            viewModel.updateSearchTextField(with: "Unknown entry") { error in
                guard let error = error as? MyCollectionError else {
                    XCTFail("Error type is not correct")
                    return
                }
                XCTAssertEqual(error, MyCollectionError.noItems)
            }
        }
    }
    
    func test_updateSearch_GivenEmptySearchQuery_ThenShouldReturnFullListOfCollections() {
        // Given
        let authenticationService = AuthenticationServiceMock()
        authenticationService.given(
            .userIsLoggedIn(
                willReturn: true
            )
        )
        let localDatabase = LocalDatabaseMock()
        localDatabase.given(
            .fetchAllPlatforms(
                willReturn: Result<[PlatformCollected], DatabaseError>.success(MockData.platformsCollected)
            )
        )
        let connectionManager = ConnectionManagerMock()
        connectionManager.given(
            .hasConnectivity(
                willReturn: true
            )
        )
        let viewModel = MyCollectionViewModel(
            localDatabase: localDatabase,
            authenticationService: authenticationService,
            connectionManager: connectionManager
        )
        
        let expectedItems = CoreDataConverter.convert(platformsCollected: MockData.platformsCollected)
        let expectedNumberOfitems = expectedItems.count
       
        viewModel.loadData { _ in
            
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
            authenticationService: AuthenticationServiceMock(),
            connectionManager: ConnectionManagerMock()
        )
        
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        // When
        viewModel.reloadCollection()
        
        containerDelegate.verify(.reloadSections())
    }
    
    func test_didTapRightButtonItem_ThenShouldSetNavigationStyleCorrectly() {
        // Given
        let localDatabase = LocalDatabaseMock()
        let viewModel = MyCollectionViewModel(
            localDatabase: localDatabase,
            authenticationService: AuthenticationServiceMock(),
            connectionManager: ConnectionManagerMock()
        )
        
        // When
        viewModel.didTapRightButtonItem()
        
        // Then
        let expectedNavigationStyle: NavigationStyle = {
            return .present(
                screenFactory: SelectAddGameMethodScreenFactory(
                    delegate: viewModel
                ),
                completionBlock: nil
            )
        }()
        let lastNavigationStyle = Routing.shared.lastNavigationStyle
        
        XCTAssertEqual(lastNavigationStyle, expectedNavigationStyle)
    }
}
