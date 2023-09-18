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
            gamesCollection: MockData.savedGames,
            database: DatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        
        // When
        let numberOfSections = viewModel.numberOfSections()
        let numberOfItems = viewModel.numberOfItems(in: .zero)
        
        // Then
        XCTAssertEqual(numberOfSections, .zero)
        XCTAssertEqual(numberOfItems, .zero)
        XCTAssertEqual(viewModel.searchViewModel?.placeholder, L10n.searchGame)
        XCTAssertEqual(viewModel.searchViewModel?.activateOnTap, true)
        
    }
    
    func test_loadData_GivenDataInCollection_ThenCallbackIsCalledAndSectionsAreSetCorrectly() {
        // Given
        let gamesCollection = MockData.savedGames
        let viewModel = MyCollectionByPlatformsViewModel(
            gamesCollection: gamesCollection,
            database: DatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        var callbackIsCalled = false
        
        // When
        viewModel.loadData { _ in
            callbackIsCalled = true
            
            // Then
            XCTAssertTrue(callbackIsCalled)
        }
        
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), gamesCollection.count)
    }
    
    func test_loadData_GivenEmptyCollection_ThenContainerDelegateIsCalled() {
        // Given
        let gamesCollection = [SavedGame]()
        let viewModel = MyCollectionByPlatformsViewModel(
            gamesCollection: gamesCollection,
            database: DatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        // When
        viewModel.loadData { _ in
            
        }
        
        // Then
        containerDelegate.verify(.goBackToRootViewController())
    }
    
    func test_didTapRightButtonItem_ThenShouldSetNavigationStyleCorrectly() {
        // Given
        let viewModel = MyCollectionByPlatformsViewModel(
            gamesCollection: MockData.savedGames,
            database: DatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        
        // When
        viewModel.didTapRightButtonItem()
        
        // Then
        guard let platform = MockData.savedGames.first?.game.platform else {
            return
        }
        let expectedNavigationStyle: NavigationStyle = {
            return .present(
                controller: UINavigationController(
                    rootViewController: SearchGameByTitleScreenFactory(
                        platform: platform,
                        gameDetailsDelegate: viewModel
                    ).viewController
                ),
                completionBlock: nil
            )
        }()
        
        let lastNavigationStyle = Routing.shared.lastNavigationStyle
        
        XCTAssertEqual(lastNavigationStyle, expectedNavigationStyle)
    }
    
    func test_updateSearch_GivenListOfPlatforms_ThenShouldSetupSectionsAndCellsVMAccordingly() {
        // Given
        let gamesCollection = MockData.savedGames
        let viewModel = MyCollectionByPlatformsViewModel(
            gamesCollection: gamesCollection,
            database: DatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        
        viewModel.loadData { _ in
            
            // When
            viewModel.updateSearchTextField(with: MockData.searchGameQuery) { _ in
                
                // Then
                XCTAssertEqual(viewModel.numberOfSections(), 1)
                XCTAssertEqual(viewModel.sections[0].cellsVM.count, gamesCollection.count)
            }
        }
    }
    
    func test_updateSearch_GivenNoMatchingPlatforms_ThenShouldReturnErrorNoItems() {
        // Given
        let viewModel = MyCollectionByPlatformsViewModel(
            gamesCollection: MockData.savedGames,
            database: DatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        
        viewModel.loadData { _ in
            
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
    
    func test_updateSearch_GivenEmptySearchQuery_ThenShouldReturnFullListOfPlatforms() {
        // Given
        let viewModel = MyCollectionByPlatformsViewModel(
            gamesCollection: MockData.savedGames,
            database: DatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        
        viewModel.loadData { _ in
            
            // When
            viewModel.updateSearchTextField(with: "") { _ in
                XCTAssertEqual(viewModel.numberOfSections(), 1)
                XCTAssertEqual(viewModel.numberOfItems(in: 0), MockData.savedGames.count)
            }
        }
    }
    
    func test_startSearch_ThenShouldCallCallback() {
        // Given
        let viewModel = MyCollectionByPlatformsViewModel(
            gamesCollection: MockData.savedGames,
            database: DatabaseMock(),
            alertDisplayer: AlertDisplayerMock(),
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        
        var callbackIsCalled = false
        
        // When
        viewModel.startSearch(from: "nothing") { _ in
            callbackIsCalled = true
        }
        
        // Then
        XCTAssertTrue(callbackIsCalled)
    }
    
    func test_reloadCollection_GivenFetchDataError_ThenResultsInErrorAlert() {
        // Given
        let localDatabase = DatabaseMock()
        localDatabase.given(
            .fetchAll(
                willReturn: Result<[GameCollected], DatabaseError>.failure(.fetchError)
            )
        )
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = MyCollectionByPlatformsViewModel(
            gamesCollection: MockData.savedGames,
            database: localDatabase,
            alertDisplayer: alertDisplayer,
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        
        viewModel.loadData { _ in
            
            // When
            viewModel.reloadCollection()
            
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
    }
    
    func test_reloadCollection_GivenEmptyCollectionFetched_ThenResultsInErrorAlert() {
        // Given
        let emptyCollection = [GameCollected]()
        let localDatabase = DatabaseMock()
        localDatabase.given(
            .fetchAll(
                willReturn: Result<[GameCollected], DatabaseError>.success(emptyCollection)
            )
        )
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = MyCollectionByPlatformsViewModel(
            gamesCollection: [SavedGame](),
            database: localDatabase,
            alertDisplayer: alertDisplayer,
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        // When
        viewModel.reloadCollection()
        
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
    
    func test_reloadCollection_GivenDataFetchedCorrectly_ThenSectionsAreSetAndContainerDelegateCalled() {
        // Given
        let localDatabase = DatabaseMock()
        localDatabase.given(
            .fetchAll(
                willReturn: Result<[GameCollected], DatabaseError>.success(MockData.gamesCollected)
            )
        )
        let alertDisplayer = AlertDisplayerMock()
        let viewModel = MyCollectionByPlatformsViewModel(
            gamesCollection: MockData.savedGames,
            database: localDatabase,
            alertDisplayer: alertDisplayer,
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        let containerDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = containerDelegate
        
        let convertedData = DataConverter.convert(gamesCollected: MockData.gamesCollected)
        
        viewModel.loadData { _ in
            
            // When
            viewModel.reloadCollection()
            
            // Then
            let expectedItems = convertedData.filter({
                $0.game.platform.title.localizedCaseInsensitiveContains("Game Boy")
            })
            let expectedNumberOfitems = expectedItems.count
            
            XCTAssertEqual(viewModel.numberOfSections(), 1)
            XCTAssertEqual(viewModel.sections[0].cellsVM.count, expectedNumberOfitems)
            containerDelegate.verify(.reloadSections())
        }
    }
}
